
update CDRWebDescripcion set Descripcion =  'CAMBIARLO POR EL MISMO PRODUCTO' WHERE CDRWebDescripcionID = 6 AND CodigoSSIC = 'C'

update CDRWebDescripcion set Descripcion =  'DEVOLUCI�N' WHERE CDRWebDescripcionID = 7 AND CodigoSSIC = 'D'

update CDRWebDescripcion set Descripcion =  'Reenv�o del mismo producto' WHERE CDRWebDescripcionID = 5 AND CodigoSSIC = 'C'
and tipo = 'Finalizado'

update CDRWebDescripcion set Descripcion =  'Devoluci�n del mismo producto' WHERE CDRWebDescripcionID in (10,30) AND CodigoSSIC in ('D','G')
and tipo = 'Finalizado'








