using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProducto
    {
        [DataMember]
        public string CodigoSAP { get; set; }

        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }

        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int IndicadorMontoMinimo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        public int MarcaID { get; set; }

        [DataMember]
        public bool EstaEnRevista { get; set; }

        [DataMember]
        public bool TieneStock { get; set; }
        [DataMember]
        public bool EsExpoOferta { get; set; }
        [DataMember]
        public string CUVRevista { get; set; }
        [DataMember]
        public string MensajeEstaEnRevista1 { get; set; }
        [DataMember]
        public string MensajeEstaEnRevista2 { get; set; }
        [DataMember]
        public string CUVComplemento { get; set; }

        [DataMember]
        public string DescripcionMarca { get; set; }
        [DataMember]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }

        [DataMember]
        public string FlagNueva { get; set; }
        [DataMember]
        public string TipoEstrategiaID { get; set; }

        [DataMember]
        public bool IndicadorOfertaCUV { get; set; }

        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string Volumen { get; set; }
        [DataMember]
        public string Tono { get; set; }
        [DataMember]
        public string ImagenOferta { get; set; }
        [DataMember]
        public string ImagenProducto { get; set; }
        [DataMember]
        public string ImagenURL { get; set; }
        [DataMember]
        public string DescripcionOferta { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }

        [DataMember]
        public string ImagenProductoSugerido { get; set; }

        [DataMember]
        public int TieneSugerido { get; set; }

        [DataMember]
        public string CodigoProducto { get; set; }

        [DataMember]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        public bool TieneOfertaRevista { get; set; }

        [DataMember]
        public bool TieneLanzamientoCatalogoPersonalizado { get; set; }

        [DataMember]
        public string TipoOfertaRevista { get; set; }

        [DataMember]
        public int CodigoCatalogo { get; set; }

        [DataMember]
        public string CatalogoDescripcion { get; set; }

        [DataMember]
        public string TextoBusqueda { get; set; }

        [DataMember]
        public string TipoEstrategiaCodigo { get; set; }

        [DataMember]
        public bool EsOfertaIndependiente { get; set; }        

        public BEProducto(IDataRecord datarec)
        {                               
            if (datarec.HasColumn("CUV")) CUV = Convert.ToString(datarec["CUV"]);
            if (datarec.HasColumn("CodigoSAP")) CodigoSAP = Convert.ToString(datarec["CodigoSAP"]);
            if (datarec.HasColumn("PrecioCatalogo")) PrecioCatalogo = Convert.ToDecimal(datarec["PrecioCatalogo"]);
            if (datarec.HasColumn("MarcaID")) MarcaID = Convert.ToInt32(datarec["MarcaID"]);
            if (datarec.HasColumn("EstaEnRevista")) EstaEnRevista = Convert.ToBoolean(datarec["EstaEnRevista"]);

            if (datarec.HasColumn("TieneStock")) TieneStock = Convert.ToBoolean(datarec["TieneStock"]);

            EsExpoOferta = false;
            if (datarec.HasColumn("EsExpoOferta"))
                EsExpoOferta = Convert.ToBoolean(datarec["EsExpoOferta"]);

            CUVRevista = string.Empty;
            if (datarec.HasColumn("CUVRevista"))
                CUVRevista = Convert.ToString(datarec["CUVRevista"]);

            if (datarec.HasColumn("CUVComplemento")) CUVComplemento = Convert.ToString(datarec["CUVComplemento"]);
            if (datarec.HasColumn("IndicadorMontoMinimo")) IndicadorMontoMinimo = Convert.ToInt32(datarec["IndicadorMontoMinimo"]);

            ConfiguracionOfertaID = 0;
            if (datarec.HasColumn("ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(datarec["ConfiguracionOfertaID"]);

            TipoOfertaSisID = 0;
            if (datarec.HasColumn("TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(datarec["TipoOfertaSisID"]);

            if (datarec.HasColumn("DescripcionMarca")) DescripcionMarca = Convert.ToString(datarec["DescripcionMarca"]);
            if (datarec.HasColumn("DescripcionCategoria")) DescripcionCategoria = Convert.ToString(datarec["DescripcionCategoria"]);
            if (datarec.HasColumn("DescripcionEstrategia")) DescripcionEstrategia = Convert.ToString(datarec["DescripcionEstrategia"]);

            FlagNueva = "0";
            if (datarec.HasColumn("FlagNueva"))
                FlagNueva = Convert.ToString(datarec["FlagNueva"]);

            TipoEstrategiaID = string.Empty;
            if (datarec.HasColumn("TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToString(datarec["TipoEstrategiaID"]);

            if (datarec.HasColumn("IndicadorOfertaCUV")) IndicadorOfertaCUV = Convert.ToBoolean(datarec["IndicadorOfertaCUV"]);
            if (datarec.HasColumn("ImagenProductoSugerido")) ImagenProductoSugerido = Convert.ToString(datarec["ImagenProductoSugerido"]);
            if (datarec.HasColumn("TieneSugerido")) TieneSugerido = Convert.ToInt32(datarec["TieneSugerido"]);             
            if (datarec.HasColumn("CodigoProducto")) CodigoProducto = Convert.ToString(datarec["CodigoProducto"]);
            if (datarec.HasColumn("PrecioValorizado")) PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);
            if (datarec.HasColumn("TieneOfertaRevista")) TieneOfertaRevista = Convert.ToBoolean(datarec["TieneOfertaRevista"]);
            if (datarec.HasColumn("TieneLanzamientoCatalogoPersonalizado")) TieneLanzamientoCatalogoPersonalizado = Convert.ToBoolean(datarec["TieneLanzamientoCatalogoPersonalizado"]);

            TipoOfertaRevista = string.Empty;
            if (datarec.HasColumn("TipoOfertaRevista"))
                TipoOfertaRevista = Convert.ToString(datarec["TipoOfertaRevista"]);

            if (datarec.HasColumn("CodigoCatalago")) CodigoCatalogo = Convert.ToInt32(datarec["CodigoCatalago"]);            
            if (datarec.HasColumn("CatalogoDescripcion")) CatalogoDescripcion = Convert.ToString(datarec["CatalogoDescripcion"]);            
            if (datarec.HasColumn("ImagenURL")) ImagenURL = Convert.ToString(datarec["ImagenURL"]);            
            if (datarec.HasColumn("Nombre")) Nombre = Convert.ToString(datarec["Nombre"]);
            if (datarec.HasColumn("Descripcion")) Descripcion = Convert.ToString(datarec["Descripcion"]);
            if (datarec.HasColumn("Volumen")) Volumen = Convert.ToString(datarec["Volumen"]);
            if (datarec.HasColumn("Tono")) Tono = Convert.ToString(datarec["Tono"]);
            if (datarec.HasColumn("ImagenProducto")) ImagenProducto = Convert.ToString(datarec["ImagenProducto"]);
            if (datarec.HasColumn("DescripcionOferta")) DescripcionOferta = Convert.ToString(datarec["DescripcionOferta"]);
            if (datarec.HasColumn("DescripcionProducto")) DescripcionProducto = Convert.ToString(datarec["DescripcionProducto"]);
            if (datarec.HasColumn("TipoEstrategiaCodigo")) TipoEstrategiaCodigo = Convert.ToString(datarec["TipoEstrategiaCodigo"]);
            if (datarec.HasColumn("EsOfertaIndependiente")) EsOfertaIndependiente = Convert.ToBoolean(datarec["EsOfertaIndependiente"]);            
        }

        //Refactor Inheritance
        public BEProducto()
        {

        }

        /// <summary>
        /// Retorna el origen del producto en base a la funcion delegate definida
        /// </summary>
        /// <param name="func">Function, se aplica sobre esta instancia</param>
        /// <returns>Origin del producto</returns>
        public ProductoOrigenEnum GetOrigen(Func<BEProducto, ProductoOrigenEnum> func)
        {
            return func(this);
        }
    }

    public enum ProductoOrigenEnum
    {
        Catalogo,
        Revista,
        ExpoOfertas,
        Liquidaciones,
        Otros
    }
}
