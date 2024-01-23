----Y-on-Y Growth Rate [Wayfair SQL Interview Question]
WITH SpendData AS (
    SELECT EXTRACT(YEAR FROM transaction_date) AS transaction_year, product_id, SUM(spend) AS total_spend
    FROM user_transactions
    GROUP BY EXTRACT(YEAR FROM transaction_date), product_id)
SELECT
    s1.transaction_year AS year,
    s1.product_id,
    s1.total_spend AS current_year_spend,
    LAG(s1.total_spend) OVER (PARTITION BY s1.product_id ORDER BY s1.transaction_year) AS previous_year_spend,
    ROUND( (s1.total_spend - LAG(s1.total_spend) OVER (PARTITION BY s1.product_id ORDER BY s1.transaction_year)) /
        LAG(s1.total_spend) OVER (PARTITION BY s1.product_id ORDER BY s1.transaction_year) * 100, 2) AS year_on_year_growth
FROM SpendData s1
ORDER BY s1.product_id, s1.transaction_year;

----Card Launch Success [JPMorgan Chase SQL Interview Question]
WITH EarliestCardRecords AS (
    SELECT card_name, issue_month, issue_year, issued_amount,
        ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS row_num
    FROM monthly_cards_issued)
SELECT card_name,
    COUNT(*) AS cards_issued_in_launch_month
FROM EarliestCardRecords
WHERE row_num = 1
GROUP BY card_name
ORDER BY cards_issued_in_launch_month DESC;

----User's Third Transaction [Uber SQL Interview Question]
WITH RankedTransactions AS (
    SELECT user_id, spend, transaction_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS transaction_rank
    FROM transactions)
SELECT user_id, spend, transaction_date
FROM RankedTransactions
WHERE  transaction_rank = 3;

----Histogram of Users and Purchases [Walmart SQL Interview Question]

WITH RecentTransaction AS (
    SELECT user_id, MAX(transaction_date) AS most_recent_date
    FROM user_transactions
    WHERE transaction_date >= '2022-11-10'
    GROUP BY user_id)
SELECT rt.most_recent_date, ut.user_id,
    COUNT(DISTINCT ut.product_id) AS num_products
FROM RecentTransaction rt
JOIN user_transactions ut ON rt.user_id = ut.user_id AND rt.most_recent_date = ut.transaction_date
GROUP BY rt.most_recent_date, ut.user_id
ORDER BY rt.most_recent_date;

----Tweets' Rolling Averages [Twitter SQL Interview Question]

WITH RollingAverage AS (
    SELECT user_id, tweet_date, tweet_count,
    AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_tweet_count
    FROM tweets)
SELECT user_id, tweet_date,
    ROUND(avg_tweet_count, 2) AS rolling_average
FROM RollingAverage
ORDER BY user_id, tweet_date;
-----Highest-Grossing Items [Amazon SQL Interview Question]
SELECT category, product, SUM(spend) AS total_spend
FROM product_spend
WHERE
    EXTRACT(year FROM transaction_date) = 2022
GROUP BY category, product;

-----Top 5 Artists [Spotify SQL Interview Question]
WITH RankedArtists AS (SELECT a.artist_id, a.artist_name, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC, a.artist_id) AS artist_rank
    FROM global_song_rank gsr
    JOIN songs s ON gsr.song_id = s.song_id
    JOIN artists a ON s.artist_id = a.artist_id
    WHERE gsr.rank <= 10
    GROUP BY a.artist_id, a.artist_name)
SELECT  artist_name, artist_rank
FROM RankedArtists
WHERE artist_rank <= 5
ORDER BY artist_rank;

----Repeated Payments [Stripe SQL Interview Question]
WITH RepeatedPayments AS (
    SELECT transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp,
        LAG(transaction_timestamp) OVER (PARTITION BY merchant_id, credit_card_id ORDER BY transaction_timestamp) AS prev_timestamp
    FROM transactions)
SELECT COUNT(transaction_id) AS repeated_payments_count
FROM RepeatedPayments
WHERE EXTRACT(EPOCH FROM (transaction_timestamp - prev_timestamp)) <= 600
    AND prev_timestamp IS NOT NULL;
