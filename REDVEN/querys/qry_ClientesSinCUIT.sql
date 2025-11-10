use REDVEN;
GO

/*Realizar una seleccion que le permita listar solamente el aapellido y nombre y DNI de todos los clientes
ordenados por DNI (ascendente), que no tengan un CUIT registrado.*/

SELECT RazonSocial, DNI, CUIT
FROM Cliente C
WHERE C.CUIT IS NULL
ORDER BY DNI ASC;
GO
