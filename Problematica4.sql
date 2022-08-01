-- Listar la cantidad de clientes por nombre de sucursal ordenando de mayor a menor
SELECT count(c.customer_DNI) as clientes,branch_name FROM cliente c,sucursal s
WHERE c.branch_id = s.branch_id
GROUP BY branch_name
ORDER BY clientes DESC;


-- Obtener la cantidad de empleados por cliente por sucursal en un número real
-- SELECT employees.branch_name,quantity_employes,quantity_clients FROM
SELECT employees.branch_name,quantity_employes*1.0/quantity_clients FROM
    (SELECT count(employee_DNI) as quantity_employes,branch_name
        FROM empleado e,sucursal s
        WHERE e.branch_id = s.branch_id
        GROUP BY branch_name) 
employees
,   (SELECT count(c.customer_DNI) as quantity_clients,branch_name from cliente c,sucursal s 
        WHERE c.branch_id = s.branch_id GROUP BY s.branch_name) 
clients
    WHERE employees.branch_name = clients.branch_name
;

