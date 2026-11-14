SELECT
    e.left_operand,
    e.operator,
    e.right_operand,
    CASE
        WHEN e.operator = '<' AND l.value < r.value THEN 'true'
        WHEN e.operator = '>' AND l.value > r.value THEN 'true'
        WHEN e.operator = '=' AND l.value = r.value THEN 'true'
        ELSE 'false'
    END AS value
FROM Expressions AS e
JOIN Variables AS l ON e.left_operand = l.name
JOIN Variables AS r ON e.right_operand = r.name;
