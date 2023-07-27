DROP TABLE IF EXISTS assignment;
DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS enclosure;
DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employee_number INT
);

CREATE TABLE enclosure(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closed_for_maintenance Boolean
);

CREATE TABLE animal(
    id SERIAL,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT
);

CREATE TABLE assignment(
    id SERIAL PRIMARY KEY,
    staff_id INT,
    enclosure_id INT,
    day VARCHAR(255)
);

INSERT INTO staff (name, employee_number) VALUES ('Captain Rick',12345);
INSERT INTO staff (name, employee_number) VALUES ('Faran',12344);
INSERT INTO staff (name, employee_number) VALUES ('Rebecca',12343);
INSERT INTO staff (name, employee_number) VALUES ('Colin',00001);

INSERT INTO enclosure (name,capacity,closed_for_maintenance) VALUES ('Big Cat Field',20,false);
INSERT INTO enclosure (name,capacity,closed_for_maintenance) VALUES ('Big Bear Field',2,true);
INSERT INTO enclosure (name,capacity,closed_for_maintenance) VALUES ('Big Donkey Field',10,false);

INSERT INTO animal (name,type,age,enclosure_id) VALUES ('Tony','Tiger',59,1);
INSERT INTO animal (name,type,age,enclosure_id) VALUES ('Zsolt','Sphinx',35,1);
INSERT INTO animal (name,type,age,enclosure_id) VALUES ('Ed','Bear',27,2);
INSERT INTO animal (name,type,age,enclosure_id) VALUES ('Paddington','Bear',65,2);
INSERT INTO animal (name,type,age,enclosure_id) VALUES ('Rohaib','Donkey',22,3);
INSERT INTO animal (name,type,age,enclosure_id) VALUES ('Anna','Horse',65,3);

INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (1,1,'Tuesday');
INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (2,2,'Wednesday');
INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (3,3,'Thursday');
INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (4,1,'Friday');
INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (3,2,'Saturday');
INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (2,3,'Sunday');
INSERT INTO assignment (staff_id,enclosure_id,day) VALUES (1,3,'Monday');

--Name of animals in an enclosure
SELECT animal.name FROM animal
LEFT JOIN enclosure
ON enclosure.id = animal.enclosure_id
WHERE enclosure.name = 'Big Cat Field';

--Finding names of staff working in an enclosure
SELECT staff.name FROM staff
INNER JOIN assignment
ON staff.id = assignment.staff_id
INNER JOIN enclosure
ON assignment.enclosure_id = enclosure.id
WHERE enclosure.name = 'Big Cat Field';

--
SELECT staff.name FROM staff
INNER JOIN assignment
ON staff.id = assignment.staff_id
INNER JOIN enclosure
ON assignment.enclosure_id = enclosure.id
WHERE enclosure.closed_for_maintenance = true;

--
SELECT enclosure.name FROM enclosure
LEFT JOIN animal 
ON animal.enclosure_id = enclosure.id
ORDER BY age DESC, name ASC LIMIT 1;

--
SELECT COUNT(DISTINCT animal.type) FROM animal
LEFT JOIN enclosure 
ON animal.enclosure_id = enclosure.id
INNER JOIN assignment
ON assignment.enclosure_id = enclosure.id
INNER JOIN staff
ON assignment.staff_id = staff.id
WHERE staff.name = 'Rebecca';

--
SELECT COUNT(DISTINCT staff.name) FROM staff
INNER JOIN assignment
ON assignment.staff_id = staff.id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosure_id
WHERE enclosure.name =  'Big Cat Field'; 

--
SELECT DISTINCT animal.name FROM animal
LEFT JOIN enclosure
ON enclosure.id = animal.enclosure_id
WHERE animal.name != 'Tony' AND enclosure.name ='Big Cat Field' ;