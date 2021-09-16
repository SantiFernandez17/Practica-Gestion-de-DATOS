-------------------------------------------------
             ----EJERCICIOS----
-------------------------------------------------

--Mostrar el código, razón social de todos los clientes cuyo límite de crédito sea mayor o
--igual a $ 1000 ordenado por código de cliente.
use GD2015C1

SELECT clie_codigo, clie_razon_social FROM cliente 
WHERE clie_limite_credito >= 1000 
order by 1

--Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por
--cantidad vendida.


select prod_codigo,prod_detalle, count(distinct fact_tipo+fact_sucursal+fact_numero) cant_Facturas from Producto 
JOIN Item_Factura on prod_codigo = item_producto 
JOIN Factura on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
where year(fact_fecha) = 2012
group by prod_codigo,prod_detalle
order by sum(item_cantidad)



--Realizar una consulta que muestre código de producto, nombre de producto y el stock
--total, sin importar en que deposito se encuentre, los datos deben ser ordenados por
--nombre del artículo de menor a mayor.
select prod_codigo, prod_detalle, sum(stoc_cantidad) STOCK_TOTAL from Producto
JOIN STOCK ON prod_codigo = stoc_producto
GROUP BY prod_codigo, prod_detalle
ORDER BY prod_detalle -- los datos deben ser ordenados por nombre del artículo de menor a mayor.



--Realizar una consulta que muestre para todos los artículos código, detalle y cantidad de
--artículos que lo componen. Mostrar solo aquellos artículos para los cuales el stock
--promedio por depósito sea mayor a 100.

select prod_codigo, prod_detalle 
from Producto
JOIN Composicion ON prod_codigo = comp_componente
JOIN STOCK ON comp_producto = stoc_producto
GROUP BY prod_codigo, prod_detalle 
ORDER BY prod_detalle 

select top 1 From Composicion
select * From Producto
select * from STOCK



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

--Realizar una consulta que muestre código de artículo, detalle y cantidad de egresos de
--stock que se realizaron para ese artículo en el año 2012 (egresan los productos que
--fueron vendidos). Mostrar solo aquellos que hayan tenido más egresos que en el 2011.
use GD2015C1


select prod_codigo, prod_detalle, sum(item_cantidad)
from Producto
--JOIN STOCK on prod_codigo = stoc_producto
JOIN Factura on prod_codigo = fact_numero
JOIN Item_Factura on prod_codigo = item_numero
where year(fact_fecha) = 2012
GROUP BY prod_codigo, prod_detalle

select * from Item_Factura

select item_producto, prod_detalle, sum(item_cantidad)
from Item_Factura
JOIN Producto on prod_codigo = item_producto 
JOIN Factura on item_tipo+item_sucursal+item_numero = fact_tipo+fact_sucursal+fact_numero
where year(fact_fecha) = 2012
GROUP BY item_producto, prod_detalle, prod_codigo
having sum(item_cantidad) >
(select sum(item_cantidad)
from Item_Factura JOIN Factura on item_tipo+item_sucursal+item_numero = fact_tipo+fact_sucursal+fact_numero
where item_producto = prod_codigo and year(fact_fecha) = 2011)

select * from Producto
where prod_detalle like 'A%'

--Mostrar para todos los rubros de artículos: código, detalle, cantidad de artículos de ese
--rubro y stock total de ese rubro de artículos. Solo tener en cuenta aquellos artículos que
--tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’.
SELECT 
	rubr_id AS 'Codigo', 
	rubr_detalle AS 'Rubro', 
	COUNT(DISTINCT prod_codigo) AS 'Articulos',
	SUM(stoc_cantidad) AS 'Stock total'
FROM Rubro
JOIN Producto ON rubr_id = prod_rubro
JOIN STOCK ON prod_codigo = stoc_producto
WHERE (SELECT SUM(stoc_cantidad) FROM STOCK WHERE stoc_producto = prod_codigo) >
(SELECT stoc_cantidad FROM STOCK WHERE stoc_producto = '00000000' AND stoc_deposito = '00')
GROUP BY rubr_id, rubr_detalle





select rubr_id, rubr_detalle, count(DISTINCT prod_codigo)
from Rubro
JOIN Producto on prod_codigo = rubr_id 
JOIN STOCK on stoc_producto = prod_codigo
GROUP BY rubr_id, rubr_detalle


select * from STOCK
select * from Producto




select rubr_id, rubr_detalle, COUNT(DISTINCT prod_codigo) cant_art_x_rubro, sum(stoc_cantidad) stockTotal from Rubro
JOIN Producto on rubr_id = prod_rubro 
JOIN STOCK on prod_codigo = stoc_producto
GROUP BY rubr_id, rubr_detalle
--stock total de ese rubro de artículos

--para hacer la ultima parte se me ocurre
--cantidad de articulo en total del rubro > '00000000'


select * from Rubro

select * from STOCK
ORDER BY 2

select * from STOCK
where stoc_cantidad < 0

--Generar una consulta que muestre para cada artículo código, detalle, mayor precio
--menor precio y % de la diferencia de precios (respecto del menor Ej.: menor precio =
--10, mayor precio =12 => mostrar 20 %). Mostrar solo aquellos artículos que posean
--stock.

SELECT 
	prod_codigo AS 'Codigo',
	prod_detalle AS 'Producto', 
	MAX(item_precio) AS 'Precio maximo', 
	MIN(item_precio) AS 'Precio minimo',
	CAST(((MAX(item_precio) - MIN(item_precio)) / MIN(item_precio)) * 100 AS DECIMAL(10,2)) AS 'Diferencia'
FROM Producto
JOIN Item_Factura ON prod_codigo = item_producto
JOIN STOCK ON prod_codigo = stoc_producto
GROUP BY prod_codigo, prod_detalle
HAVING SUM(stoc_cantidad) > 0

select * from Item_Factura
select * from Producto

--Realizar una consulta que visualice los campos NOMBRE ARTÍCULO,
--SECCIÓN, PRECIO de la tabla PRODUCTOS y un campo nuevo que
--nombramos con el texto “DESCUENTO_7”. Debe mostrar el resultado de aplicar
--sobre el campo PRECIO un descuento de un 7 %. El formato del nuevo campo
--para debe aparecer con 2 lugares decimales.

select prod_detalle AS 'Articulo', prod_codigo as 'Code', item_precio AS 'Precio'
from Producto join Item_Factura on prod_codigo = item_producto
where 'Precio' * 0,7

-- como HAGO SI QUIERO MODIFICAR UNA COLUMNA.


select * from Familia

--todas las compras en el año 2012

select clie_codigo, fact_fecha 
from Cliente 
JOIN Factura on clie_codigo = fact_cliente
where YEAR(fact_fecha) <> 2012
GROUP BY clie_codigo, fact_fecha
ORDER BY fact_fecha


--Generar una consulta que muestre para cada artículo código, detalle, mayor precio
--menor precio y % de la diferencia de precios (respecto del menor Ej.: menor precio =
--10, mayor precio =12 => mostrar 20 %). Mostrar solo aquellos artículos que posean
--stock.

select prod_codigo, prod_detalle, max(item_precio) PrecioMaximo , min(item_precio) PrecioMinimo
from Producto
JOIN Item_Factura on item_producto = prod_codigo
JOIN STOCK on prod_codigo = stoc_producto
WHERE stoc_cantidad > 0
GROUP BY prod_codigo, prod_detalle
HAVING SUM(stoc_cantidad) > 0


select * from STOCK
ORDER BY stoc_cantidad
select * from Item_Factura
ORder by item_producto
select * from Producto
ORDER BY prod_codigo

--Mostrar para el o los artículos que tengan stock en todos los depósitos, nombre del
--artículo, stock del depósito que más stock tiene.

select (select top 1 sum(stoc_cantidad) stock, stoc_deposito from STOCK GROUP BY stoc_deposito ORDER BY stock desc), prod_detalle AS 'Articulos', max(stoc_cantidad)                                         
FROM Producto JOIN STOCK on stoc_producto = prod_codigo
GROUP BY prod_detalle, stoc_deposito





-- COUNT CUENTA TODAS LAS FILAS


--Solo tener en cuenta aquellos artículos que
--tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’.

SELECT 
	rubr_id AS 'Codigo', 
	rubr_detalle AS 'Rubro', 
	COUNT(DISTINCT prod_codigo) AS 'Articulos',
	SUM(stoc_cantidad) AS 'Stock total'
FROM Rubro
JOIN Producto ON rubr_id = prod_rubro
JOIN STOCK ON prod_codigo = stoc_producto
WHERE (SELECT SUM(stoc_cantidad) FROM STOCK WHERE stoc_producto = prod_codigo) >
(SELECT stoc_cantidad FROM STOCK WHERE stoc_producto = '00000000' AND stoc_deposito = '00')
GROUP BY rubr_id, rubr_detalle

--Mostrar el código del jefe, código del empleado que lo tiene como jefe, nombre del
--mismo y la cantidad de depósitos que ambos tienen asignados.

select empl_tareas, empl_codigo from Empleado
where empl_tareas like 'Jefe %' 


select prod_codigo from Producto
where prod_codigo = '0000000'



--Mostrar para todos los rubros de artículos código, detalle, cantidad de artículos de ese
--rubro y stock total de ese rubro de artículos. Solo tener en cuenta aquellos artículos que
--tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’.select rubr_id, rubr_detalle, prod_codigo, sum(stoc_cantidad) AS 'cantidad_de_articulos' from RubroJOIN Producto on prod_rubro = rubr_idJOIN STOCK on stoc_producto = prod_codigoWHERE (SELECT SUM(stoc_cantidad) FROM STOCK WHERE stoc_producto = prod_codigo) >
(SELECT stoc_cantidad FROM STOCK WHERE stoc_producto = '00000000' AND stoc_deposito = '00')GROUP BY rubr_id, rubr_detalle, prod_codigo--Mostrar los 10 productos más vendidos en la historia y también los 10 productos menos
--vendidos en la historia. Además mostrar de esos productos, quien fue el cliente que
--mayor compra realizo.