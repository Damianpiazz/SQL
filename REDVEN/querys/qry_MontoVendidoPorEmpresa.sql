use REDVEN;
GO

/*Resuelva el listado que devuelva cual fue el monto vendido por empresa en el año actual.*/

SELECT E.RazonSocial AS Empresa, COALESCE(SUM(IV.Cantidad * IV.Precio), 0) AS MontoVendido
FROM Empresa E LEFT JOIN Venta V ON E.idEmrpesa = V.idEmpresa AND YEAR(V.Fecha) = YEAR(GETDATE()) LEFT JOIN ItemVenta IV ON V.idVenta = IV.idVenta
GROUP BY E.RazonSocial
ORDER BY MontoVendido DESC;