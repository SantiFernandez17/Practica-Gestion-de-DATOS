create database holi
use GD2015C1
create table tablona
(
nombre_User varchar (20), 
iD int identity primary key, 
contrasenia varchar (15),
)
insert into tablona values('santi elpibe', '123455');
insert into tablona values('sanbe', '1235');
insert into tablona values('sane', '455');
insert into tablona values('sa6ne', '4855');

-- revisar los registros ingresados en la tabla --
-- con select * le digo que me muestre todos los datos
-- FROM define el origen de los datos

SELECT * FROM tablona
-- COMANDO GO
--ejecutar multiples procedimientos almacenados en un script o consulta
-- GO es una señal de finalizacion de un lote de sentencias. no deben ocupar la misma linea donde esta GO 

-- IDENTITY: propiedad que al momento en que creamos una tabla la podemos insertar con el objetivo
-- de crear una columna autonumerica
-- SET IDENTITY_INSERT productos ON luz verde para hacer la insercion manual y permitir valores repetidos

-- DELETE nos permite eliminar registros de forma selectiva o total en una tabla

delete from tablona
where iD = 2

-- TRUNCATE aparte de borrar los datos de las tablas, resetea los campos autonumericos, entonces los conteos son reiniciados

truncate table tablona

-- UPDATE

update tablona set  nombre_User = 'santuli'
where iD = 3

-------------------------------------------------
             ----EJERCICIOS----
-------------------------------------------------

--Mostrar el código, razón social de todos los clientes cuyo límite de crédito sea mayor o
--igual a $ 1000 ordenado por código de cliente.
use GD2015C1
SELECT * FROM Cliente

SELECT clie_codigo, clie_razon_social FROM cliente WHERE clie_limite_credito > 1000 
order by clie_codigo

--Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por
--cantidad vendida.
	
select prod_codigo, prod_detalle, sum(item_cantidad) suma_productos from Producto 
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura ON fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
GROUP BY prod_codigo, prod_detalle
ORDER BY sum(item_cantidad)

WHERE YEAR(fact_fecha) = 2012
ORDER BY item_cantidad



select * from Item_Factura

select * from Factura
 


SELECT prod_codigo, prod_detalle FROM Producto
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura ON item_numero = fact_numero 
AND item_tipo = fact_tipo 
AND item_sucursal = fact_sucursal
WHERE YEAR(fact_fecha) = 2012
GROUP BY prod_codigo, prod_detalle
ORDER BY SUM(item_cantidad) DESC


--Realizar una consulta que muestre código de producto, nombre de producto y el stock
--total, sin importar en que deposito se encuentre, los datos deben ser ordenados por
--nombre del artículo de menor a mayor.
select * from Producto
SELECT 
	prod_codigo, prod_detalle, SUM(stoc_cantidad) AS 'Stock Total' FROM Producto
JOIN STOCK ON prod_codigo = stoc_producto
GROUP BY prod_codigo, prod_detalle
ORDER BY prod_detalle asc -- los datos deben ser ordenados por nombre del artículo de menor a mayor.

--Realizar una consulta que muestre para todos los artículos código, detalle y cantidad de
--artículos que lo componen. Mostrar solo aquellos artículos para los cuales el stock
--promedio por depósito sea mayor a 100.

select prod_codigo, prod_detalle, sum(prod_precio)lol from Producto
JOIN STOCK ON prod_codigo = stoc_producto
GROUP BY prod_codigo, prod_detalle
--WHERE avg(stoc_deposito) > 100

select * from Producto

use GD2015C1

select prod_codigo, prod_detalle from Producto ORDER BY prod_codigo -- ordena alfabeticamente depende lo que quieras ordenar

select stoc_cantidad, stoc_producto from STOCK 
JOIN Producto ON  prod_codigo = stoc_cantidad
ORDER BY stoc_cantidad


select prod_detalle, prod_precio AS 'LOL' from Producto 
WHERE prod_detalle = 'HACIENDA BOVINA'
ORDER BY 'LOL'

select prod_precio , fact_fecha, prod_detalle from Producto, Factura
where fact_fecha = 2012
GROUP BY fact_fecha, prod_precio, prod_detalle


                       
-----TABLAS------
select * from Producto
select * from STOCK
select * from Factura