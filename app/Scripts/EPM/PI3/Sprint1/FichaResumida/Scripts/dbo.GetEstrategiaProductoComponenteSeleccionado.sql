USE BelcorpChile_BPT;
GO

create procedure dbo.GetEstrategiaProductoComponenteSeleccionado
(
	 @pCampaniaID bigint
	,@pConsultoraID bigint
	,@pSetID int
)
as
begin
	select 
		 pws.EstrategiaID
		,psd.CuvProducto
		,psd.EstrategiaProductoID
		,pws.Cantidad
	from	pedidowebset pws
	join	pedidowebsetdetalle psd on(pws.SetID = psd.SetID)
	where	 
		((pws.Campania = @pCampaniaID) 
		 and (pws.ConsultoraID = @pConsultoraID) 
		 and (pws.SetID = @pSetID) 
		);
end;

USE BelcorpPeru_BPT;
GO

create procedure dbo.GetEstrategiaProductoComponenteSeleccionado
(
	 @pCampaniaID bigint
	,@pConsultoraID bigint
	,@pSetID int
)
as
begin
	select 
		 pws.EstrategiaID
		,psd.CuvProducto
		,psd.EstrategiaProductoID
		,pws.Cantidad
	from	pedidowebset pws
	join	pedidowebsetdetalle psd on(pws.SetID = psd.SetID)
	where	 
		((pws.Campania = @pCampaniaID) 
		 and (pws.ConsultoraID = @pConsultoraID) 
		 and (pws.SetID = @pSetID) 
		);
end;

USE BelcorpCostaRica_BPT;
GO

create procedure dbo.GetEstrategiaProductoComponenteSeleccionado
(
	 @pCampaniaID bigint
	,@pConsultoraID bigint
	,@pSetID int
)
as
begin
	select 
		 pws.EstrategiaID
		,psd.CuvProducto
		,psd.EstrategiaProductoID
		,pws.Cantidad
	from	pedidowebset pws
	join	pedidowebsetdetalle psd on(pws.SetID = psd.SetID)
	where	 
		((pws.Campania = @pCampaniaID) 
		 and (pws.ConsultoraID = @pConsultoraID) 
		 and (pws.SetID = @pSetID) 
		);
end;