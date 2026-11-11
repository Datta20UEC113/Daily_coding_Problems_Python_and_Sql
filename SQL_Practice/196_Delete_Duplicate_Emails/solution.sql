-- 196 — Delete Duplicate Emails
DELETE FROM Person AS p
USING Person AS p1
WHERE p.Email = p1.Email
  AND p.Id > p1.Id;
