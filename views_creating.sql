--Самые дорогостоящие команды
create view most_valuable_teams as
select team, sum(marketvalue) as totalvalue
from player p 
group by team
order by totalvalue desc


--Самые посещаемые стадионы
create view most_attented_stadiums as
SELECT stadium, Round(AVG(attendance), 0) AS average_attendance
FROM worldcup."match"
GROUP BY stadium
ORDER BY average_attendance desc



--Расположение сборной России
create view russia_team_location as
select city, start_date, finish_date 
from teamlocation t 
where team='Russia'



--Матчи сборной России
create view russia_team_matches as
select case when home_team='Russia' then guest_team
	else home_team 
	end as opponent,
	stadium 
from "match" m 
where home_team ='Russia' or guest_team = 'Russia'

