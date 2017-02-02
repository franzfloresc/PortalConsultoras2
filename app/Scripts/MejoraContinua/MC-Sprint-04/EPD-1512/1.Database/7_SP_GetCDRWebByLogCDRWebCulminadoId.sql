USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebByLogCDRWebCulminadoId
END
GO
CREATE procedure dbo.GetCDRWebByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
as
begin
	select
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	from LogCDRWebCulminado
	where LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
end
GO