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
