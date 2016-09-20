using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProducto
    {
        private string msCUV;
        //private string msCodigoSAP;
        private string msDescripcion;
        private decimal mdPrecioCatalogo;
        //private decimal mdPrecioValorizado;
        private int miMarcaID;
        //private bool mbEsPremio;
        private bool mbEstaEnRevista;
        //private bool mbEsFaltanteAnunciado;
        private bool mbTieneStock;
        private bool mbEsExpoOferta;
        private string msCUVRevista;
        private string msCUVComplemento;
        private int msIndicadorMontoMinimo;

        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        //private string msIndicador;
        //private byte miPaisID;

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
        //[DataMember]
        //public string CodigoSAP
        //{
        //    get { return msCodigoSAP; }
        //    set { msCodigoSAP = value; }
        //}
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
        //[DataMember]
        //public decimal PrecioValorizado
        //{
        //    get { return mdPrecioValorizado; }
        //    set { mdPrecioValorizado = value; }
        //}
        [DataMember]
        public int MarcaID
        {
            get { return miMarcaID; }
            set { miMarcaID = value; }
        }
        //[DataMember]
        //public bool EsPremio
        //{
        //    get { return mbEsPremio; }
        //    set { mbEsPremio = value; }
        //}
        [DataMember]
        public bool EstaEnRevista
        {
            get { return mbEstaEnRevista; }
            set { mbEstaEnRevista = value; }
        }
        //[DataMember]
        //public bool EsFaltanteAnunciado
        //{
        //    get { return mbEsFaltanteAnunciado; }
        //    set { mbEsFaltanteAnunciado = value; }
        //}
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
        public string CUVComplemento
        {
            get { return msCUVComplemento; }
            set { msCUVComplemento = value; }
        }
        /*R2469 - JICM - INI*/
        [DataMember]
        public string DescripcionMarca { get; set; }
        [DataMember]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }
        /*R2469 - JICM - FIN*/
        /* CGI (AHAA) - BUG 2015000858 - Inicio */
        [DataMember]
        public string FlagNueva { get; set; }
        [DataMember]
        public string TipoEstrategiaID { get; set; }
        /* CGI (AHAA) - BUG 2015000858 - Fin */
        [DataMember]
        public bool IndicadorOfertaCUV  { get; set; } /*R20150701*/
        //[DataMember]
        //public string Indicador
        //{
        //    get { return msIndicador; }
        //    set { msIndicador = value; }
        //}
        //[DataMember]
        //public byte PaisID
        //{
        //    get { return miPaisID; }
        //    set { miPaisID = value; }
        //}

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

        public BEProducto(IDataRecord datarec)
        {
            //miCampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            msCUV = (datarec["CUV"] ?? "").ToString();
            //msCodigoSAP = datarec["CodigoSAP"].ToString();
            msDescripcion = (datarec["Descripcion"] ?? "").ToString();
            if (DataRecord.HasColumn(datarec, "PrecioCatalogo") && datarec["PrecioCatalogo"] != DBNull.Value)
                mdPrecioCatalogo = DbConvert.ToDecimal(datarec["PrecioCatalogo"]);
            //mdPrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);
            if (DataRecord.HasColumn(datarec, "MarcaID") && datarec["MarcaID"] != DBNull.Value)
                miMarcaID = DbConvert.ToInt32(datarec["MarcaID"]);
            //mbEsPremio = Convert.ToBoolean(datarec["EsPremio"]);
            if (DataRecord.HasColumn(datarec, "EstaEnRevista") && datarec["EstaEnRevista"] != DBNull.Value)
                mbEstaEnRevista = DbConvert.ToBoolean(datarec["EstaEnRevista"]);
            //mbEsFaltanteAnunciado = Convert.ToBoolean(datarec["EsFaltanteAnunciado"]);
            if (DataRecord.HasColumn(datarec, "TieneStock") && datarec["TieneStock"] != DBNull.Value)
                mbTieneStock = DbConvert.ToBoolean(datarec["TieneStock"]);
            if (DataRecord.HasColumn(datarec, "EsExpoOferta") && datarec["EsExpoOferta"] != DBNull.Value)
                mbEsExpoOferta = DbConvert.ToBoolean(datarec["EsExpoOferta"]);
            if (DataRecord.HasColumn(datarec, "CUVRevista") && datarec["CUVRevista"] != DBNull.Value)
                msCUVRevista = datarec["CUVRevista"].ToString();
            if (DataRecord.HasColumn(datarec, "CUVComplemento") && datarec["CUVComplemento"] != DBNull.Value)
                msCUVComplemento = datarec["CUVComplemento"].ToString();
            //msIndicadorMontoMinimo = datarec["IndicadorMontoMinimo"] != DBNull.Value ? DbConvert.ToInt32(datarec["IndicadorMontoMinimo"]) : 1;
            if (DataRecord.HasColumn(datarec, "IndicadorMontoMinimo") && datarec["IndicadorMontoMinimo"] != DBNull.Value)
                msIndicadorMontoMinimo = Convert.ToInt32(datarec["IndicadorMontoMinimo"]);
            else
                msIndicadorMontoMinimo = 1;
            //msIndicador = datarec["Indicador"].ToString();
            //miPaisID = (byte)datarec["PaisID"];
            if (DataRecord.HasColumn(datarec, "ConfiguracionOfertaID") && datarec["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(datarec["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(datarec, "TipoOfertaSisID") && datarec["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(datarec["TipoOfertaSisID"]);
            /*R2469 - JICM - INI*/
            if (DataRecord.HasColumn(datarec, "DescripcionMarca") && datarec["DescripcionMarca"] != DBNull.Value)
                DescripcionMarca = datarec["DescripcionMarca"].ToString();

            if (DataRecord.HasColumn(datarec, "DescripcionCategoria") && datarec["DescripcionCategoria"] != DBNull.Value)
                DescripcionCategoria = datarec["DescripcionCategoria"].ToString();

            if (DataRecord.HasColumn(datarec, "DescripcionEstrategia") && datarec["DescripcionEstrategia"] != DBNull.Value)
                DescripcionEstrategia = datarec["DescripcionEstrategia"].ToString();
            /*R2469 - JICM - FIN*/
            /* CGI (AHAA) - BUG 2015000858 - Inicio */
            if (DataRecord.HasColumn(datarec, "FlagNueva") && datarec["FlagNueva"] != DBNull.Value)
                FlagNueva = datarec["FlagNueva"].ToString();
            if (DataRecord.HasColumn(datarec, "TipoEstrategiaID") && datarec["TipoEstrategiaID"] != DBNull.Value)
                TipoEstrategiaID = datarec["TipoEstrategiaID"].ToString();
            /* CGI (AHAA) - BUG 2015000858 - Fin */

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
        }

        public BEProducto()
        {

        }
    }
}
