USE ventas_e;
GO

/*Sobre la nueva base de datos creada en el Ejercicio Nro. 1, genere:*/

/*a.Una tabla Usuario con los siguientes campos:
Token (uniqueidentifier).
AyN (varchar(100))
Usuario (varchar(50))
Password (varchar(25))*/

CREATE TABLE Usuario (
    Token UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), -- Genera un GUID unico
    AyN VARCHAR(100) NOT NULL,
    Usuario VARCHAR(50) NOT NULL,
    Password VARCHAR(25) NOT NULL
);

/*b. Otra tabla que sirva para registrar una Empresa:
idEmpresa (int)
RazonSocial (varvhar(100))
CUIT (varchar(13))
Dominio (varchar(50))*/


CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY,
    RazonSocial VARCHAR(100) NOT NULL,
    CUIT VARCHAR(13) NOT NULL,
    Dominio VARCHAR(50) NOT NULL
);
GO

/*c. Ahora, se requiere que se cree una tabla relacional entre ambas tablas, que determine la
relacion de cada Usuario con cada Empresa. Como nombre de la tabla se propone:
UsuarioXEmpresa.*/

CREATE TABLE UsuarioXEmpresa (
    Token UNIQUEIDENTIFIER NOT NULL,
    idEmpresa INT NOT NULL,
    PRIMARY KEY (Token, idEmpresa),
    FOREIGN KEY (Token) REFERENCES Usuario(Token),
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);
GO

/*d. Establezca las relaciones entre cada tabla. Que tipo de restricciones cree que deben tener
para el borrado y modificacion? Justifique, y aplique dichas relaciones a las tablas que ha
creado.*/

CREATE TABLE UsuarioXEmpresa (
    Token UNIQUEIDENTIFIER NOT NULL,
    idEmpresa INT NOT NULL,
    PRIMARY KEY (Token, idEmpresa),
    CONSTRAINT FK_UsuarioXEmpresa_Usuario FOREIGN KEY (Token)
        REFERENCES Usuario(Token)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_UsuarioXEmpresa_Empresa FOREIGN KEY (idEmpresa)
        REFERENCES Empresa(idEmpresa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

/*
ON DELETE CASCADE:
Para evitar registros huerfanos en UsuarioXEmpresa cuando se borra un usuario o una empresa.

ON UPDATE CASCADE:
Para mantener la integridad referencial si alguna clave primaria se actualiza (aunque en la practica raramente se cambia).
*/

/*e. Si este modelo creado, fuera a ser utilizado para un sistema que correrr en la nube, y que
podre tener relaciones con otros sistemas de terceros, y crecer de manera abierta. Cree
Usted que la especificacion de las claves en cada tabla es la correcta? Que correccion
aplicara? Realice los cambios necesarios para dejar el modelo de manera correcta segun su
percepcion.*/

/*Tabla Empresa
Problema: idEmpresa es INT. Esto limita la cantidad de registros posibles y puede generar colisiones si se necesita integrarse con otras bases.

Correccion: Usar una clave primaria UUID (uniqueidentifier).
*/

DROP TABLE IF EXISTS UsuarioXEmpresa;
DROP TABLE IF EXISTS Empresa;
GO

CREATE TABLE Empresa (
    idEmpresa UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    RazonSocial VARCHAR(100),
    CUIT VARCHAR(13),
    Dominio VARCHAR(50)
);
GO

/*Tabla Usuario
Situacion actual: Ya usa Token como uniqueidentifier.

Posible mejora: Agregar un campo Email (unico) como identificador logico (aunque no clave primaria).
*/

DROP TABLE IF EXISTS Usuario;
GO

CREATE TABLE Usuario (
    Token UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    AyN VARCHAR(100),
    Usuario VARCHAR(50),
    Password VARCHAR(25),
    Email VARCHAR(100) UNIQUE NOT NULL-- agregar Email UNIQUE NOT NULL
);

/*Tabla UsuarioXEmpresa
Problema: Si se mantiene idEmpresa como INT, no seria compatible con el cambio propuesto.

Correccion: Actualizar para usar UUID.*/

CREATE TABLE UsuarioXEmpresa (
    Token UNIQUEIDENTIFIER NOT NULL,
    idEmpresa UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Token, idEmpresa),
    FOREIGN KEY (Token) REFERENCES Usuario(Token)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO