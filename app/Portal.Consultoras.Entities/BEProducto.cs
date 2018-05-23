﻿using OpenSource.Library.DataAccess;
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
            if (DataRecord.HasColumn(datarec, "CodigoSAP"))
                CodigoSAP = DbConvert.ToString(datarec["CodigoSAP"]);
            if (DataRecord.HasColumn(datarec, "PrecioCatalogo"))
                mdPrecioCatalogo = DbConvert.ToDecimal(datarec["PrecioCatalogo"]);

            if (DataRecord.HasColumn(datarec, "MarcaID"))
                miMarcaID = DbConvert.ToInt32(datarec["MarcaID"]);

            if (DataRecord.HasColumn(datarec, "EstaEnRevista"))
                mbEstaEnRevista = DbConvert.ToBoolean(datarec["EstaEnRevista"]);

            if (DataRecord.HasColumn(datarec, "TieneStock"))
                mbTieneStock = DbConvert.ToBoolean(datarec["TieneStock"]);
            if (DataRecord.HasColumn(datarec, "EsExpoOferta"))
                mbEsExpoOferta = DbConvert.ToBoolean(datarec["EsExpoOferta"]);
            if (DataRecord.HasColumn(datarec, "CUVRevista"))
                msCUVRevista = datarec["CUVRevista"].ToString();
            if (DataRecord.HasColumn(datarec, "CUVComplemento"))
                msCUVComplemento = datarec["CUVComplemento"].ToString();

            if (DataRecord.HasColumn(datarec, "IndicadorMontoMinimo"))
                msIndicadorMontoMinimo = Convert.ToInt32(datarec["IndicadorMontoMinimo"]);
            else
                msIndicadorMontoMinimo = 1;

            if (DataRecord.HasColumn(datarec, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(datarec["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(datarec, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(datarec["TipoOfertaSisID"]);

            if (DataRecord.HasColumn(datarec, "DescripcionMarca"))
                DescripcionMarca = datarec["DescripcionMarca"].ToString();

            if (DataRecord.HasColumn(datarec, "DescripcionCategoria"))
                DescripcionCategoria = datarec["DescripcionCategoria"].ToString();

            if (DataRecord.HasColumn(datarec, "DescripcionEstrategia"))
                DescripcionEstrategia = datarec["DescripcionEstrategia"].ToString();

            if (DataRecord.HasColumn(datarec, "FlagNueva"))
                FlagNueva = datarec["FlagNueva"].ToString();
            if (DataRecord.HasColumn(datarec, "TipoEstrategiaID"))
                TipoEstrategiaID = datarec["TipoEstrategiaID"].ToString();

            if (DataRecord.HasColumn(datarec, "IndicadorOfertaCUV"))
                IndicadorOfertaCUV = Convert.ToBoolean(datarec["IndicadorOfertaCUV"]);

            if (DataRecord.HasColumn(datarec, "ImagenProductoSugerido"))
                ImagenProductoSugerido = Convert.ToString(datarec["ImagenProductoSugerido"]);

            if (DataRecord.HasColumn(datarec, "TieneSugerido"))
                TieneSugerido = Convert.ToInt32(datarec["TieneSugerido"]);

            if (DataRecord.HasColumn(datarec, "CodigoProducto"))
                CodigoProducto = Convert.ToString(datarec["CodigoProducto"]);

            if (DataRecord.HasColumn(datarec, "PrecioValorizado"))
                PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);

            if (DataRecord.HasColumn(datarec, "TieneOfertaRevista"))
                TieneOfertaRevista = Convert.ToBoolean(datarec["TieneOfertaRevista"]);

            if (DataRecord.HasColumn(datarec, "TieneLanzamientoCatalogoPersonalizado"))
                TieneLanzamientoCatalogoPersonalizado = Convert.ToBoolean(datarec["TieneLanzamientoCatalogoPersonalizado"]);

            if (DataRecord.HasColumn(datarec, "TipoOfertaRevista"))
                TipoOfertaRevista = Convert.ToString(datarec["TipoOfertaRevista"]).Trim();

            if (DataRecord.HasColumn(datarec, "CodigoCatalago"))
                CodigoCatalogo = Convert.ToInt32(datarec["CodigoCatalago"]);

            if (DataRecord.HasColumn(datarec, "CatalogoDescripcion"))
                CatalogoDescripcion = datarec["CatalogoDescripcion"].ToString();

            if (DataRecord.HasColumn(datarec, "ImagenURL"))
                ImagenURL = Convert.ToString(datarec["ImagenURL"]);

            if (DataRecord.HasColumn(datarec, "Nombre"))
                Nombre = Convert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "Descripcion"))
                msDescripcion = Convert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "Volumen"))
                Volumen = Convert.ToString(datarec["Volumen"]);
            if (DataRecord.HasColumn(datarec, "Tono"))
                Tono = Convert.ToString(datarec["Tono"]);
            if (DataRecord.HasColumn(datarec, "ImagenProducto"))
                ImagenProducto = Convert.ToString(datarec["ImagenProducto"]);
            if (DataRecord.HasColumn(datarec, "DescripcionOferta"))
                DescripcionOferta = Convert.ToString(datarec["DescripcionOferta"]);
            if (DataRecord.HasColumn(datarec, "DescripcionProducto"))
                DescripcionProducto = Convert.ToString(datarec["DescripcionProducto"]);

            TipoEstrategiaCodigo = DataRecord.GetColumn<string>(datarec, "TipoEstrategiaCodigo");
            if (DataRecord.HasColumn(datarec, "EsOfertaIndependiente"))
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

    public enum ProductoOrigenEnum
    {
        Catalogo,
        Revista,
        ExpoOfertas,
        Liquidaciones,
        Otros
    }
}
