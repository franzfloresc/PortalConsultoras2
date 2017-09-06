GO
IF OBJECT_ID('PedidoFICDetalle') IS NULL
BEGIN
	CREATE TABLE PedidoFICDetalle (
		[CampaniaID] [int] NOT NULL,
		[PedidoID] [int] NOT NULL,
		[PedidoDetalleID] [smallint] NOT NULL,
		[MarcaID] [tinyint] NULL,
		[ConsultoraID] [bigint] NULL,
		[ClienteID] [smallint] NULL,
		[Cantidad] [int] NOT NULL,
		[PrecioUnidad] [money] NOT NULL,
		[ImporteTotal] [money] NOT NULL,
		[CUV] [varchar](20) NOT NULL,
		[OfertaWeb] [bit] NULL,
		[CUVPadre] [varchar](20) NULL,
		[ModificaPedidoReservado] [bit] NULL,
		[PedidoDetalleIDPadre] [smallint] NULL,
		[ConfiguracionOfertaID] [int] NULL,
		[TipoOfertaSisID] [int] NULL,
		[CodigoUsuarioCreacion] [varchar](25) NULL,
		[CodigoUsuarioModificacion] [varchar](25) NULL,
		[FechaCreacion] [datetime] NULL,
		[FechaModificacion] [datetime] NULL,
		CONSTRAINT [PK_PedidoFICDetalle] PRIMARY KEY CLUSTERED 
		(
			[CampaniaID] ASC,
			[PedidoID] ASC,
			[PedidoDetalleID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY];

	ALTER TABLE [dbo].[PedidoFICDetalle] ADD  CONSTRAINT [DF_PedidoFICDetalle_OfertaWeb] DEFAULT ((0)) FOR [OfertaWeb];
	ALTER TABLE [dbo].[PedidoFICDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PedidoFICDetalle_Clientes] FOREIGN KEY([ConsultoraID], [ClienteID]) REFERENCES [dbo].[Cliente] ([ConsultoraID], [ClienteID]);
	ALTER TABLE [dbo].[PedidoFICDetalle] CHECK CONSTRAINT [FK_PedidoFICDetalle_Clientes];
	ALTER TABLE [dbo].[PedidoFICDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PedidoFICDetalle_PedidoFIC] FOREIGN KEY([CampaniaID], [PedidoID]) REFERENCES [dbo].[PedidoFIC] ([CampaniaID], [PedidoID]);
	ALTER TABLE [dbo].[PedidoFICDetalle] CHECK CONSTRAINT [FK_PedidoFICDetalle_PedidoFIC];
END
GO