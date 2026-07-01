---- Osa 1: Duplikaadid — Topeltridade Tuvastamine---
-- Leia duplikaatsed sale_id väärtused
SELECT
    sale_id,
    COUNT(*) AS koopiate_arv
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
