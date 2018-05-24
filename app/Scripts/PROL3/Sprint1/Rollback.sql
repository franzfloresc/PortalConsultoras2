USE BelcorpBolivia
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpChile
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpColombia
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpCostaRica
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpDominicana
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpEcuador
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpGuatemala
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpMexico
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpPanama
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpPeru
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO
/*end*/

USE BelcorpSalvador
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;
END
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Codigo VARCHAR(150) NOT NULL;
GO
ALTER TABLE dbo.TablaLogicaDatos
ALTER COLUMN Descripcion VARCHAR(150) NOT NULL;
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'PedidoSapId'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP CONSTRAINT DF_PedidoWeb_PedidoSapId;

    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN PedidoSapId;
END
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PedidoWeb' AND COLUMN_NAME = 'VersionProl'))
BEGIN
    ALTER TABLE dbo.PedidoWeb
	DROP COLUMN VersionProl;
END
GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop table dbo.PedidoWebDetalleExplotado;
END
GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
		   PaisID,
		   DiasAntes,
		   HoraInicio,
		   HoraFin,
		   HoraInicioNoFacturable,
		   HoraCierreNoFacturable,
		   FlagNoValidados,
		   ProcesoRegular,
		   ProcesoDA,
		   ProcesoDAPRD,
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO
IF (EXISTS(SELECT 1	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ConfiguracionValidacion' AND COLUMN_NAME = 'TieneProl3'))
BEGIN
    ALTER TABLE dbo.ConfiguracionValidacion
	DROP CONSTRAINT DF_ConfiguracionValidacion_TieneProl3;

    ALTER TABLE dbo.ConfiguracionValidacion
	DROP COLUMN TieneProl3;
END
GO