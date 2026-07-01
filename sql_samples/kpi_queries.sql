-- KPI SQL examples for a crypto investment alert service concept.
-- These queries are written for portfolio purposes with hypothetical tables.

-- 1. Alert click-through rate by alert type
SELECT
    a.alert_type,
    COUNT(DISTINCT a.alert_id) AS sent_alerts,
    COUNT(DISTINCT c.alert_id) AS clicked_alerts,
    ROUND(
        COUNT(DISTINCT c.alert_id) * 100.0 / NULLIF(COUNT(DISTINCT a.alert_id), 0),
        2
    ) AS click_rate_pct
FROM alerts a
LEFT JOIN alert_clicks c
    ON a.alert_id = c.alert_id
WHERE a.sent_at >= '2026-06-01'
GROUP BY a.alert_type
ORDER BY click_rate_pct DESC;


-- 2. Return rate within 24 hours after alert
SELECT
    a.alert_type,
    COUNT(DISTINCT a.user_id) AS alerted_users,
    COUNT(DISTINCT s.user_id) AS returned_users,
    ROUND(
        COUNT(DISTINCT s.user_id) * 100.0 / NULLIF(COUNT(DISTINCT a.user_id), 0),
        2
    ) AS return_rate_24h_pct
FROM alerts a
LEFT JOIN app_sessions s
    ON a.user_id = s.user_id
   AND s.session_start_at BETWEEN a.sent_at AND a.sent_at + INTERVAL '24 hours'
WHERE a.sent_at >= '2026-06-01'
GROUP BY a.alert_type
ORDER BY return_rate_24h_pct DESC;


-- 3. AI briefing view rate after watchlist registration
SELECT
    w.asset_symbol,
    COUNT(DISTINCT w.user_id) AS watchlist_users,
    COUNT(DISTINCT b.user_id) AS briefing_view_users,
    ROUND(
        COUNT(DISTINCT b.user_id) * 100.0 / NULLIF(COUNT(DISTINCT w.user_id), 0),
        2
    ) AS briefing_view_rate_pct
FROM watchlist w
LEFT JOIN ai_briefing_views b
    ON w.user_id = b.user_id
   AND w.asset_symbol = b.asset_symbol
   AND b.viewed_at >= w.created_at
WHERE w.created_at >= '2026-06-01'
GROUP BY w.asset_symbol
ORDER BY briefing_view_rate_pct DESC;


-- 4. Risk checklist usage by asset
SELECT
    r.asset_symbol,
    COUNT(DISTINCT r.user_id) AS checklist_users
FROM risk_checklist_views r
WHERE r.viewed_at >= '2026-06-01'
GROUP BY r.asset_symbol
ORDER BY checklist_users DESC;
