USE BelcorpPeru
GO

UPDATE CDRWebDescripcion
SET Descripcion = 'REENV�O DEL MISMO PRODUCTO'
WHERE CDRWebDescripcionID = 6
	AND CodigoSSIC = 'C'

UPDATE CDRWebDescripcion
SET Descripcion = 'DEVOLUCI�N'
WHERE CDRWebDescripcionID = 7
	AND CodigoSSIC = 'D'

UPDATE CDRWebDescripcion
SET Descripcion = 'Reenv�o del mismo producto'
WHERE CDRWebDescripcionID = 5
	AND CodigoSSIC = 'C'
	AND tipo = 'Finalizado'

UPDATE CDRWebDescripcion
SET Descripcion = 'Devoluci�n del mismo producto'
WHERE CDRWebDescripcionID IN (
		10
		,30
		)
	AND CodigoSSIC IN (
		'D'
		,'G'
		)
	AND tipo = 'Finalizado'
GO




