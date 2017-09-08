GO
IF OBJECT_ID('TempPedidoFICID') IS NULL
BEGIN
	CREATE TABLE TempPedidoFICID(
		[NroLote] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[PedidoID] [int] NOT NULL,
		CONSTRAINT [PK_TempPedidoFICID] PRIMARY KEY CLUSTERED 
		(
			[NroLote] ASC,
			[CampaniaID] ASC,
			[PedidoID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY];
END
GO