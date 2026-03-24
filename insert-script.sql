INSERT INTO Train (train_number, train_type) VALUES 
(705, 'Інтерсіті'),
(101, 'Нічний'),
(808, 'Приміський');

INSERT INTO Wagon (train_id, wagon_number, wagon_type) VALUES 
(1, 1, 'Сидячий'),
(1, 2, 'Сидячий'),
(2, 1, 'Купейний'),
(2, 2, 'Плацкартний'),
(3, 1, 'Сидячий');

INSERT INTO Seat (wagon_id, seat_number, seat_class, seat_status) VALUES 
(1, 1, '1-й Клас', 'Вільне'),        
(1, 2, '1-й Клас', 'Заброньоване'),  
(3, 15, NULL, 'Вільне'),             
(4, 42, NULL, 'Вільне'),             
(5, 10, NULL, 'Вільне');             

INSERT INTO Employee (train_id, employee_type) VALUES 
(1, 'Водій'),
(1, 'Борт-Провідник'),
(2, 'Борт-Провідник'),
(3, 'Водій');

INSERT INTO Station (station_address) VALUES 
('Kyiv-Pasazhyrskyi, Vokzalna Square 1'),
('Vinnytsia, Pryvokzalna Square 1'),
('Khmelnytskyi, Proskurivska St 92'),
('Ternopil, Pryvokzalnyy Maidan 1'),
('Lviv, Dvirtseva Square 1');

INSERT INTO Route (route_name) VALUES 
('Kyiv - Lviv'),
('Kyiv - Odesa'),
('Lviv - Uzhhorod');

INSERT INTO Route_Stop (route_id, station_number, station_order, stop_time, until_next_station_time) VALUES 
(1, 1, 1, '00:00:00', '02:30:00'), 
(1, 2, 2, '00:05:00', '01:45:00'), 
(1, 3, 3, '00:05:00', '01:30:00'), 
(1, 4, 4, '00:05:00', '01:50:00'), 
(1, 5, 5, '00:00:00', '00:00:00'); 

INSERT INTO Client_User (last_name, first_name) VALUES 
('Shevchenko', 'Taras'),
('Franko', 'Ivan'),
('Ukrainka', 'Lesya'),
('Kostenko', 'Lina');

INSERT INTO Trip (trip_number, train_id, route_id, time_of_depart, time_of_arrival) VALUES 
(1001, 1, 1, '2026-03-25 06:00:00', '2026-03-25 13:45:00'),
(1002, 2, 1, '2026-03-26 22:00:00', '2026-03-27 06:00:00'),
(1003, 3, 1, '2026-03-27 08:00:00', '2026-03-27 15:30:00');

INSERT INTO Ticket (user_id, trip_number, departing_station, arrival_station, departing_order, arrival_order, last_name, first_name, wagon_number, seat_number) VALUES 
(1, 1001, 1, 3, 1, 3, 'Shevchenko', 'Taras', 1, 1),
(2, 1001, 3, 5, 3, 5, 'Franko', 'Ivan', 1, 1),
(3, 1001, 2, 4, 2, 4, 'Ukrainka', 'Lesya', 1, 2),
(4, 1002, 1, 5, 1, 5, 'Kostenko', 'Lina', 1, 15);