--Проверяет, что население города больше 0
CREATE OR REPLACE FUNCTION check_population() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.population <= 0 THEN
        RAISE EXCEPTION 'population should be greater then 0';
    END IF;
    return new;
END
$$ LANGUAGE plpgsql;


create or replace trigger check_population before insert or update on city
for each row execute function check_population()




--Проверяет, что посещаемость матча не больше вместимости стадиона
CREATE OR REPLACE FUNCTION check_attendance() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.attendance > (
    select capacity
    from stadium
    where name = NEW.stadium
    ) THEN
        RAISE EXCEPTION 'attendance should be less then capacity of the stadium ()';
    END IF;
    return new;
END
$$ LANGUAGE plpgsql;

create or replace trigger check_attendance before insert or update on match
for each row execute function check_attendance()



--Проверяет, что местоположение команды в этот промежуток времени ещё не добавлено
CREATE OR REPLACE FUNCTION check_location() 
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
    select 1
    from teamlocation
    where team = NEW.team
    AND ((NEW.start_date BETWEEN start_date and finish_date)
    OR (NEW.finish_date BETWEEN start_date and finish_date))
    ) THEN
        RAISE EXCEPTION 'this time period has already been added for the team';
    END IF;
    return new;
END
$$ LANGUAGE plpgsql;

create or replace trigger check_location before insert or update on teamlocation
for each row execute function check_location()
