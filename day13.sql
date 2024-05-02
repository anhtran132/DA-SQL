-- bai 1
-- bai 2
-- bai 3
SELECT COUNT(policy_holder_id) FROM
(SELECT policy_holder_id, COUNT(policy_holder_id) AS policy_holder_count  FROM callers
GROUP BY policy_holder_id
HAVING  COUNT(policy_holder_id) >= 3) AS t1
-- bai 4
SELECT p1.page_id FROM pages AS p1
LEFT JOIN page_likes AS p2 
ON p1.page_id = p2.page_id
WHERE liked_date IS NULL
ORDER BY page_id;
-- bai 5
-- bai 6
-- bai 7
-- bai 8  
-- bai 9
-- bai 10
-- bai 11
-- bai 12
-- NOTES : Minh se hoanh thanh buổi 13, 14 trong ngay 5/3 do 2/5 mình bận chưa thể hoàn thành buổi 13. Cảm ơn bạn.

