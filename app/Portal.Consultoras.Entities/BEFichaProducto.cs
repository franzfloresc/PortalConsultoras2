using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFichaProducto
    {
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string ConsultoraID { get; set; }
        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int CampaniaIDFin { get; set; }
        [DataMember]
        public int NumeroPedido { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public decimal Precio2 { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public string PrecioString { get; set; }
        [DataMember]
        public string PrecioTachado { get; set; }
        [DataMember]
        public string CUV1 { get; set; }
        [DataMember]
        public string CUV2 { get; set; }
        [DataMember]
        public string DescripcionCUV2 { get; set; }
        [DataMember]
        public int Activo { get; set; }
        [DataMember]
        public int LimiteVenta { get; set; }
        [DataMember]
        public string CodigoProducto { get; set; }
        [DataMember]
        public string ImagenURL { get; set; }
        [DataMember]
        public int EtiquetaID { get; set; }
        [DataMember]
        public int EtiquetaID2 { get; set; }
        [DataMember]
        public string EtiquetaDescripcion { get; set; }
        [DataMember]
        public string EtiquetaDescripcion2 { get; set; }
        [DataMember]
        public string TextoLibre { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public int FlagDescripcion { get; set; }
        [DataMember]
        public int FlagCEP { get; set; }
        [DataMember]
        public int FlagCEP2 { get; set; }
        [DataMember]
        public int FlagTextoLibre { get; set; }
        [DataMember]
        public int FlagCantidad { get; set; }
        [DataMember]
        public string ColorFondo { get; set; }
        [DataMember]
        public int FlagEstrella { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public string TallaColor { get; set; }
        [DataMember]
        public string TipoTallaColor { get; set; }
        [DataMember]
        public int IndicadorMontoMinimo { get; set; }
        [DataMember]
        public int TipoOferta { get; set; }
        [DataMember]
        public string Mensaje { get; set; }

        [DataMember]
        public string DescripcionMarca { get; set; }
        [DataMember]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }

        [DataMember]
        public int FlagNueva { get; set; }

        [DataMember]
        public int TipoEstrategiaImagenMostrar { get; set; }

        [DataMember]
        public bool TieneStockProl { get; set; }

        [DataMember]
        public int FlagMostrarImg { get; set; }

        [DataMember]
        public int OfertaUltimoMinuto { get; set; }
        [DataMember]
        public int Imagen { get; set; }
        [DataMember]
        public string CodigoSAP { get; set; }
        [DataMember]
        public int EnMatrizComercial { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public int TieneVariedad { get; set; }

        [DataMember]
        public string CodigoAgrupacion { get; set; }


        [DataMember]
        public BEEstrategiaDetalle EstrategiaDetalle { get; set; }

        [DataMember]
        public BETipoEstrategia TipoEstrategia { get; set; }

        /// <summary>
        /// [Filtro] para la validacion del periodo de facturacion
        /// Si es true, verifica que la fecha actual sea mayor que la del inicio de facturacion
        /// </summary>
        [DataMember]
        public bool ValidarPeriodoFacturacion { get; set; }

        [DataMember]
        public double ZonaHoraria { get; set; }

        [DataMember]
        public int IdMatrizComercial { get; set; }
        [DataMember]
        public string FotoProducto01 { get; set; }

        [DataMember]
        public string CodigoTipoEstrategia { get; set; }

        [DataMember]
        public int ProdComentarioId { get; set; }

        [DataMember]
        public int CantComenAprob { get; set; }

        [DataMember]
        public int CantComenRecom { get; set; }

        [DataMember]
        public int PromValorizado { get; set; }


        public BEFichaProducto(IDataRecord row, bool partial)
        {
            LimiteVenta = row.ToInt32("LimiteVenta");
            DescripcionCUV2 = row.ToString("DescripcionCUV2");
            CUV2 = row.ToString("CUV2");
            Precio2 = row.ToDecimal("Precio2");
            ID = row.ToInt32("ID");
            FlagMostrarImg = row.ToInt32("OfertaUltimoMinuto");
            CodigoProducto = row.ToString("CodigoProducto");
            ImagenURL = row.ToString("ImagenURL");
        }

        public BEFichaProducto(IDataRecord row, int liteVersion)
        {
            EstrategiaID = row.ToInt32("EstrategiaID");
            Precio2 = row.ToDecimal("Precio2");
            NumeroPedido = row.ToInt32("NumeroPedido");
            CUV2 = row.ToString("CUV2");
            DescripcionCUV2 = row.ToString("DescripcionCUV2");
            Activo = row.ToInt32("Activo");
            ImagenURL = row.ToString("ImagenURL");
            LimiteVenta = row.ToInt32("LimiteVenta");
            CodigoProducto = row.ToString("CodigoProducto");
        }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        public BEFichaProducto()
        { }

        public BEFichaProducto(IDataRecord row)
        {
            TipoTallaColor = row.ToString("TipoTallaColor");
            EstrategiaID = row.ToInt32("EstrategiaID");
            TipoEstrategiaID = row.ToInt32("TipoEstrategiaID");
            CampaniaID = row.ToInt32("CampaniaID");
            CampaniaIDFin = row.ToInt32("CampaniaIDFin");
            NumeroPedido = row.ToInt32("NumeroPedido");
            Activo = row.ToInt32("Activo");
            ImagenURL = row.ToString("ImagenURL");
            LimiteVenta = row.ToInt32("LimiteVenta");
            DescripcionCUV2 = row.ToString("DescripcionCUV2");
            FlagDescripcion = row.ToInt32("FlagDescripcion");
            CUV1 = row.ToString("CUV");
            EtiquetaID = row.ToInt32("EtiquetaID");
            Precio = row.ToDecimal("Precio");
            FlagCEP = row.ToInt32("FlagCEP");
            CUV2 = row.ToString("CUV2");
            EtiquetaID2 = row.ToInt32("EtiquetaID2");
            Precio2 = row.ToDecimal("Precio2");
            FlagCEP2 = row.ToInt32("FlagCEP2");
            TextoLibre = row.ToString("TextoLibre");
            FlagTextoLibre = row.ToInt32("FlagTextoLibre");
            Cantidad = row.ToInt32("Cantidad");
            FlagCantidad = row.ToInt32("FlagCantidad");
            Zona = row.ToString("Zona");
            Orden = row.ToInt32("Orden");
            ID = row.ToInt32("ID");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            CodigoProducto = row.ToString("CodigoProducto");
            ColorFondo = row.ToString("ColorFondo");
            FlagEstrella = row.ToInt32("FlagEstrella");
            EtiquetaDescripcion = row.ToString("EtiquetaDescripcion");
            EtiquetaDescripcion2 = row.ToString("EtiquetaDescripcion2");
            MarcaID = row.ToInt32("MarcaID");
            TallaColor = row.ToString("TallaColor");
            TipoOferta = row.ToInt32("TipoOferta");
            IndicadorMontoMinimo = row.ToInt32("IndicadorMontoMinimo");
            Mensaje = row.ToString("Mensaje");
            DescripcionMarca = row.ToString("DescripcionMarca");
            DescripcionCategoria = row.ToString("DescripcionCategoria");
            DescripcionEstrategia = row.ToString("DescripcionEstrategia");
            FlagNueva = row.ToInt32("FlagNueva");
            TipoEstrategiaImagenMostrar = row.ToInt32("TipoEstrategiaImagenMostrar");
            TieneStockProl = row.ToBoolean("TieneStockProl");
            FlagMostrarImg = row.ToInt32("FlagMostrarImg");
            FlagMostrarImg = row.ToInt32("OfertaUltimoMinuto");
            CodigoSAP = row.ToString("CodigoSAP");
            EnMatrizComercial = row.ToInt32("EnMatrizComercial");
            CodigoEstrategia = row.ToString("CodigoEstrategia");
            TieneVariedad = row.ToInt32("TieneVariedad");
            IdMatrizComercial = row.ToInt32("IdMatrizComercial");
            FotoProducto01 = row.ToString("FotoProducto01");
            ProdComentarioId = row.ToInt32("ProdComentarioId");
            CantComenAprob = row.ToInt32("CantComenAprob");
            CantComenRecom = row.ToInt32("CantComenRecom");
            PromValorizado = row.ToInt32("PromValorizado");
            EstrategiaDetalle = new BEEstrategiaDetalle(row);
            TipoEstrategia = new BETipoEstrategia(row);
        }
    }
}
