USE ventas_e;
GO

/*6) Como futuros ingenieros, sabemos muy bien que la informaci�n a trav�s del tiempo var�a
constantemente. En consecuencia, este ejercicio consta en que se reflejen los siguientes cambios en la
informaci�n.*/

/*6) a. Lionel Galo abandon� la Empresa en la que trabajaba, y fue contratado por CGO.*/

-- Primero obtenemos los IDs necesarios
DECLARE @LionelToken UNIQUEIDENTIFIER;
DECLARE @GoicoecheaID UNIQUEIDENTIFIER;
DECLARE @CGOID UNIQUEIDENTIFIER;

SELECT @LionelToken = Token FROM Usuario WHERE AyN = 'Lionel Galo';
SELECT @GoicoecheaID = idEmpresa FROM Empresa WHERE RazonSocial = 'GOLCOECHEA';
SELECT @CGOID = idEmpresa FROM Empresa WHERE RazonSocial = 'CGO';

-- Eliminamos la relaci�n con Goicoechea
DELETE FROM UsuarioXEmpresa 
WHERE Token = @LionelToken AND idEmpresa = @GoicoecheaID;

-- Creamos la nueva relaci�n con CGO
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
VALUES (@LionelToken, @CGOID);

-- Verificamos el cambio
SELECT u.AyN, e.RazonSocial 
FROM Usuario u
JOIN UsuarioXEmpresa uxe ON u.Token = uxe.Token
JOIN Empresa e ON uxe.idEmpresa = e.idEmpresa
WHERE u.AyN = 'Lionel Galo';

/*6) b. Maximiliano Gonzalez, fue enrolado en el ej�rcito por lo que pidi� la baja de la Empresa
Albocar en la que trabajaba hasta su regreso.*/

USE ventas_e;
GO

-- 6b. Maximiliano Gonzalez pidio la baja de Albocar por enrolamiento en el ej�rcito

-- Obtener los IDs necesarios
DECLARE @MaxiToken UNIQUEIDENTIFIER;
DECLARE @AlbocarID UNIQUEIDENTIFIER;

SELECT @MaxiToken = Token FROM Usuario WHERE AyN = 'Maximiliano Gonzalez';
SELECT @AlbocarID = idEmpresa FROM Empresa WHERE RazonSocial = 'ALBOCAR';

-- Eliminar la relaci�n con Albocar (pero mantener al usuario en la tabla Usuario)
DELETE FROM UsuarioXEmpresa 
WHERE Token = @MaxiToken AND idEmpresa = @AlbocarID;

-- Verificar cambio
SELECT 
    u.AyN AS 'Nombre',
    CASE 
        WHEN e.RazonSocial IS NULL THEN 'Sin empresa actual'
        ELSE e.RazonSocial 
    END AS 'Empresa'
FROM Usuario u
LEFT JOIN UsuarioXEmpresa uxe ON u.Token = uxe.Token
LEFT JOIN Empresa e ON uxe.idEmpresa = e.idEmpresa
WHERE u.AyN = 'Maximiliano Gonzalez';

/*6) c. */

USE ventas_e;
GO

-- Albocar adquirir Az Motor y todos sus empleados

-- Obtenemos los IDs necesarios
DECLARE @AlbocarID UNIQUEIDENTIFIER;
DECLARE @AzMotorID UNIQUEIDENTIFIER;

SELECT @AlbocarID = idEmpresa FROM Empresa WHERE RazonSocial = 'ALBOCAR';
SELECT @AzMotorID = idEmpresa FROM Empresa WHERE RazonSocial = 'AZ MOTOR';

-- Transferir todos los empleados de Az Motor a Albocar
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT uxe.Token, @AlbocarID
FROM UsuarioXEmpresa uxe
WHERE uxe.idEmpresa = @AzMotorID
AND NOT EXISTS (
    SELECT 1 
    FROM UsuarioXEmpresa 
    WHERE Token = uxe.Token AND idEmpresa = @AlbocarID
);

-- Opcional: Marcar Az Motor como inactiva o eliminarla
-- Opcion A: Actualizar el estado (requerira columna adicional como 'Activo')
/*
UPDATE Empresa 
SET Activo = 0 
WHERE idEmpresa = @AzMotorID;
*/

-- Opcion B: Eliminar la empresa (si es definitivo)
-- Primero debemos eliminar las relaciones para mantener integridad referencial
/*
DELETE FROM UsuarioXEmpresa WHERE idEmpresa = @AzMotorID;
DELETE FROM Empresa WHERE idEmpresa = @AzMotorID;
*/

-- Verificacion de los cambios
SELECT 
    u.AyN AS 'Empleado',
    e.RazonSocial AS 'Empresa Actual',
    CASE 
        WHEN e.RazonSocial = 'ALBOCAR' THEN 'Transferido'
        ELSE 'Original'
    END AS 'Estado'
FROM Usuario u
JOIN UsuarioXEmpresa uxe ON u.Token = uxe.Token
JOIN Empresa e ON uxe.idEmpresa = e.idEmpresa
WHERE EXISTS (
    SELECT 1 
    FROM UsuarioXEmpresa 
    WHERE Token = u.Token AND idEmpresa = @AzMotorID
)
ORDER BY e.RazonSocial, u.AyN;

/*6) D. Luego, por un problema de seguridad, todos los empleados de Goicoechea han tenido que
cambiar sus contraseñas.*/

USE ventas_e;
GO

-- d. Cambio de contraseñas para todos los empleados de Goicoechea por problemas de seguridad

-- Variables
DECLARE @GoicoecheaID UNIQUEIDENTIFIER;
DECLARE @NuevaContrase�aBase VARCHAR(25) = 'Goicoechea2023!';
DECLARE @Contador INT = 1;

-- Obtenemos el ID de Goicoechea
SELECT @GoicoecheaID = idEmpresa FROM Empresa WHERE RazonSocial = 'GOLCOECHEA';

-- Creamos una tabla temporal para almacenar los tokens de los empleados
CREATE TABLE #EmpleadosGoicoechea (
    RowNum INT IDENTITY(1,1),
    Token UNIQUEIDENTIFIER,
    AyN VARCHAR(100)
);

-- Insertamos los empleados de Goicoechea en la tabla temporal
INSERT INTO #EmpleadosGoicoechea (Token, AyN)
SELECT u.Token, u.AyN
FROM Usuario u
JOIN UsuarioXEmpresa uxe ON u.Token = uxe.Token
WHERE uxe.idEmpresa = @GoicoecheaID;

-- Actualizar contraseñas con un patron unico para cada usuario
WHILE @Contador <= (SELECT COUNT(*) FROM #EmpleadosGoicoechea)
BEGIN
    DECLARE @TokenActual UNIQUEIDENTIFIER;
    DECLARE @NombreActual VARCHAR(100);
    DECLARE @NuevaContrase�a VARCHAR(25);
    
    SELECT @TokenActual = Token, @NombreActual = AyN 
    FROM #EmpleadosGoicoechea 
    WHERE RowNum = @Contador;
    
    -- Generar una contraseña unica basada en el nombre y un patron
    SET @NuevaContrase�a = LEFT(REPLACE(@NombreActual, ' ', ''), 5) + 
                          CAST(@Contador AS VARCHAR(2)) + '!Sec2023';
    
    -- Actualizar la contrase�a
    UPDATE Usuario 
    SET Password = @NuevaContrase�a
    WHERE Token = @TokenActual;
    
    -- Opcional: Registrar el cambio en tabla de auditoria
    /* INSERT INTO AuditoriaContraseñas (Token, FechaCambio, Motivo)
    VALUES (@TokenActual, GETDATE(), 'Cambio obligatorio por seguridad') */
    
    SET @Contador = @Contador + 1;
END

-- Mostrar los cambios realizados (solo para verificaci�n)
SELECT 
    u.AyN AS 'Empleado',
    '********' AS 'NuevaContrase�a', 
    'Contrase�a actualizada' AS 'Estado'
FROM Usuario u
JOIN UsuarioXEmpresa uxe ON u.Token = uxe.Token
WHERE uxe.idEmpresa = @GoicoecheaID
ORDER BY u.AyN;

-- Eliminar la tabla temporal
DROP TABLE #EmpleadosGoicoechea;