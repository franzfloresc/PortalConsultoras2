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
        public int EstrategiaID { get; set; }
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
        public string ImagenProductoSugeridoSmall { get; set; }
        [DataMember]
        public string ImagenProductoSugeridoMedium { get; set; }

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

        public BEProducto(IDataRecord row)
        {
            CUV = row.ToString("CUV");
            CodigoSAP = row.ToString("CodigoSAP");
            PrecioCatalogo = row.ToDecimal("PrecioCatalogo");
            MarcaID = row.ToInt32("MarcaID");
            EstaEnRevista = row.ToBoolean("EstaEnRevista");
            TieneStock = row.ToBoolean("TieneStock");
            EsExpoOferta = row.ToBoolean("EsExpoOferta", false);
            CUVRevista = row.ToString("CUVRevista", string.Empty);
            CUVComplemento = row.ToString("CUVComplemento");
            IndicadorMontoMinimo = row.ToInt32("IndicadorMontoMinimo");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID", 0);
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID", 0);
            DescripcionMarca = row.ToString("DescripcionMarca");
            DescripcionCategoria = row.ToString("DescripcionCategoria");
            DescripcionEstrategia = row.ToString("DescripcionEstrategia");
            FlagNueva = row.ToString("FlagNueva", "0");
            TipoEstrategiaID = row.ToString("TipoEstrategiaID", string.Empty);
            IndicadorOfertaCUV = row.ToBoolean("IndicadorOfertaCUV");
            ImagenProductoSugerido = row.ToString("ImagenProductoSugerido");
            TieneSugerido = row.ToInt32("TieneSugerido");
            CodigoProducto = row.ToString("CodigoProducto");
            PrecioValorizado = row.ToDecimal("PrecioValorizado");
            TieneOfertaRevista = row.ToBoolean("TieneOfertaRevista");
            TieneLanzamientoCatalogoPersonalizado = row.ToBoolean("TieneLanzamientoCatalogoPersonalizado");
            TipoOfertaRevista = row.ToString("TipoOfertaRevista", string.Empty);
            CodigoCatalogo = row.ToInt32("CodigoCatalago");
            CatalogoDescripcion = row.ToString("CatalogoDescripcion");
            ImagenURL = row.ToString("ImagenURL");
            Nombre = row.ToString("Nombre");
            Descripcion = row.ToString("Descripcion");
            Volumen = row.ToString("Volumen");
            Tono = row.ToString("Tono");
            ImagenProducto = row.ToString("ImagenProducto");
            DescripcionOferta = row.ToString("DescripcionOferta");
            DescripcionProducto = row.ToString("DescripcionProducto");
            TipoEstrategiaCodigo = row.ToString("TipoEstrategiaCodigo");
            EsOfertaIndependiente = row.ToBoolean("EsOfertaIndependiente");
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
