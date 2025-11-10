use REDVEN;
GO

/*Devolver el listado de los Usuarios que estan registrados en mes de una empresa. Devolver, Apellido y
Nombre, y la cantidad de empresas en las que se encuentra registrado.*/

SELECT u.AyN, COUNT(uxe.idEmpresa) AS CantidadEmpresas
FROM Usuario u JOIN UsuarioXEmpresa uxe ON u.UserToken = uxe.UserToken
GROUP BY u.AyN
HAVING COUNT(uxe.idEmpresa) > 1;