use REDVEN
GO

-- Cada vez que se inserta una venta, se debe reducir el stock del producto correspondiente.
-- Cree un trigger que reste la cantidad vendida al stock en la tabla Producto.

CREATE TRIGGER tr_ActualizarStock
ON ItemVenta
AFTER INSERT
AS
BEGIN
    -- Actualiza el stock de los articulos restando la cantidad vendida
    UPDATE a
    SET a.Stock = a.Stock - i.Cantidad
    FROM Articulo a
    INNER JOIN inserted i ON a.idArticulo = i.idArticulo;
END;
GO