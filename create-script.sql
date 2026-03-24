CREATE TYPE t_type AS ENUM ('Інтерсіті', 'Нічний', 'Приміський');

CREATE TABLE IF NOT EXISTS Train (
	train_id SERIAL PRIMARY KEY,
	train_number INT UNIQUE NOT NULL, -- Train number can't be repeating, creates confusion for everyone
	train_type t_type NOT NULL
);

CREATE TYPE w_type AS ENUM ('Купейний', 'Плацкартний', 'Спальний', 'Сидячий', 'Люкс', 'Спеціальний');

CREATE TABLE IF NOT EXISTS Wagon (
	wagon_id SERIAL PRIMARY KEY,
	train_id INT NOT NULL REFERENCES Train(train_id),
	wagon_number INT NOT NULL,
	wagon_type w_type NOT NULL,
	UNIQUE (train_id, wagon_number) -- A train cannot have wagons with same number
);

CREATE TYPE status AS ENUM ('Заброньоване', 'Вільне');
CREATE TYPE s_class AS ENUM ('1-й Клас', '2-й Клас');

-- Not all trains can have classes for their seats, thus not necessary for it to be NOT NULL
CREATE TABLE IF NOT EXISTS Seat (
	seat_id SERIAL PRIMARY KEY,
	wagon_id INT NOT NULL REFERENCES Wagon(wagon_id),
	seat_number INT NOT NULL,
	seat_class s_class,
	seat_status status NOT NULL,
	UNIQUE (wagon_id, seat_number) -- Same as in wagon with trains
);

CREATE TYPE employee_enum AS ENUM ('Борт-Провідник', 'Водій');

CREATE TABLE IF NOT EXISTS Employee (
	employee_id SERIAL PRIMARY KEY,
	train_id INT NOT NULL REFERENCES Train(train_id),
	employee_type employee_enum NOT NULL
);

CREATE TABLE IF NOT EXISTS Station(
	station_number SERIAL PRIMARY KEY,
	station_address VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS Route (
	route_id SERIAL PRIMARY KEY,
	route_name VARCHAR(64) UNIQUE NOT NULL
);

-- Intervals since it's a relative time, not set time like for example 14:00
CREATE TABLE IF NOT EXISTS Route_Stop (
	route_stop_id SERIAL PRIMARY KEY,
	route_id INT NOT NULL REFERENCES Route(route_id),
	station_number INT NOT NULL REFERENCES Station(station_number),
	station_order INT NOT NULL,
	stop_time INTERVAL NOT NULL,
	until_next_station_time INTERVAL NOT NULL,
	UNIQUE (route_id, station_number),
	UNIQUE (route_id, station_order) -- No same stations in one route
);

CREATE TABLE IF NOT EXISTS Client_User (
	user_id SERIAL PRIMARY KEY,
	last_name VARCHAR(32) NOT NULL,
	first_name VARCHAR(32) NOT NULL
);

-- trip_number is a manual input field
CREATE TABLE IF NOT EXISTS Trip (
	trip_number INT PRIMARY KEY,
	train_id INT NOT NULL REFERENCES Train(train_id),
	route_id INT NOT NULL REFERENCES Route(route_id),
	time_of_depart TIMESTAMP NOT NULL,
	time_of_arrival TIMESTAMP NOT NULL
);

CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE IF NOT EXISTS Ticket (
    ticket_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Client_User(user_id),
    trip_number INT NOT NULL REFERENCES Trip(trip_number),
    departing_station INT NOT NULL REFERENCES Station(station_number),
    arrival_station INT NOT NULL REFERENCES Station(station_number),
	
    departing_order INT NOT NULL, 
    arrival_order INT NOT NULL,   
	
    last_name VARCHAR(32) NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    wagon_number INT NOT NULL,
    seat_number INT NOT NULL,

	-- Preventing duplicate tickets for the same place, 
	-- but allowing different tickets to have the same arrival and departing stations
    EXCLUDE USING gist (
        trip_number WITH =,
        wagon_number WITH =,
        seat_number WITH =,
        int4range(departing_order, arrival_order) WITH &&
    )
);