use REDVEN;
GO

/*Listar solamente el apellido y nombres (orden descendente) de todos los clientes.*/

SELECT RazonSocial 
FROM Cliente
ORDER BY RazonSocial DESC;