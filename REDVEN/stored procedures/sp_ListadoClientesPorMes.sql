use REDVEN;
GO

/*Cree el SP, en la que recibiendo un mes y año, devuelva el listado
clientes que compraron en ese periodo. En caso de no haber ningun
cliente, que devuelva la leyenda SIN CLIENTES.*/

CREATE PROCEDURE ListadoClientesPorMes
@m INT,
@a INT
AS BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT C.*
    FROM Cliente C
    JOIN Venta V ON C.Token = V.Token
    WHERE MONTH(V.Fecha) = @m AND YEAR(V.Fecha) = @a;

    IF @@ROWCOUNT = 0
    BEGIN
        SELECT 'SIN CLIENTES' AS Mensaje;
    END
END;
GO

EXEC ListadoClientesPorMes @m = 5, @a = 2023;
GO