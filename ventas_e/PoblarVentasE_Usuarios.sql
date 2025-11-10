USE ventas_e;
GO

/*
5) Poblar la tabla Usuario y establecer sus relaciones con Empresa:

- Belpe: Juan Barnetche, Miguel Valcaneras y Analia Zamora.
- CGO: Maximiliano Moreno y Tamara Castro.
- AZ MOTOR: Miguel Suarez.
- Goicoechea: Enrique Moreno, Lionel Galo y Esperanza Mendez 
  (Esperanza Mendez también está registrada en AUTOCLIPS VAER S.A.).
- Albocar: Maximiliano Gonzalez y Martín Perez.

Nota: Los datos personales y de login de cada usuario deben ser inventados para realizar la acción.
*/

-- Insertar usuarios con datos ficticios
-- Usuarios de Belpe
INSERT INTO Usuario (AyN, Password, Email, Domicilio, Telefono)
VALUES 
    ('Juan Barnetche', 'Ju4nB@rn', 'juan.barnetche@belpe.com', 'Calle 123, La Plata', '221 111-1111'),
    ('Miguel Valcaneras', 'M1gu3lV@l', 'miguel.valcaneras@belpe.com', 'Av. 7 720, La Plata', '221 222-2222'),
    ('Analia Zamora', 'An4l1@Z@m', 'analia.zamora@belpe.com', 'Calle 42 1500, La Plata', '221 333-3333');

-- Usuarios de CGO
INSERT INTO Usuario (AyN, Password, Email, Domicilio, Telefono)
VALUES 
    ('Maximiliano Moreno', 'M4x1M0r3n0', 'maximiliano.moreno@districgo.com', 'Diag. 80 1200, La Plata', '221 444-4444'),
    ('Tamara Castro', 'T4m4r4C45tr0', 'tamara.castro@districgo.com', 'Av. 13 850, La Plata', '221 555-5555');

-- Usuario de AZ MOTOR
INSERT INTO Usuario (AyN, Password, Email, Domicilio, Telefono)
VALUES 
    ('Miguel Suarez', 'M1gu3lS04r3z', 'miguel.suarez@azmotor.com', 'Calle 200 4500, La Plata', '221 666-6666');

-- Usuarios de Goicoechea
INSERT INTO Usuario (AyN, Password, Email, Domicilio, Telefono)
VALUES 
    ('Enrique Moreno', '3nr1qu3M0r', 'enrique.moreno@goicoechea.com', 'Av. 25 3100, La Plata', '221 777-7777'),
    ('Lionel Galo', 'L10n3lG4l0', 'lionel.galo@goicoechea.com', 'Calle 36 2800, La Plata', '221 888-8888'),
    ('Esperanza Mendez', '3sp3r4nz4M3n', 'esperanza.mendez@goicoechea.com', 'Av. 60 1900, La Plata', '221 999-9999');

-- Usuarios de Albocar
INSERT INTO Usuario (AyN, Password, Email, Domicilio, Telefono)
VALUES 
    ('Maximiliano Gonzalez', 'M4x1G0nz4l3z', 'maximiliano.gonzalez@albocar.com', 'Calle 67 500, La Plata', '221 000-0000'),
    ('Mart�n Perez', 'M4rt1nP3r3z', 'martin.perez@albocar.com', 'Av. 72 3300, La Plata', '221 101-0101');

-- Establecer relaciones UsuarioXEmpresa
-- Obtener IDs de empresas
DECLARE @BelpeID UNIQUEIDENTIFIER, @CGOID UNIQUEIDENTIFIER, @AzMotorID UNIQUEIDENTIFIER,
        @GoicoecheaID UNIQUEIDENTIFIER, @VaersaID UNIQUEIDENTIFIER, @AlbocarID UNIQUEIDENTIFIER;

SELECT @BelpeID = idEmpresa FROM Empresa WHERE RazonSocial = 'BELPE';
SELECT @CGOID = idEmpresa FROM Empresa WHERE RazonSocial = 'CGO';
SELECT @AzMotorID = idEmpresa FROM Empresa WHERE RazonSocial = 'AZ MOTOR';
SELECT @GoicoecheaID = idEmpresa FROM Empresa WHERE RazonSocial = 'GOLCOECHEA';
SELECT @VaersaID = idEmpresa FROM Empresa WHERE RazonSocial = 'AUTOCLIPS VAER SA';
SELECT @AlbocarID = idEmpresa FROM Empresa WHERE RazonSocial = 'ALBOCAR';

-- Relaciones Usuario-Empresa
-- Belpe (3 usuarios)
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT Token, @BelpeID FROM Usuario 
WHERE AyN IN ('Juan Barnetche', 'Miguel Valcaneras', 'Analia Zamora');

-- CGO (2 usuarios)
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT Token, @CGOID FROM Usuario 
WHERE AyN IN ('Maximiliano Moreno', 'Tamara Castro');

-- AZ MOTOR (1 usuario)
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT Token, @AzMotorID FROM Usuario 
WHERE AyN = 'Miguel Suarez';

-- Goicoechea (3 usuarios)
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT Token, @GoicoecheaID FROM Usuario 
WHERE AyN IN ('Enrique Moreno', 'Lionel Galo', 'Esperanza Mendez');

-- Esperanza Mendez tambien en Vaer SA
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT Token, @VaersaID FROM Usuario 
WHERE AyN = 'Esperanza Mendez';

-- Albocar (2 usuarios)
INSERT INTO UsuarioXEmpresa (Token, idEmpresa)
SELECT Token, @AlbocarID FROM Usuario 
WHERE AyN IN ('Maximiliano Gonzalez', 'Mart�n Perez');

-- Verificar datos insertados
SELECT u.AyN, e.RazonSocial 
FROM Usuario u
JOIN UsuarioXEmpresa uxe ON u.Token = uxe.Token
JOIN Empresa e ON uxe.idEmpresa = e.idEmpresa
ORDER BY e.RazonSocial, u.AyN;