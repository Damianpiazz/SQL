use REDVEN;
GO

/*Realizar una seleccion que le permita listar la cantidad de veces que se vendio cada producto en el año
actual. Cantidad de veces, no es cantidad de articulos.*/

SELECT cantidadVentas = COUNT(Iv.idArticulo), A.Descripcion
FROM Articulo A JOIN ItemVenta Iv ON A.idArticulo = Iv.idArticulo JOIN Venta V ON Iv.idVenta = V.idVenta
WHERE YEAR (V.Fecha) = 2019
GROUP BY A.Descripcion
ORDER BY cantidadVentas DESC;