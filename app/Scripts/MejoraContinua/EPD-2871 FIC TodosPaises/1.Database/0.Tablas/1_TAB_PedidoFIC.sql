GO
IF OBJECT_ID('PedidoFIC') IS NULL
BEGIN
	CREATE TABLE PedidoFIC (
		[CampaniaID] [int] NOT NULL,
		[PedidoID] [int] NOT NULL,
		[ConsultoraID] [bigint] NOT NULL,
		[FechaRegistro] [datetime] NOT NULL,
		[FechaModificacion] [datetime] NULL,
		[FechaReserva] [smalldatetime] NULL,
		[Clientes] [smallint] NOT NULL,
		[ImporteTotal] [money] NOT NULL,
		[ImporteCredito] [money] NOT NULL,
		[EstadoPedido] [smallint] NOT NULL,
		[ModificaPedidoReservado] [bit] NULL,
		[MotivoCreditoID] [smallint] NULL,
		[PaisID] [tinyint] NOT NULL,
		[Bloqueado] [bit] NOT NULL,
		[DescripcionBloqueo] [varchar](200) NULL,
		[IndicadorEnviado] [bit] NOT NULL,
		[FechaProceso] [smalldatetime] NULL,
		[IPUsuario] [varchar](25) NULL,
		[EstimadoGanancia] [money] NULL,
		[CodigoUsuarioCreacion] [varchar](25) NULL,
		[CodigoUsuarioModificacion] [varchar](25) NULL,
		CONSTRAINT [PK_PedidoFIC] PRIMARY KEY CLUSTERED 
		(
			[CampaniaID] ASC,
			[PedidoID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY];

	ALTER TABLE [dbo].[PedidoFIC] ADD  CONSTRAINT [DF_PedidoFIC_Bloqueado]  DEFAULT ((0)) FOR [Bloqueado]
	ALTER TABLE [dbo].[PedidoFIC] ADD  CONSTRAINT [DF__PedidoFIC__Indic__725BF7F6]  DEFAULT ((0)) FOR [IndicadorEnviado]
	ALTER TABLE [dbo].[PedidoFIC] ADD  DEFAULT ((0)) FOR [EstimadoGanancia]
	ALTER TABLE [dbo].[PedidoFIC]  WITH CHECK ADD  CONSTRAINT [FK_PedidoFIC_Pais] FOREIGN KEY([PaisID])	REFERENCES [dbo].[Pais] ([PaisID])
	ALTER TABLE [dbo].[PedidoFIC] CHECK CONSTRAINT [FK_PedidoFIC_Pais]
	ALTER TABLE [dbo].[PedidoFIC]  WITH CHECK ADD  CONSTRAINT [FK_PedidoFIC_TablaLogicaDatos] FOREIGN KEY([MotivoCreditoID]) REFERENCES [dbo].[TablaLogicaDatos] ([TablaLogicaDatosID])
	ALTER TABLE [dbo].[PedidoFIC] CHECK CONSTRAINT [FK_PedidoFIC_TablaLogicaDatos]
	ALTER TABLE [dbo].[PedidoFIC]  WITH CHECK ADD  CONSTRAINT [FK_PedidoFIC_TablaLogicaDatos_EstadoPedido] FOREIGN KEY([EstadoPedido]) REFERENCES [dbo].[TablaLogicaDatos] ([TablaLogicaDatosID])
	ALTER TABLE [dbo].[PedidoFIC] CHECK CONSTRAINT [FK_PedidoFIC_TablaLogicaDatos_EstadoPedido]
END
GO