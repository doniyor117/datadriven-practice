WITH first_last_days AS(
  SELECT
    ad_campaign,
    DATE_TRUNC('day', MIN(impression_time)) AS first_day,
    DATE_TRUNC('day', MAX(impression_time)) AS last_day,
    COUNT(impression_time) AS total_imps
  FROM ad_impressions
  GROUP BY ad_campaign)
  
SELECT
  a.ad_campaign,
  COUNT(CASE WHEN DATE_TRUNC('day', a.impression_time) = d.first_day THEN 1 END)::numeric * 100 / d.total_imps AS first_day_pct,
  COUNT(CASE WHEN DATE_TRUNC('day', a.impression_time) = d.last_day THEN 1 END)::numeric * 100 / d.total_imps AS last_day_pct
FROM ad_impressions a
JOIN first_last_days d
USING (ad_campaign)
GROUP BY ad_campaign
ORDER BY ad_campaign;
