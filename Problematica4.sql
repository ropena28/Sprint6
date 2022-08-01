-- Listar la cantidad de clientes por nombre de sucursal ordenando de mayor a menor
SELECT count(c.customer_DNI) as clientes,branch_name 
FROM cliente c,sucursal s
WHERE c.branch_id = s.branch_id
GROUP BY branch_name
ORDER BY clientes DESC;


-- Obtener la cantidad de empleados por cliente por sucursal en un número real
-- SELECT employees.branch_name,quantity_employes,quantity_clients FROM
SELECT employees.branch_name,quantity_employes*1.0/quantity_clients FROM
    (
        SELECT count(employee_DNI) as 
        quantity_employes,branch_name
        FROM empleado e,sucursal s
        WHERE e.branch_id = s.branch_id
        GROUP BY branch_name
    ) 
    employees
,   (
        SELECT count(c.customer_DNI) as 
        quantity_clients,branch_name 
        FROM cliente c,sucursal s 
        WHERE c.branch_id = s.branch_id 
        GROUP BY s.branch_name
    )
    clients
    WHERE employees.branch_name = clients.branch_name
;

-- Obtener la cantidad de tarjetas de crédito por tipo por sucursal

SELECT COUNT(tarjeta.Numero) as cantidad, Tipo_tarjeta.Tipo, sucursal.branch_name, Marcas_Tarjeta.MT_nombre
from tarjeta inner join Tipo_tarjeta on tarjeta.fk_Tipo = Tipo_tarjeta.Tipo_tarjeta_id
inner join Marcas_Tarjeta on tarjeta.fk_Marca = Marcas_Tarjeta.MT_id
inner join cliente on cliente.customer_id = tarjeta.fk_cliente
inner join sucursal on sucursal.branch_id = cliente.branch_id
where Tipo_tarjeta.Tipo = "CREDITO"
group by sucursal.branch_id
