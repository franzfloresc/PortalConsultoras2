﻿USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValidarLoginJsonWebToken]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ValidarLoginJsonWebToken]
GO