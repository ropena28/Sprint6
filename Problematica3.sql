-- Seleccionar las cuentas con saldo negativo
SELECT balance, customer_id
FROM cuenta
WHERE balance < 0;


-- Seleccionar el nombre, apellido y edad de los clientes que tengan en el apellido la letra Z
SELECT customer_name, customer_surname, dob
FROM cliente
WHERE customer_surname like '%z%';


-- Seleccionar el nombre, apellido, edad y nombre de sucursal de las personas cuyo nombre sea “Brendan” y el resultado ordenarlo por nombre de sucursa
SELECT customer_name, customer_surname, customer_DNI,branch_name
FROM cliente, sucursal
WHERE customer_name = "Brendan" 
order by (SELECT branch_name FROM sucursal)


-- Seleccionar los préstamos que tengan fecha en abril, junio y agosto, ordenándolos por importe (necesito ayuda porque se me complico)
SELECT substr(loan_date,6,2) as mes,* FROM prestamo
WHERE mes='04' or mes='06' or mes='08'
ORDER BY loan_total ASC;



-- Seleccionar las primeras 5 cuentas con saldo mayor a 8.000$
SELECT balance
FROM cuenta
WHERE balance > 8000
ORDER BY balance DESC
LIMIT 5;



-- Contar la cantidad de clientes menores a 50 años
SELECT count(customer_DNI)
FROM cliente
WHERE dob < '1972';

-- Seleccionar de la tabla de préstamos,importe mayor a $80.000 

SELECT loan_total*1.0/100 as loan,loan_type 
FROM prestamo 
WHERE loan >80000 
UNION
SELECT loan_total*1.0/100 as loan,loan_type 
FROM prestamo 
WHERE loan_type = 'PRENDARIO'
ORDER BY loan ASC
;

-- Seleccionar los prestamos cuyo importe sea mayor que el importe medio de todos los prestamos
-- SELECT avg(loan_total*1.0/100) FROM prestamo; importe medio?

SELECT loan_total*1.0/100 as loan,* 
FROM prestamo
WHERE loan > (SELECT avg(loan_total*1.0/100) FROM prestamo)
ORDER BY loan ASC
;

-- Obtener el importe total de los prestamos agrupados por tipo de préstamos
SELECT sum(loan_total)*1.0/100 as loan_total_accu,loan_type 
FROM prestamo
GROUP by loan_type
;