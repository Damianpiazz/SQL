use REDVEN;
GO

/*Realizar una seleccion que le permita listar toda la informacion pertinente de aquellos usuarios que tienen
el apellido Martinez.*/

select *
from Cliente C
where C.RazonSocial like '%Martinez%'