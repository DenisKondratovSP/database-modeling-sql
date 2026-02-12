--Возвращает стоимость футболиста
create function get_market_value(text)
returns integer
as $$
  select marketvalue
  from player
  where name = $1
$$ language SQL



--Возвращает исход матча между командами 1 и 2
create function get_match_result(text, text)
returns text
as $$
select "result"
from "match"
where home_team=$1 and guest_team=$2
$$ language SQL



--Возвращает местоположение команды в указанный день
create function get_location(text, date)
returns text
as $$
SELECT city
FROM teamlocation
WHERE team = $1
AND $2 BETWEEN start_date AND finish_date
$$ language SQL
