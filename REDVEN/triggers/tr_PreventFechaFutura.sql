use REDVEN
GO

-- Por politica de la empresa, no se pueden registrar ventas con una fecha mayor al dia actual.
-- Cree un trigger que evite la insercion de ventas con fecha futura.

CREATE TRIGGER tr_PreventFechaFutura
ON Venta
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Fecha > GETDATE())
    BEGIN
        RAISERROR('No se puede insertar una venta con fecha futura.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;