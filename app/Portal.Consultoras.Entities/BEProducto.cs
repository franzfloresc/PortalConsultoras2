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
        private string msCUV;

        private int miMarcaID;

        [DataMember]
        public string CodigoSAP { get; set; }

        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }

        [DataMember]
        public string CUV
        {
            get { return msCUV; }
            set { msCUV = value; }
        }
        [DataMember]
        public int IndicadorMontoMinimo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        public int MarcaID
        {
            get { return miMarcaID; }
            set { miMarcaID = value; }
        }

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
            msCUV = (datarec["CUV"] ?? "").ToString();

            if (datarec.HasColumn("CodigoSAP")) CodigoSAP = Convert.ToString(datarec["CodigoSAP"]);
            if (datarec.HasColumn("PrecioCatalogo")) PrecioCatalogo = Convert.ToDecimal(datarec["PrecioCatalogo"]);
            if (datarec.HasColumn("MarcaID")) MarcaID = Convert.ToInt32(datarec["MarcaID"]);
            if (datarec.HasColumn("EstaEnRevista")) EstaEnRevista = Convert.ToBoolean(datarec["EstaEnRevista"]);

            if (datarec.HasColumn("TieneStock")) TieneStock = Convert.ToBoolean(datarec["TieneStock"]);            
            if (datarec.HasColumn("CUVProductoFaltante"))
            {
                var cuvProductoFaltante = Convert.ToString(datarec["CUVProductoFaltante"]);
                TieneStock = string.IsNullOrEmpty(cuvProductoFaltante);
            }else
            {
                TieneStock = true;
            }

            if (datarec.HasColumn("EsExpoOferta"))
                EsExpoOferta = Convert.ToBoolean(datarec["EsExpoOferta"]);
            else
                EsExpoOferta = false;

            if (datarec.HasColumn("CUVRevista"))
                CUVRevista = Convert.ToString(datarec["CUVRevista"]);
            else
                CUVRevista = string.Empty;

            if (datarec.HasColumn("CUVComplemento")) CUVComplemento = Convert.ToString(datarec["CUVComplemento"]);

            if (datarec.HasColumn("IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(datarec["IndicadorMontoMinimo"]);
            else
                IndicadorMontoMinimo = 1;

            if (datarec.HasColumn("ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(datarec["ConfiguracionOfertaID"]);
            else
                ConfiguracionOfertaID = 0;

            if (datarec.HasColumn("TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(datarec["TipoOfertaSisID"]);
            else
                TipoOfertaSisID = 0;

            if (datarec.HasColumn("DescripcionMarca")) DescripcionMarca = Convert.ToString(datarec["DescripcionMarca"]);
            if (datarec.HasColumn("DescripcionCategoria")) DescripcionCategoria = Convert.ToString(datarec["DescripcionCategoria"]);
            if (datarec.HasColumn("DescripcionEstrategia")) DescripcionEstrategia = Convert.ToString(datarec["DescripcionEstrategia"]);

            if (datarec.HasColumn("FlagNueva"))
                FlagNueva = Convert.ToString(datarec["FlagNueva"]);
            else
                FlagNueva = "0";

            if (datarec.HasColumn("TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToString(datarec["TipoEstrategiaID"]);
            else
                TipoEstrategiaID = "0";

            if (datarec.HasColumn("IndicadorOfertaCUV")) IndicadorOfertaCUV = Convert.ToBoolean(datarec["IndicadorOfertaCUV"]);
            if (datarec.HasColumn("ImagenProductoSugerido")) ImagenProductoSugerido = Convert.ToString(datarec["ImagenProductoSugerido"]);

            if (datarec.HasColumn("TieneSugerido")) TieneSugerido = Convert.ToInt32(datarec["TieneSugerido"]);
            if (datarec.HasColumn("CuvSugerido"))
            {
                var cuvSugerido = Convert.ToString(datarec["CuvSugerido"]);
                TieneSugerido = !string.IsNullOrEmpty(cuvSugerido) ? 1 : 0;
            }
            else
            {
                TieneSugerido = 0;
            }                

            if (datarec.HasColumn("CodigoProducto")) CodigoProducto = Convert.ToString(datarec["CodigoProducto"]);
            if (datarec.HasColumn("PrecioValorizado")) PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);
            if (datarec.HasColumn("TieneOfertaRevista")) TieneOfertaRevista = Convert.ToBoolean(datarec["TieneOfertaRevista"]);

            if (datarec.HasColumn("TieneLanzamientoCatalogoPersonalizado")) TieneLanzamientoCatalogoPersonalizado = Convert.ToBoolean(datarec["TieneLanzamientoCatalogoPersonalizado"]);
            if (datarec.HasColumn("CodigoSAPProductosLanzamiento"))
            {
                var cuvLanzamiento = Convert.ToString(datarec["CodigoSAPProductosLanzamiento"]);
                TieneLanzamientoCatalogoPersonalizado = string.IsNullOrEmpty(cuvLanzamiento);
            }
            else
            {
                TieneLanzamientoCatalogoPersonalizado = false;
            }

            if (datarec.HasColumn("TipoOfertaRevista"))
                TipoOfertaRevista = Convert.ToString(datarec["TipoOfertaRevista"]);
            else
                TipoOfertaRevista = string.Empty;

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
            if (datarec.HasColumn("MostrarImgOfertaIndependiente") && datarec.HasColumn("EstrategiaEsOfertaIndependiente"))
            {
                var mostrarImgOfertaIndependiente = Convert.ToBoolean(datarec["MostrarImgOfertaIndependiente"]);
                var estrategiaEsOfertaIndependiente = Convert.ToBoolean(datarec["EstrategiaEsOfertaIndependiente"]);

                EsOfertaIndependiente = mostrarImgOfertaIndependiente && estrategiaEsOfertaIndependiente;
            }
            else
                EsOfertaIndependiente = false;

            //if (DataRecord.HasColumn(datarec, "CodigoSAP") && datarec["CodigoSAP"] != DBNull.Value)
            //    CodigoSAP = DbConvert.ToString(datarec["CodigoSAP"]);
            //if (DataRecord.HasColumn(datarec, "PrecioCatalogo") && datarec["PrecioCatalogo"] != DBNull.Value)
            //    mdPrecioCatalogo = DbConvert.ToDecimal(datarec["PrecioCatalogo"]);

            //if (DataRecord.HasColumn(datarec, "MarcaID") && datarec["MarcaID"] != DBNull.Value)
            //    miMarcaID = DbConvert.ToInt32(datarec["MarcaID"]);

            //if (DataRecord.HasColumn(datarec, "EstaEnRevista") && datarec["EstaEnRevista"] != DBNull.Value)
            //    EstaEnRevista = DbConvert.ToBoolean(datarec["EstaEnRevista"]);

            //if (DataRecord.HasColumn(datarec, "TieneStock") && datarec["TieneStock"] != DBNull.Value)
            //    TieneStock = DbConvert.ToBoolean(datarec["TieneStock"]);
            //if (DataRecord.HasColumn(datarec, "EsExpoOferta") && datarec["EsExpoOferta"] != DBNull.Value)
            //    EsExpoOferta = DbConvert.ToBoolean(datarec["EsExpoOferta"]);
            //if (DataRecord.HasColumn(datarec, "CUVRevista") && datarec["CUVRevista"] != DBNull.Value)
            //    CUVRevista = datarec["CUVRevista"].ToString();
            //if (DataRecord.HasColumn(datarec, "CUVComplemento") && datarec["CUVComplemento"] != DBNull.Value)
            //    CUVComplemento = datarec["CUVComplemento"].ToString();

            //if (DataRecord.HasColumn(datarec, "IndicadorMontoMinimo") && datarec["IndicadorMontoMinimo"] != DBNull.Value)
            //    IndicadorMontoMinimo = Convert.ToInt32(datarec["IndicadorMontoMinimo"]);
            //else
            //    IndicadorMontoMinimo = 1;

            //if (DataRecord.HasColumn(datarec, "ConfiguracionOfertaID") && datarec["ConfiguracionOfertaID"] != DBNull.Value)
            //    ConfiguracionOfertaID = Convert.ToInt32(datarec["ConfiguracionOfertaID"]);
            //if (DataRecord.HasColumn(datarec, "TipoOfertaSisID") && datarec["TipoOfertaSisID"] != DBNull.Value)
            //    TipoOfertaSisID = Convert.ToInt32(datarec["TipoOfertaSisID"]);

            //if (DataRecord.HasColumn(datarec, "DescripcionMarca") && datarec["DescripcionMarca"] != DBNull.Value)
            //    DescripcionMarca = datarec["DescripcionMarca"].ToString();

            //if (DataRecord.HasColumn(datarec, "DescripcionCategoria") && datarec["DescripcionCategoria"] != DBNull.Value)
            //    DescripcionCategoria = datarec["DescripcionCategoria"].ToString();

            //if (DataRecord.HasColumn(datarec, "DescripcionEstrategia") && datarec["DescripcionEstrategia"] != DBNull.Value)
            //    DescripcionEstrategia = datarec["DescripcionEstrategia"].ToString();

            //if (DataRecord.HasColumn(datarec, "FlagNueva") && datarec["FlagNueva"] != DBNull.Value)
            //    FlagNueva = datarec["FlagNueva"].ToString();
            //if (DataRecord.HasColumn(datarec, "TipoEstrategiaID") && datarec["TipoEstrategiaID"] != DBNull.Value)
            //    TipoEstrategiaID = datarec["TipoEstrategiaID"].ToString();

            //if (DataRecord.HasColumn(datarec, "IndicadorOfertaCUV") && datarec["IndicadorOfertaCUV"] != DBNull.Value)
            //    IndicadorOfertaCUV = Convert.ToBoolean(datarec["IndicadorOfertaCUV"]);

            //if (DataRecord.HasColumn(datarec, "ImagenProductoSugerido") && datarec["ImagenProductoSugerido"] != DBNull.Value)
            //    ImagenProductoSugerido = Convert.ToString(datarec["ImagenProductoSugerido"]);

            //if (DataRecord.HasColumn(datarec, "TieneSugerido") && datarec["TieneSugerido"] != DBNull.Value)
            //    TieneSugerido = Convert.ToInt32(datarec["TieneSugerido"]);

            //if (DataRecord.HasColumn(datarec, "CodigoProducto") && datarec["CodigoProducto"] != DBNull.Value)
            //    CodigoProducto = Convert.ToString(datarec["CodigoProducto"]);

            //if (DataRecord.HasColumn(datarec, "PrecioValorizado") && datarec["PrecioValorizado"] != DBNull.Value)
            //    PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);

            //if (DataRecord.HasColumn(datarec, "TieneOfertaRevista") && datarec["TieneOfertaRevista"] != DBNull.Value)
            //    TieneOfertaRevista = Convert.ToBoolean(datarec["TieneOfertaRevista"]);

            //if (DataRecord.HasColumn(datarec, "TieneLanzamientoCatalogoPersonalizado") && datarec["TieneLanzamientoCatalogoPersonalizado"] != DBNull.Value)
            //    TieneLanzamientoCatalogoPersonalizado = Convert.ToBoolean(datarec["TieneLanzamientoCatalogoPersonalizado"]);

            //if (DataRecord.HasColumn(datarec, "TipoOfertaRevista") && datarec["TipoOfertaRevista"] != DBNull.Value)
            //    TipoOfertaRevista = Convert.ToString(datarec["TipoOfertaRevista"]).Trim();

            //if (DataRecord.HasColumn(datarec, "CodigoCatalago") && datarec["CodigoCatalago"] != DBNull.Value)
            //    CodigoCatalogo = Convert.ToInt32(datarec["CodigoCatalago"]);

            //if (DataRecord.HasColumn(datarec, "CatalogoDescripcion") && datarec["CatalogoDescripcion"] != DBNull.Value)
            //    CatalogoDescripcion = datarec["CatalogoDescripcion"].ToString();

            //if (DataRecord.HasColumn(datarec, "ImagenURL") && datarec["ImagenURL"] != DBNull.Value)
            //    ImagenURL = Convert.ToString(datarec["ImagenURL"]);

            //if (DataRecord.HasColumn(datarec, "Nombre") && datarec["Nombre"] != DBNull.Value)
            //    Nombre = Convert.ToString(datarec["Nombre"]);
            //if (DataRecord.HasColumn(datarec, "Descripcion") && datarec["Descripcion"] != DBNull.Value)
            //    Descripcion = Convert.ToString(datarec["Descripcion"]);
            //if (DataRecord.HasColumn(datarec, "Volumen") && datarec["Volumen"] != DBNull.Value)
            //    Volumen = Convert.ToString(datarec["Volumen"]);
            //if (DataRecord.HasColumn(datarec, "Tono") && datarec["Tono"] != DBNull.Value)
            //    Tono = Convert.ToString(datarec["Tono"]);
            //if (DataRecord.HasColumn(datarec, "ImagenProducto") && datarec["ImagenProducto"] != DBNull.Value)
            //    ImagenProducto = Convert.ToString(datarec["ImagenProducto"]);
            //if (DataRecord.HasColumn(datarec, "DescripcionOferta") && datarec["DescripcionOferta"] != DBNull.Value)
            //    DescripcionOferta = Convert.ToString(datarec["DescripcionOferta"]);
            //if (DataRecord.HasColumn(datarec, "DescripcionProducto") && datarec["DescripcionProducto"] != DBNull.Value)
            //    DescripcionProducto = Convert.ToString(datarec["DescripcionProducto"]);

            //TipoEstrategiaCodigo = DataRecord.GetColumn<string>(datarec, "TipoEstrategiaCodigo");
            //if (DataRecord.HasColumn(datarec, "EsOfertaIndependiente") && datarec["EsOfertaIndependiente"] != DBNull.Value)
            //    EsOfertaIndependiente = (datarec["EsOfertaIndependiente"].ToBool());
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
