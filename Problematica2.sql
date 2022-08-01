-- item 1 --
CREATE VIEW v_customer
AS
SELECT 
    customer_id,
    branch_number,
    customer_name,
    customer_surname,
    customer_DNI,
    cast(strftime('%Y.%m%d', 'now') - strftime('%Y.%m%d', dob) as int) as customer_age
FROM cliente
INNER JOIN sucursal on cliente.branch_id = sucursal.branch_id;

SELECT * 
FROM v_customer
WHERE customer_age > 40
ORDER BY customer_DNI ASC;

SELECT *
FROM v_customer
WHERE customer_name = 'Anne' OR customer_name = 'Tyler'
ORDER BY customer_age ASC;

-- item 2 --
INSERT INTO cliente (branch_id,customer_name,customer_surname, customer_DNI, dob)
VALUES
    (80, 'Lois', 'Stout', 47730534, '1984-07-07'),
    (45, 'Hali', 'Mcconell', 52055464, '1968-04-30'),
    (77, 'Hilel', 'Mclean', 43625213, '1993-03-28'),
    (96, 'Jin', 'Cooley', 21207908, '1959-08-24'),
    (27, 'Gabriel', 'Harmon', 57063950, '1976-04-01');

SELECT *
FROM v_customer
ORDER BY customer_id DESC
LIMIT 5;

-- item 3 --
UPDATE cliente
SET branch_id = 10
where customer_id > 500;

SELECT *
FROM v_customer;

-- item 4 -- 
DELETE FROM v_customer
WHERE customer_name = 'Noel' AND customer_surname = 'David';

-- item 5 --
SELECT loan_type, sum(loan_total)
FROM prestamo
GROUP BY loan_type
ORDER BY sum(loan_total) DESC
LIMIT 1;
