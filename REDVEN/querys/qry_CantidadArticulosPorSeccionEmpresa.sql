use REDVEN;
GO

/*Devuelva el listado de la cantidad de articulos registrada por cada seccion por cada empresa. Ordenar todo
por orden alfabetico.*/

SELECT Em.RazonSocial AS Empresa, Se.NombreSeccion AS Seccion, COUNT(A.idArticulo) AS Cantidad_Articulos
FROM Empresa Em JOIN Seccion Se ON Se.idEmpresa = Em.idEmrpesa JOIN Rubro Ru ON Ru.idSeccion = Se.idSeccion JOIN Articulo A ON A.idRubro = Ru.idRubro
GROUP BY Em.RazonSocial, Se.NombreSeccion
ORDER BY Em.RazonSocial ASC,Se.NombreSeccion ASC;