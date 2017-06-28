use BelcorpMexico
go
Create Index idx_Cupon_01 on Cupon(CampaniaId,Estado)
Create Index idx_CuponConsultora_01 on CuponConsultora(CuponID,CampaniaId,CodigoConsultora,EstadoCupon)
