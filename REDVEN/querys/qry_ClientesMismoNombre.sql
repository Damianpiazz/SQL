use REDVEN;
GO

/*Muestre un informe que brinde como resultado: la cantidad de clientes que tienen un mismo nombre.
Debe indicar Nombre, Cantidad.*/

SELECT COUNT(*) 
FROM (
    SELECT C.RazonSocial, COUNT(*) AS Cantidad /*Ejemplo sub consulta*/
    FROM Cliente C
    GROUP BY C.RazonSocial
    HAVING COUNT(*) > 1
) AS TMP;

/*Coreccion*/

SELECT C.RazonSocial AS Nombre, COUNT(*) AS Cantidad /*elegir que columnas o valores se mostraron en el resultado.*/
FROM Cliente C
GROUP BY C.RazonSocial
HAVING COUNT(*) > 1;