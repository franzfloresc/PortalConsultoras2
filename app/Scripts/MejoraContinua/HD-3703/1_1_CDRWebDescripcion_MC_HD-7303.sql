
update CDRWebDescripcion set Descripcion =  'CAMBIARLO POR EL MISMO PRODUCTO' WHERE CDRWebDescripcionID = 6 AND CodigoSSIC = 'C'

update CDRWebDescripcion set Descripcion =  'DEVOLUCIÓN' WHERE CDRWebDescripcionID = 7 AND CodigoSSIC = 'D'

update CDRWebDescripcion set Descripcion =  'Reenvío del mismo producto' WHERE CDRWebDescripcionID = 5 AND CodigoSSIC = 'C'
and tipo = 'Finalizado'

update CDRWebDescripcion set Descripcion =  'Devolución del mismo producto' WHERE CDRWebDescripcionID in (10,30) AND CodigoSSIC in ('D','G')
and tipo = 'Finalizado'








