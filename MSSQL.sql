USE master;
GO
DROP DATABASE University;
GO
CREATE DATABASE University;
GO
USE University;
GO
CREATE SCHEMA facilities;
GO
CREATE SCHEMA organization;
GO
--------------------------------------------------------------------------
CREATE TABLE organization.campuses
(
 campus varchar(50) NOT NULL,
 CONSTRAINT PK_campuses PRIMARY KEY ( campus )
);
GO
INSERT INTO organization.campuses(Campus)
VALUES ('Ramat Aviv');
--------------------------------------------------------------------------
CREATE TABLE facilities.buildings
(
 campus         varchar(50) NOT NULL,
 building       varchar(50) NOT NULL,
 address_line_1 varchar(50) NOT NULL,
 address_line_2 varchar(50) NULL,
 city           varchar(50) NOT NULL,
 state          varchar(50) NOT NULL,
 zip_code       char(5) NOT NULL,
 PRIMARY KEY ( campus, building ),
 FOREIGN KEY ( campus ) 
    REFERENCES organization.campuses ( campus )
        ON UPDATE CASCADE ON DELETE NO ACTION
);
GO
INSERT INTO facilities.buildings(Campus, Building, address_line_1, address_line_2, city, state, zip_code)
VALUES  ('Ramat Aviv', 'Buchmann', '123 Haim Levanon St.', NULL, 'Ramat Aviv', 'Israel', '12345'), 
        ('Ramat Aviv', 'Sackler', '456 Klatzkin St.', NULL, 'Ramat Aviv', 'Israel', '12345');
--------------------------------------------------------------------------
CREATE TABLE facilities.elevators
(
 campus   varchar(50) NOT NULL,
 building varchar(50) NOT NULL,
 elevator int NOT NULL,
    PRIMARY KEY ( campus, building, elevator ),
    FOREIGN KEY ( campus, building ) 
        REFERENCES facilities.buildings ( campus, building )
            ON UPDATE CASCADE ON DELETE NO ACTION
);
GO
INSERT INTO facilities.Elevators(campus, building, elevator)
VALUES  ('Ramat Aviv', 'Buchmann', 1), 
        ('Ramat Aviv', 'Sackler', 1), ('Ramat Aviv', 'Sackler', 2);
--------------------------------------------------------------------------
CREATE TABLE facilities.floors
(
 campus   varchar(50) NOT NULL,
 building varchar(50) NOT NULL,
 floor    int NOT NULL,
    PRIMARY KEY ( campus, building, floor ),
    FOREIGN KEY ( campus, building ) 
        REFERENCES facilities.buildings ( campus, building )
            ON UPDATE CASCADE ON DELETE NO ACTION
);
GO
INSERT INTO facilities.floors(Campus, Building, Floor)
VALUES  ('Ramat Aviv', 'Buchmann', 1),
        ('Ramat Aviv', 'Sackler', 1), ('Ramat Aviv', 'Sackler', 2);
--------------------------------------------------------------------------
CREATE TABLE facilities.floor_sections
(
 campus   varchar(50) NOT NULL,
 building varchar(50) NOT NULL,
 floor    int NOT NULL,
 section  char(1) NOT NULL,
    PRIMARY KEY ( campus, building, floor, section ),
    FOREIGN KEY ( campus, building, floor ) 
        REFERENCES facilities.floors ( campus, building, floor )
            ON UPDATE CASCADE ON DELETE NO ACTION

);
GO
INSERT INTO facilities.floor_sections(Campus, Building, Floor, Section)
VALUES  ('Ramat Aviv', 'Sackler', 1, 'A'), ('Ramat Aviv', 'Sackler', 1, 'B'), 
        ('Ramat Aviv', 'Sackler', 1, 'C'),
        ('Ramat Aviv', 'Sackler', 2, 'A'), ('Ramat Aviv', 'Sackler', 2, 'B');
--------------------------------------------------------------------------
CREATE TABLE facilities.elevator_floor_sections
(
 campus   varchar(50) NOT NULL,
 building varchar(50) NOT NULL,
 elevator int NOT NULL,
 floor    int NOT NULL,
 section  char(1) NOT NULL,
    PRIMARY KEY ( campus, building, elevator, floor, section ),
    FOREIGN KEY ( campus, building, floor, section ) 
        REFERENCES facilities.floor_sections ( campus, building, floor, section )
            ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY ( campus, building, elevator ) 
        REFERENCES facilities.elevators ( campus, building, elevator )
            ON UPDATE CASCADE ON DELETE NO ACTION
);
GO
INSERT INTO facilities.elevator_floor_sections (campus, building, elevator, floor, section)
VALUES  ('Ramat Aviv', 'Sackler', 1, 1, 'A'),  ('Ramat Aviv', 'Sackler', 1, 2, 'A'),
        ('Ramat Aviv', 'Sackler', 2, 1, 'B'), ('Ramat Aviv', 'Sackler', 2, 2, 'B');
--------------------------------------------------------------------------


