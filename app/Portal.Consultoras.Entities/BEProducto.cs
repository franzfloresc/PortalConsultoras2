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

        private string msDescripcion;
        private decimal mdPrecioCatalogo;

        private int miMarcaID;

        private bool mbEstaEnRevista;

        private bool mbTieneStock;
        private bool mbEsExpoOferta;
        private string msCUVRevista;
        private string msCUVComplemento;
        private int msIndicadorMontoMinimo;

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
        public int IndicadorMontoMinimo
        {
            get { return msIndicadorMontoMinimo; }
            set { msIndicadorMontoMinimo = value; }
        }

        [DataMember]
        public string Descripcion
        {
            get { return msDescripcion; }
            set { msDescripcion = value; }
        }
        [DataMember]
        public decimal PrecioCatalogo
        {
            get { return mdPrecioCatalogo; }
            set { mdPrecioCatalogo = value; }
        }

        [DataMember]
        public int MarcaID
        {
            get { return miMarcaID; }
            set { miMarcaID = value; }
        }

        [DataMember]
        public bool EstaEnRevista
        {
            get { return mbEstaEnRevista; }
            set { mbEstaEnRevista = value; }
        }

        [DataMember]
        public bool TieneStock
        {
            get { return mbTieneStock; }
            set { mbTieneStock = value; }
        }
        [DataMember]
        public bool EsExpoOferta
        {
            get { return mbEsExpoOferta; }
            set { mbEsExpoOferta = value; }
        }
        [DataMember]
        public string CUVRevista
        {
            get { return msCUVRevista; }
            set { msCUVRevista = value; }
        }
        [DataMember]
        public string MensajeEstaEnRevista1 { get; set; }
        [DataMember]
        public string MensajeEstaEnRevista2 { get; set; }
        [DataMember]
        public string CUVComplemento
        {
            get { return msCUVComplemento; }
            set { msCUVComplemento = value; }
        }

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
            if (DataRecord.HasColumn(datarec, "CodigoSAP") && datarec["CodigoSAP"] != DBNull.Value)
                CodigoSAP = DbConvert.ToString(datarec["CodigoSAP"]);
            if (DataRecord.HasColumn(datarec, "PrecioCatalogo") && datarec["PrecioCatalogo"] != DBNull.Value)
                mdPrecioCatalogo = DbConvert.ToDecimal(datarec["PrecioCatalogo"]);

            if (DataRecord.HasColumn(datarec, "MarcaID") && datarec["MarcaID"] != DBNull.Value)
                miMarcaID = DbConvert.ToInt32(datarec["MarcaID"]);

            if (DataRecord.HasColumn(datarec, "EstaEnRevista") && datarec["EstaEnRevista"] != DBNull.Value)
                mbEstaEnRevista = DbConvert.ToBoolean(datarec["EstaEnRevista"]);

            if (DataRecord.HasColumn(datarec, "TieneStock") && datarec["TieneStock"] != DBNull.Value)
                mbTieneStock = DbConvert.ToBoolean(datarec["TieneStock"]);
            if (DataRecord.HasColumn(datarec, "EsExpoOferta") && datarec["EsExpoOferta"] != DBNull.Value)
                mbEsExpoOferta = DbConvert.ToBoolean(datarec["EsExpoOferta"]);
            if (DataRecord.HasColumn(datarec, "CUVRevista") && datarec["CUVRevista"] != DBNull.Value)
                msCUVRevista = datarec["CUVRevista"].ToString();
            if (DataRecord.HasColumn(datarec, "CUVComplemento") && datarec["CUVComplemento"] != DBNull.Value)
                msCUVComplemento = datarec["CUVComplemento"].ToString();

            if (DataRecord.HasColumn(datarec, "IndicadorMontoMinimo") && datarec["IndicadorMontoMinimo"] != DBNull.Value)
                msIndicadorMontoMinimo = Convert.ToInt32(datarec["IndicadorMontoMinimo"]);
            else
                msIndicadorMontoMinimo = 1;

            if (DataRecord.HasColumn(datarec, "ConfiguracionOfertaID") && datarec["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(datarec["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(datarec, "TipoOfertaSisID") && datarec["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(datarec["TipoOfertaSisID"]);

            if (DataRecord.HasColumn(datarec, "DescripcionMarca") && datarec["DescripcionMarca"] != DBNull.Value)
                DescripcionMarca = datarec["DescripcionMarca"].ToString();

            if (DataRecord.HasColumn(datarec, "DescripcionCategoria") && datarec["DescripcionCategoria"] != DBNull.Value)
                DescripcionCategoria = datarec["DescripcionCategoria"].ToString();

            if (DataRecord.HasColumn(datarec, "DescripcionEstrategia") && datarec["DescripcionEstrategia"] != DBNull.Value)
                DescripcionEstrategia = datarec["DescripcionEstrategia"].ToString();

            if (DataRecord.HasColumn(datarec, "FlagNueva") && datarec["FlagNueva"] != DBNull.Value)
                FlagNueva = datarec["FlagNueva"].ToString();
            if (DataRecord.HasColumn(datarec, "TipoEstrategiaID") && datarec["TipoEstrategiaID"] != DBNull.Value)
                TipoEstrategiaID = datarec["TipoEstrategiaID"].ToString();

            if (DataRecord.HasColumn(datarec, "IndicadorOfertaCUV") && datarec["IndicadorOfertaCUV"] != DBNull.Value)
                IndicadorOfertaCUV = Convert.ToBoolean(datarec["IndicadorOfertaCUV"]);

            if (DataRecord.HasColumn(datarec, "ImagenProductoSugerido") && datarec["ImagenProductoSugerido"] != DBNull.Value)
                ImagenProductoSugerido = Convert.ToString(datarec["ImagenProductoSugerido"]);

            if (DataRecord.HasColumn(datarec, "TieneSugerido") && datarec["TieneSugerido"] != DBNull.Value)
                TieneSugerido = Convert.ToInt32(datarec["TieneSugerido"]);

            if (DataRecord.HasColumn(datarec, "CodigoProducto") && datarec["CodigoProducto"] != DBNull.Value)
                CodigoProducto = Convert.ToString(datarec["CodigoProducto"]);

            if (DataRecord.HasColumn(datarec, "PrecioValorizado") && datarec["PrecioValorizado"] != DBNull.Value)
                PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);

            if (DataRecord.HasColumn(datarec, "TieneOfertaRevista") && datarec["TieneOfertaRevista"] != DBNull.Value)
                TieneOfertaRevista = Convert.ToBoolean(datarec["TieneOfertaRevista"]);

            if (DataRecord.HasColumn(datarec, "TieneLanzamientoCatalogoPersonalizado") && datarec["TieneLanzamientoCatalogoPersonalizado"] != DBNull.Value)
                TieneLanzamientoCatalogoPersonalizado = Convert.ToBoolean(datarec["TieneLanzamientoCatalogoPersonalizado"]);

            if (DataRecord.HasColumn(datarec, "TipoOfertaRevista") && datarec["TipoOfertaRevista"] != DBNull.Value)
                TipoOfertaRevista = Convert.ToString(datarec["TipoOfertaRevista"]).Trim();

            if (DataRecord.HasColumn(datarec, "CodigoCatalago") && datarec["CodigoCatalago"] != DBNull.Value)
                CodigoCatalogo = Convert.ToInt32(datarec["CodigoCatalago"]);

            if (DataRecord.HasColumn(datarec, "CatalogoDescripcion") && datarec["CatalogoDescripcion"] != DBNull.Value)
                CatalogoDescripcion = datarec["CatalogoDescripcion"].ToString();

            if (DataRecord.HasColumn(datarec, "ImagenURL") && datarec["ImagenURL"] != DBNull.Value)
                ImagenURL = Convert.ToString(datarec["ImagenURL"]);

            if (DataRecord.HasColumn(datarec, "Nombre") && datarec["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "Descripcion") && datarec["Descripcion"] != DBNull.Value)
                msDescripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "Volumen") && datarec["Volumen"] != DBNull.Value)
                Volumen = Convert.ToString(datarec["Volumen"]);
            if (DataRecord.HasColumn(datarec, "Tono") && datarec["Tono"] != DBNull.Value)
                Tono = Convert.ToString(datarec["Tono"]);
            if (DataRecord.HasColumn(datarec, "ImagenProducto") && datarec["ImagenProducto"] != DBNull.Value)
                ImagenProducto = Convert.ToString(datarec["ImagenProducto"]);
            if (DataRecord.HasColumn(datarec, "DescripcionOferta") && datarec["DescripcionOferta"] != DBNull.Value)
                DescripcionOferta = Convert.ToString(datarec["DescripcionOferta"]);
            if (DataRecord.HasColumn(datarec, "DescripcionProducto") && datarec["DescripcionProducto"] != DBNull.Value)
                DescripcionProducto = Convert.ToString(datarec["DescripcionProducto"]);

            TipoEstrategiaCodigo = DataRecord.GetColumn<string>(datarec, "TipoEstrategiaCodigo");
            if (DataRecord.HasColumn(datarec, "EsOfertaIndependiente") && datarec["EsOfertaIndependiente"] != DBNull.Value)
                EsOfertaIndependiente = (datarec["EsOfertaIndependiente"].ToBool());
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

    [DataContract]
    public class BEProductoProgramaNuevas
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int CampanaID { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string CodigoCupon {get; set;}         
        [DataMember]
        public string CodigoVenta { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }
        [DataMember]
        public int UnidadesMaximas { get; set; }
        [DataMember]
        public bool IndicadorKit { get; set; }
        [DataMember]
        public bool IndicadorCuponIndependiente { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public int NumeroCampanasVigentes { get; set; }

        //public BEProductoProgramaNuevas()
        //{ }

        public BEProductoProgramaNuevas(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CodigoPrograma") && datarec["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = DbConvert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "CampanaID") && datarec["CampanaID"] != DBNull.Value)
                CampanaID = DbConvert.ToInt32(datarec["CampanaID"]);
            if (DataRecord.HasColumn(datarec, "CodigoNivel") && datarec["CodigoNivel"] != DBNull.Value)
                CodigoNivel = DbConvert.ToString(datarec["CodigoNivel"]);
            if (DataRecord.HasColumn(datarec, "CodigoCupon") && datarec["CodigoCupon"] != DBNull.Value)
                CodigoCupon = DbConvert.ToString(datarec["CodigoCupon"]);
            if (DataRecord.HasColumn(datarec, "CodigoVenta") && datarec["CodigoVenta"] != DBNull.Value)
                CodigoVenta = DbConvert.ToString(datarec["CodigoVenta"]);
            if (DataRecord.HasColumn(datarec, "DescripcionProducto") && datarec["DescripcionProducto"] != DBNull.Value)
                DescripcionProducto = DbConvert.ToString(datarec["DescripcionProducto"]);
            if (DataRecord.HasColumn(datarec, "UnidadesMaximas") && datarec["UnidadesMaximas"] != DBNull.Value)
                UnidadesMaximas = DbConvert.ToInt32(datarec["UnidadesMaximas"]);
            if (DataRecord.HasColumn(datarec, "IndicadorKit") && datarec["IndicadorKit"] != DBNull.Value)
                IndicadorKit = DbConvert.ToBoolean(datarec["IndicadorKit"]);
            if (DataRecord.HasColumn(datarec, "IndicadorCuponIndependiente") && datarec["IndicadorCuponIndependiente"] != DBNull.Value)
                IndicadorCuponIndependiente = DbConvert.ToBoolean(datarec["IndicadorCuponIndependiente"]);
            if (DataRecord.HasColumn(datarec, "PrecioUnitario") && datarec["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = DbConvert.ToDecimal(datarec["PrecioUnitario"]);
            if (DataRecord.HasColumn(datarec, "NumeroCampanasVigentes") && datarec["NumeroCampanasVigentes"] != DBNull.Value)
                NumeroCampanasVigentes = DbConvert.ToInt32(datarec["NumeroCampanasVigentes"]);
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
