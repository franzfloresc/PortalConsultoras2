USE [BelcorpPeru]
GO
ALTER view [dbo].[vwSituacionPedido]
AS
SELECT 1 AS ID, 'Pedido Recibido' AS Situacion, 'Etapa 1' AS Etapa
UNION
SELECT 2 AS ID,  'Facturado' AS Situacion, 'Etapa 2' AS Etapa
UNION
SELECT 3 AS ID,  'Inicio de Armado' AS Situacion, 'Etapa 3' AS Etapa
UNION
SELECT 4 AS ID,  'Chequeado' AS Situacion, 'Etapa 4' AS Etapa
UNION
SELECT 5 AS ID,  'Puesto en transporte' AS Situacion, 'Etapa 5' AS Etapa
UNION
SELECT 6 AS ID, 'Fecha Estimada de Entrega' AS Situacion, '' AS Etapa
UNION
SELECT 7 AS ID, 'Entregado' AS Situacion, 'Etapa 6' AS Etapa
GO