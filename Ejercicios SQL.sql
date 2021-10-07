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

select empl_jefe, empl_codigo, empl_apellido, empl_nombre, count(depo_encargado)
from Empleado
LEFT JOIN DEPOSITO on empl_codigo = depo_encargado or empl_jefe = depo_encargado
GROUP BY empl_jefe, empl_codigo, empl_apellido, empl_nombre	


--Mostrar para todos los rubros de artículos código, detalle, cantidad de artículos de ese
--rubro y stock total de ese rubro de artículos. Solo tener en cuenta aquellos artículos que
--tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’.


select rubr_id, rubr_detalle, prod_codigo, sum(stoc_cantidad) AS 'cantidad_de_articulos' from Rubro
JOIN Producto on prod_rubro = rubr_id
JOIN STOCK on stoc_producto = prod_codigo
WHERE (SELECT SUM(stoc_cantidad) FROM STOCK WHERE stoc_producto = prod_codigo) >
(SELECT stoc_cantidad FROM STOCK WHERE stoc_producto = '00000000' AND stoc_deposito = '00')
GROUP BY rubr_id, rubr_detalle, prod_codigo




select prod_detalle, max(stoc_cantidad)
from Producto JOIN STOCK on stoc_producto = prod_codigo
GROUP BY prod_detalle
having count(*) = (select count(*) from DEPOSITO)
--como sé que estan todos los depositos? porque la cnatidad de depositos tiene que ser igual a la cantidad de depositos que hay

--select prod_detalle, 
--from Producto JOIN STOCK on stoc_producto = prod_codigo esto me trae todos los depositos donde hay stock

--Mostrar el código del jefe, código del empleado que lo tiene como jefe, nombre del
--mismo y la cantidad de depósitos que ambos tienen asignados.


SELECT 
	empl_jefe AS 'Codigo jefe', 
	empl_codigo AS 'Codigo empleado', 
	empl_nombre+' '+empl_apellido AS 'Empleado',
	(SELECT COUNT(*) FROM DEPOSITO WHERE depo_encargado = empl_jefe) AS 'Depositos jefe', 
	(SELECT COUNT(*) FROM DEPOSITO WHERE depo_encargado = empl_codigo) AS 'Depositos empleado'
FROM Empleado

--Realizar una consulta que retorne el detalle de la familia, la cantidad diferentes de
--productos vendidos y el monto de dichas ventas sin impuestos. Los datos se deberán
--ordenar de mayor a menor, por la familia que más productos diferentes vendidos tenga,
--solo se deberán mostrar las familias que tengan una venta superior a 20.000 pesos para
--el año 2012

SELECT 
	fami_detalle AS 'Familia', 
	COUNT(DISTINCT prod_codigo) AS 'Productos vendidos',
	SUM(item_precio * item_cantidad) AS 'Monto ventas'
FROM Familia
JOIN Producto ON fami_id = prod_familia
JOIN Item_Factura ON prod_codigo = item_producto
GROUP BY fami_id, fami_detalle
HAVING (SELECT SUM(item_cantidad * item_precio)
FROM Producto
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura ON item_numero + item_tipo + item_sucursal = 
fact_numero + fact_tipo + fact_sucursal
WHERE YEAR(fact_fecha) = 2012 
AND prod_familia = fami_id) > 20000
ORDER BY 2 DESC


--Mostrar nombre de producto, cantidad de clientes distintos que lo compraron, importe
--promedio pagado por el producto, cantidad de depósitos en los cuales hay stock del
--producto y stock actual del producto en todos los depósitos. Se deberán mostrar
--aquellos productos que hayan tenido operaciones en el año 2012 y los datos deberán
--ordenarse de mayor a menor por monto vendido del producto.

select prod_codigo, count(DISTINCT fact_cliente)
from Producto
JOIN Factura on prod_codigo = fact_numero
group by prod_codigo



select fact_cliente, count(DISTINCT fact_numero) Items_Comprados from Factura
group by fact_sucursal, fact_cliente
order by fact_cliente


SELECT 
	prod_detalle AS 'Producto',
	COUNT(DISTINCT fact_cliente) AS 'Clientes',
	AVG(item_precio) AS 'Precio promedio',
	ISNULL((SELECT COUNT(DISTINCT stoc_deposito) 
	FROM STOCK
	WHERE stoc_producto = prod_codigo 
	AND stoc_cantidad > 0
	GROUP BY stoc_producto), 0) AS 'Depositos con stock',
	ISNULL((SELECT SUM(stoc_cantidad)
	FROM STOCK
	WHERE stoc_producto = prod_codigo
	GROUP BY stoc_producto), 0) AS 'Stock total actual'
FROM Producto
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura ON item_numero + item_sucursal + item_tipo = 
fact_numero + fact_sucursal + fact_tipo
WHERE EXISTS 
(SELECT item_producto
FROM Item_Factura
JOIN Factura ON item_numero + item_sucursal + item_tipo = 
fact_numero + fact_sucursal + fact_tipo
WHERE YEAR(fact_fecha) = 2012
AND item_producto = prod_codigo)
GROUP BY prod_codigo, prod_detalle
ORDER BY SUM(item_cantidad * item_precio) DESC

--Realizar una consulta que retorne para cada producto que posea composición, nombre
--del producto, precio del producto, precio de la sumatoria de los precios por la cantidad 
---de los productos que lo componen. Solo se deberán mostrar los productos que estén
--compuestos por más de 2 productos y deben ser ordenados de mayor a menor por
--cantidad de productos que lo componen.

select * from Producto
JOIN Composicion on comp_producto = prod_codigo

--Escriba una consulta que retorne una estadística de ventas por cliente. Los campos que
--debe retornar son:
--Código del cliente
--Cantidad de veces que compro en el último año
--Promedio por compra en el último año
--Cantidad de productos diferentes que compro en el último año
--Monto de la mayor compra que realizo en el último año
--Se deberán retornar todos los clientes ordenados por la cantidad de veces que compro en
--el último año.
--No se deberán visualizar NULLs en ninguna columna

select clie_codigo, (
select fact_cliente AS 'Codigo de Cliente',
count(fact_total) AS 'Compras del Cliente'
from Factura
where year(fact_fecha) = 2012
group by fact_cliente
),
(
select fact_cliente, AVG(fact_total) AS 'total'
from Factura
group by fact_cliente
),

from Cliente



select * from Item_Factura
select * from Factura
order by fact_cliente

select fact_cliente, AVG(fact_total) AS 'total'
from Factura
group by fact_cliente

SELECT 
	clie_codigo AS 'Cliente',
	ISNULL(COUNT(*), 0) AS 'Cantidad compras',
	ISNULL(AVG(fact_total), 0) AS  'Promedio compras',	
	ISNULL((SELECT ISNULL(COUNT(DISTINCT item_producto), 0) 
	FROM Item_Factura
	JOIN Factura ON item_numero + item_sucursal + item_tipo = 
	fact_numero + fact_sucursal + fact_tipo
	WHERE YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura)
	AND fact_cliente = clie_codigo
	GROUP BY fact_cliente), 0) AS 'Productos comprados',
	ISNULL(MAX(fact_total), 0) AS 'Maxima compra'
FROM Cliente
JOIN Factura ON clie_codigo = fact_cliente
WHERE YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura) 
GROUP BY clie_codigo
UNION
(SELECT clie_codigo, 0, 0, 0, 0 FROM Cliente
WHERE NOT EXISTS 
(SELECT fact_cliente FROM Factura 
WHERE fact_cliente = clie_codigo
AND YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura)))
ORDER BY 2 DESC

--Realizar una consulta que retorne el detalle de la familia, la cantidad diferentes de
--productos vendidos y el monto de dichas ventas sin impuestos. Los datos se deberán
--ordenar de mayor a menor, por la familia que más productos diferentes vendidos tenga,
--solo se deberán mostrar las familias que tengan una venta superior a 20000 pesos para
--el año 2012.

select fami_detalle AS 'Familia',
count(DISTINCT prod_codigo) AS 'Productos vendidos sin repetidos',
sum(item_precio * item_cantidad) AS 'Total de Ventas'
from Familia
JOIN Producto on prod_familia = fami_id
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura ON item_numero + item_tipo + item_sucursal = fact_numero + fact_tipo + fact_sucursal
group by fami_detalle, fami_id
HAVING (SELECT SUM(item_cantidad * item_precio)
FROM Producto
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura ON item_numero + item_tipo + item_sucursal = fact_numero + fact_tipo + fact_sucursal
WHERE YEAR(fact_fecha) = 2012 
AND prod_familia = fami_id) > 20000
order by 2 desc


--Mostrar nombre de producto1, cantidad de clientes distintos que lo compraron2, importe
--promedio pagado por el producto3, cantidad de depósitos en los cuales hay stock del
--producto4 y stock actual del producto en todos los depósitos5. Se deberán mostrar
--aquellos productos que hayan tenido operaciones en el año 2012 y los datos deberán
--ordenarse de mayor a menor por monto vendido del producto.

select prod_detalle AS 'nombre del producto',
COUNT(DISTINCT fact_cliente) AS 'Clientes distintos que compraron el producto',
sum(item_cantidad) AS 'Cantidad del Producto',
sum(item_precio) AS 'Suma de Precios',
(select stoc_producto AS 'ID Producto',
COUNT(stoc_deposito) AS 'Depositos',
sum(stoc_cantidad) AS 'Suma de Stock en los Depositos'
from STOCK
group by stoc_producto
having sum(stoc_cantidad) > 0)
from Item_Factura
JOIN Factura ON item_numero + item_tipo + item_sucursal = fact_numero + fact_tipo + fact_sucursal
JOIN Producto ON prod_codigo = item_producto
group by prod_detalle
order by prod_detalle 

select stoc_producto AS 'ID Producto',
COUNT(stoc_deposito) AS 'Depositos',
sum(stoc_cantidad) AS 'Suma de Stock en los Depositos'
from STOCK
group by stoc_producto
having sum(stoc_cantidad) > 0
order by 3 desc


--Realizar una consulta que retorne para cada producto que posea composición nombre
--del producto, precio del producto, precio de la sumatoria de los precios por la cantidad 
--de los productos que lo componen. Solo se deberán mostrar los productos que estén
--compuestos por más de 2 productos y deben ser ordenados de mayor a menor por
--cantidad de productos que lo componen.

select * from Composicion
--ACLARACION: Esta bien que no muestre nada ya que no hay productos que esten
--compuestos por mas de 2 productos, si modifica el 2 del HAVING por un 1 se puede
--ver los productos compuestos por mas de un producto que en este caso seria todos
--los que existen en la BD actualmente

SELECT 
	P1.prod_detalle AS 'Producto',  
	P1.prod_precio AS 'Precio',
	SUM(comp_cantidad * P2.prod_precio) AS 'Precio compuesto'
FROM Producto P1
JOIN Composicion ON P1.prod_codigo = comp_producto
JOIN Producto P2 ON comp_componente = P2.prod_codigo
GROUP BY P1.prod_codigo, P1.prod_detalle, P1.prod_precio
HAVING COUNT(DISTINCT comp_componente ) > 1 -- iria 2
ORDER BY COUNT(DISTINCT comp_componente) DESC