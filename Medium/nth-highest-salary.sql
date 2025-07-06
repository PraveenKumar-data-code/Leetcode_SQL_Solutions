CREATE FUNCTION getNthHighestSalary(N INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE ans INT;
    IF N <= 0 THEN 
        RETURN NULL;
    ELSE
        SELECT salary
        INTO ans
        FROM (
            SELECT DISTINCT NTH_VALUE(salary, N) OVER(ORDER BY salary DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS salary
            FROM (SELECT DISTINCT salary FROM employee) a
        ) AS ranked_salaries
        ;
        
        RETURN ans;
    END IF;
END;