using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstrategia : BaseEntidad
    {
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string ConsultoraID { get; set; }
        [DataMember]
        public int EstrategiaID { get; set; }
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

        [DataMember]
        public string URLCompartir { get; set; }

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
        public string ImgFondoDesktop { get; set; }
        [DataMember]
        public string ImgPrevDesktop { get; set; }
        [DataMember]
        public string ImgFichaDesktop { get; set; }
        [DataMember]
        public string UrlVideoDesktop { get; set; }
        [DataMember]
        public string ImgFondoMobile { get; set; }
        [DataMember]
        public string ImgFichaMobile { get; set; }
        [DataMember]
        public string UrlVideoMobile { get; set; }
        [DataMember]
        public string ImgFichaFondoDesktop { get; set; }
        [DataMember]
        public string ImgFichaFondoMobile { get; set; }
        [DataMember]
        public string ImgHomeDesktop { get; set; }
        [DataMember]
        public string ImgHomeMobile { get; set; }
        [DataMember]
        public string CodigoGenerico { get; set; }

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

        [DataMember]
        public decimal PrecioPublico { get; set; }
        
        public BEEstrategia(IDataRecord row, bool partial)
        {
            LimiteVenta = GetFieldInt(row, "LimiteVenta");
            DescripcionCUV2 = GetFieldString(row, "DescripcionCUV2");
            CUV2 = GetFieldString(row, "CUV2");
            Precio2 = GetFieldDecimal(row, "Precio2");
            ID = GetFieldInt(row, "ID");
            FlagMostrarImg = GetFieldInt(row, "FlagMostrarImg");
            CodigoProducto = GetFieldString(row, "CodigoProducto");
            ImagenURL = GetFieldString(row, "ImagenURL");
            PrecioPublico = GetFieldDecimal(row, "PrecioPublico");
        }

        public BEEstrategia(IDataRecord row, int liteVersion)
        {
            EstrategiaID = GetFieldInt(row, "EstrategiaID");
            Precio2 = GetFieldDecimal(row, "Precio2");
            NumeroPedido = GetFieldInt(row, "NumeroPedido");
            CUV2 = GetFieldString(row, "CUV2");
            DescripcionCUV2 = GetFieldString(row, "DescripcionCUV2");
            Activo = GetFieldInt(row, "Activo");
            ImagenURL = GetFieldString(row, "ImagenURL");
            LimiteVenta = GetFieldInt(row, "LimiteVenta");
            CodigoProducto = GetFieldString(row, "CodigoProducto");
        }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        public BEEstrategia()
        { }

        public BEEstrategia(IDataRecord row)
        {
            TipoTallaColor = GetFieldString(row, "TipoTallaColor");
            EstrategiaID = GetFieldInt(row, "EstrategiaID");
            TipoEstrategiaID = GetFieldInt(row, "TipoEstrategiaID");
            CampaniaID = GetFieldInt(row, "CampaniaID");
            CampaniaIDFin = GetFieldInt(row, "CampaniaIDFin");
            NumeroPedido = GetFieldInt(row, "NumeroPedido");
            Activo = GetFieldInt(row, "Activo");
            LimiteVenta = GetFieldInt(row, "LimiteVenta");
            DescripcionCUV2 = GetFieldString(row, "DescripcionCUV2");
            FlagDescripcion = GetFieldInt(row, "FlagDescripcion");
            CUV1 = GetFieldString(row, "CUV");
            EtiquetaID = GetFieldInt(row, "EtiquetaID");
            Precio = GetFieldDecimal(row, "Precio");
            FlagCEP = GetFieldInt(row, "FlagCEP");
            CUV2 = GetFieldString(row, "CUV2");
            EtiquetaID2 = GetFieldInt(row, "EtiquetaID2");
            Precio2 = GetFieldDecimal(row, "Precio2");
            FlagCEP2 = GetFieldInt(row, "FlagCEP2");
            TextoLibre = GetFieldString(row, "TextoLibre");
            FlagTextoLibre = GetFieldInt(row, "FlagTextoLibre");
            Cantidad = GetFieldInt(row, "Cantidad");
            FlagCantidad = GetFieldInt(row, "FlagCantidad");
            Zona = GetFieldString(row, "Zona");
            Orden = GetFieldInt(row, "Orden");
            ID = GetFieldInt(row, "ID");
            PrecioUnitario = GetFieldDecimal(row, "PrecioUnitario");
            CodigoProducto = GetFieldString(row, "CodigoProducto");
            ColorFondo = GetFieldString(row, "ColorFondo");
            FlagEstrella = GetFieldInt(row, "FlagEstrella");
            EtiquetaDescripcion = GetFieldString(row, "EtiquetaDescripcion");
            EtiquetaDescripcion2 = GetFieldString(row, "EtiquetaDescripcion2");
            MarcaID = GetFieldInt(row, "MarcaID");
            TallaColor = GetFieldString(row, "TallaColor");
            TipoOferta = GetFieldInt(row, "TipoOferta");
            IndicadorMontoMinimo = GetFieldInt(row, "IndicadorMontoMinimo");
            Mensaje = GetFieldString(row, "Mensaje");
            DescripcionMarca = GetFieldString(row, "DescripcionMarca");
            DescripcionCategoria = GetFieldString(row, "DescripcionCategoria");
            DescripcionEstrategia = GetFieldString(row, "DescripcionEstrategia");
            FlagNueva = GetFieldInt(row, "FlagNueva");
            TipoEstrategiaImagenMostrar = GetFieldInt(row, "TipoEstrategiaImagenMostrar");
            TieneStockProl = GetFieldBool(row, "TieneStockProl");
            FlagMostrarImg = GetFieldInt(row, "FlagMostrarImg");
            OfertaUltimoMinuto = GetFieldInt(row, "OfertaUltimoMinuto");
            CodigoSAP = GetFieldString(row, "CodigoSAP");
            EnMatrizComercial = GetFieldInt(row, "EnMatrizComercial");
            CodigoEstrategia = GetFieldString(row, "CodigoEstrategia");
            TieneVariedad = GetFieldInt(row, "TieneVariedad");
            IdMatrizComercial = GetFieldInt(row, "IdMatrizComercial");
            FotoProducto01 = GetFieldString(row, "FotoProducto01");
            CodigoGenerico = GetFieldString(row, "CodigoGenerico");
            ProdComentarioId = GetFieldInt(row, "ProdComentarioId");
            CantComenAprob = GetFieldInt(row, "CantComenAprob");
            CantComenRecom = GetFieldInt(row, "CantComenRecom");
            PromValorizado = GetFieldInt(row, "PromValorizado");
            PrecioPublico = GetFieldDecimal(row, "PrecioPublico");

            EstrategiaDetalle = new BEEstrategiaDetalle(row);
            TipoEstrategia = new BETipoEstrategia(row);
        }
    }

    [DataContract]
    public class BEConfiguracionValidacionZE : BaseEntidad
    {
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public int RegionID { set; get; }
        [DataMember]
        public string RegionNombre { set; get; }
        [DataMember]
        public int ZonaID { set; get; }
        [DataMember]
        public string ZonaNombre { set; get; }
        [DataMember]
        public Int16 ValidacionActiva { set; get; }
        [DataMember]
        public Int16 DiasDuracionCronograma { get; set; }

        public BEConfiguracionValidacionZE()
        { }

        public BEConfiguracionValidacionZE(IDataRecord row)
        {
            CampaniaID = GetFieldInt(row, "CampaniaID");
            RegionID = GetFieldInt(row, "RegionID");
            RegionNombre = GetFieldString(row, "RegionNombre");
            ZonaID = GetFieldInt(row, "ZonaID");
            ZonaNombre = GetFieldString(row, "ZonaNombre");
            ValidacionActiva = GetFieldShort(row, "ValidacionActiva");
            DiasDuracionCronograma = GetFieldShort(row, "DiasDuracionCronograma");
            DiasDuracionCronograma = (short) (DiasDuracionCronograma == 0 ? 1 : DiasDuracionCronograma);
        }
    }

    public class BEEstrategiaType
    {
        public int CampaniaId { get; set; }
        public string CUV { get; set; }
        public string Descripción { get; set; }
        public decimal PrecioOferta { get; set; }
        public decimal PrecioTachado { get; set; }
        public string CodigoSap { get; set; }
        public int OfertaUltimoMinuto { get; set; }
        public int LimiteVenta { get; set; }

        public string UsuarioCreacion { get; set; }
        public string FotoProducto01 { get; set; }

        public string CodigoEstrategia { get; set; }
        public int TieneVariedad { get; set; }
        public decimal PrecioPublico { get; set; }
    }
}
