-- Вывести суммарное количество титулов ЧМ среди всех участников данного ЧМ
SELECT SUM(titles)
FROM worldcup.team


-- Вывести города с населением меньше 1 млн человек, отсортированные по убыванию населения
SELECT *
FROM worldcup.city
WHERE population < 1000000
ORDER BY population desc


-- Вывести количество матчей, сыгранных на каждом из стадионов
SELECT stadium, COUNT(*) as match_count
FROM worldcup."match"
GROUP BY stadium


-- Топ 5 самых посещаемых стадионов (в среднем)
SELECT stadium, AVG(attendance) AS average_attendance
FROM worldcup."match"
GROUP BY stadium
ORDER BY average_attendance desc
LIMIT 5;


-- Средняя заполняемость каждого стадиона, %
SELECT
    m.stadium,
    ROUND(AVG(m.attendance) / s.capacity * 100, 1) AS attendance_capacity_ratio
FROM worldcup."match" m
JOIN worldcup.stadium s ON m.stadium = s.name
GROUP BY m.stadium, s.capacity


-- Топ 10 самых дорогостоящих футболистов из команд, которые никогда не выигрывали ЧМ
SELECT p.name, marketvalue
FROM worldcup.player p
JOIN worldcup.team t ON p.team = t."name"
WHERE titles = 0
ORDER BY marketvalue DESC
LIMIT 10

-- Где базировалась сборная России 14 июня 2018 года
SELECT city
FROM worldcup.teamlocation
WHERE team = 'Russia'
AND '2018-06-14' BETWEEN start_date AND finish_date;

-- Какие команды базировались в Москве 1 июля 2018 года
SELECT team
FROM worldcup.teamlocation
WHERE '2018-07-01' BETWEEN start_date AND finish_date
AND city = 'Moscow';


-- Стадионы, расположенные в городах, где > 1 стадиона
SELECT name AS stadium, city, capacity
FROM worldcup.stadium
WHERE city IN (
    SELECT city
    FROM worldcup.stadium
    GROUP BY city
    HAVING COUNT(*) > 1
);


-- Судьи, которые судили матчи в городах с населением > 1'200'000 чел.
-- Вывести имя судьи, город проведения матча, команды, участвующие в 
-- матче и его результат
SELECT DISTINCT r.name AS referee, c.name AS city, m.home_team, m.guest_team, m.result
FROM worldcup.match m
JOIN worldcup.referee r ON m.referee = r.name
JOIN worldcup.stadium s ON m.stadium = s.name
JOIN worldcup.city c ON s.city = c.name
WHERE c.population > 1200000;


-- Города, где были судьи старше 40 лет
SELECT DISTINCT s.city
FROM worldcup.match m
JOIN worldcup.referee r ON m.referee = r.name
JOIN worldcup.stadium s ON m.stadium = s.name
WHERE s.city IN (
    SELECT s.city
    FROM worldcup.match m
    JOIN worldcup.referee r ON m.referee = r.name
    JOIN worldcup.stadium s ON m.stadium = s.name
    WHERE r.age > 40
);


-- Игроки из Португалии и России, разделенные по странам, отранжированные
-- внутри страны по трансферной стоимости
SELECT
    name, 
    marketvalue, 
    team,
    ROW_NUMBER() OVER(PARTITION BY team ORDER BY marketvalue DESC) AS rank
FROM 
    worldcup.player
WHERE 
    team IN ('Russia', 'Portugal');