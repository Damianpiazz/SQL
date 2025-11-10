use REDVEN;
GO

/*Listar los clientes que estan registrados como Responsables Inscriptos, pero no tienen registrado su
CUIT como es debido.*/

SELECT C.RazonSocial
FROM Cliente C JOIN TipoDeIva Ti ON C.IDTipoIva = Ti.IDTipoIva
WHERE Ti.Descripcion = 'Responsable inscripto' AND (C.CUIT IS NULL OR LEN(C.CUIT) <> 13);