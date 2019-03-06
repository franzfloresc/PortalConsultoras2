db.getCollection("TipoEstrategia").update({ "CodigoTipoEstrategia": "031" }, {    
$set: {
        
        "TipoEstrategiaId": NumberInt("3026"),
        "TipoPersonalizacion": "ATP",
        "DescripcionTipoEstrategia": "Arma tu Pack",
        "ImagenEstrategia": "\u0000",
        "Orden": NumberInt("1"),
        "FlagActivo": true,
        "FlagNueva": false,
        "FlagRecoProduc": false,
        "FlagRecoPerfil": true,
        "CodigoPrograma": "\u0000",
        "Codigo": "031",
        "FlagValidarImagen": false,
        "PesoMaximoImagen": NumberInt("0"),
        "UsuarioCreacion": "ADMCONTENIDO",
        "FechaCreacion": ISODate("2019-02-17T18:36:29.130-05:00")
    }
    ,
    {upsert:true}
})