CREATE SCHEMA worldcup;

CREATE TABLE worldcup.referee (
    name VARCHAR(200) PRIMARY KEY,
    age SMALLINT NOT NULL,
    citizenship VARCHAR(100) NOT NULL
);

CREATE TABLE worldcup.team (
    name VARCHAR(200) PRIMARY KEY,
    coach VARCHAR(200) NOT NULL,
    titles SMALLINT NOT NULL
);

CREATE TABLE worldcup.player (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    marketvalue INTEGER NOT NULL,
    team VARCHAR(200) REFERENCES worldcup.team(name)
);

CREATE TABLE worldcup.city (
    name VARCHAR(200) PRIMARY KEY,
    population INTEGER NOT NULL
);

CREATE TABLE worldcup.stadium (
    name VARCHAR(200) PRIMARY KEY,
    capacity INTEGER NOT NULL,
    city VARCHAR(200) REFERENCES worldcup.city(name)
);

CREATE TABLE worldcup.match (
    id SERIAL PRIMARY KEY,
    home_team VARCHAR(200) REFERENCES worldcup.team(name),
    guest_team VARCHAR(200) REFERENCES worldcup.team(name),
    referee VARCHAR(200) REFERENCES worldcup.referee(name),
    stadium VARCHAR(200) REFERENCES worldcup.stadium(name),
    match_date TIMESTAMP NOT NULL,
    attendance INTEGER NOT NULL,
    result VARCHAR(200) NOT NULL
);

CREATE TABLE worldcup.teamlocation (
    id SERIAL PRIMARY KEY,
    team VARCHAR(200) REFERENCES worldcup.team(name),
    city VARCHAR(200) REFERENCES worldcup.city(name),
    start_date DATE NOT NULL,
    finish_date DATE NOT NULL
);