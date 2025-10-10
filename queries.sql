WITH average_gpa AS(
	SELECT AVG(gpa) AS avg_gpa
	FROM grades)
SELECT s.name, g.gpa, a.age, t.city, s.id, c.year
FROM students s
LEFT JOIN  grades g ON s.id=g.id
LEFT JOIN ages a ON s.id=a.id
LEFT JOIN towns t ON s.id=t.id
LEFT JOIN courses c ON s.id=c.id
JOIN average_gpa av
WHERE g.gpa >(SELECT avg_gpa
FROM average_gpa)
GROUP BY t.city, c.year, s.name, g.gpa, a.age, s.id
HAVING age>18
ORDER BY id
LIMIT 2;


# I created CTE to finded students whos gpa is more than average gpa 
# and their age is more than 18 and group by city, year, name, gpa and age