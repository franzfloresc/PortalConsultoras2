using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
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
        [Column("EstrategiaID")]
        public int EstrategiaID { get; set; }
        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        [DataMember]
        [Column("CampaniaIDFin")]
        public int CampaniaIDFin { get; set; }
        [DataMember]
        [Column("NumeroPedido")]
        public int NumeroPedido { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }
        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }
        [DataMember]
        [Column("ID")]
        public int ID { get; set; }
        [DataMember]
        [Column("Precio")]
        public decimal Precio { get; set; }
        [DataMember]
        [Column("Precio2")]
        public decimal Precio2 { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public string PrecioString { get; set; }
        [DataMember]
        public string PrecioTachado { get; set; }
        [DataMember]
        public string GananciaString { get; set; }
        [DataMember]
        public string CUV1 { get; set; }
        [DataMember]
        [Column("CUV2")]
        public string CUV2 { get; set; }
        [DataMember]
        [Column("DescripcionCUV2")]
        public string DescripcionCUV2 { get; set; }
        [DataMember]
        public string DescripcionCortaCUV2 { get; set; }
        [Column("Activo")]
        public bool activo { get; set; }
        private int _Activo;
        [DataMember]
        public int Activo
        {
            get
            {
                return (activo ? 1 : _Activo);
            }
            set
            {
                _Activo = value;
            }
        }
        [DataMember]
        [Column("LimiteVenta")]
        public int LimiteVenta { get; set; }
        [DataMember]
        [Column("CodigoProducto")]
        public string CodigoProducto { get; set; }
        [DataMember]
        [Column("ImagenURL")]
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
        [Column("TextoLibre")]
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

        #region EstrategiaDetalle
        [DataMember]
        public bool FlagIndividual { get; set; }
        [DataMember]
        public string Slogan { get; set; }
        [DataMember]
        public string ImgHomeDesktop { get; set; }
        [DataMember]
        public string ImgFondoDesktop { get; set; }
        [DataMember]
        public string ImgFichaDesktop { get; set; }
        [DataMember]
        public string ImgFichaFondoDesktop { get; set; }
        [DataMember]
        public string UrlVideoDesktop { get; set; }
        [DataMember]
        public string ImgHomeMobile { get; set; }
        [DataMember]
        public string ImgFondoMobile { get; set; }
        [DataMember]
        public string ImgFichaMobile { get; set; }
        [DataMember]
        public string ImgFichaFondoMobile { get; set; }
        [DataMember]
        public string UrlVideoMobile { get; set; }

        #endregion

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
        [Column("EsOfertaIndependiente")]
        public bool EsOfertaIndependiente { get; set; }

        [DataMember]
        public string ImagenOfertaIndependiente { get; set; }
        [DataMember]
        public bool MostrarImgOfertaIndependiente { get; set; }

        [DataMember]
        public decimal PrecioPublico { get; set; }
        [DataMember]
        [Column("Ganancia")]
        public decimal Ganancia { get; set; }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        [DataMember]
        public int FlagValidarImagen { get; set; }

        [DataMember]
        public int PesoMaximoImagen { get; set; }

        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }
        [DataMember]
        [Column("CodigoConcurso")]
        public string CodigoConcurso { get; set; }
        [DataMember]
        [Column("TipoConcurso")]
        public string TipoConcurso { get; set; }


        [DataMember]
        [Column("ImagenMiniaturaURL")]
        public string ImagenMiniaturaURL { get; set; }

        [DataMember]
        [Column("EsSubCampania")]
        public int EsSubCampania { get; set; }

        [DataMember]
        [Column("Niveles")]
        public string Niveles { get; set; }

        [DataMember]
        public int FlagRevista { get; set; }

        [DataMember]
        [NotMapped]
        public bool AgregarEnMatriz { get; set; }

        [DataMember]
        [NotMapped]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public string EstrategiaProductoCodigoSAP { get; set; }
        [DataMember]
        public List<BEEstrategiaProducto> EstrategiaProducto { get; set; }
        [DataMember]
        public string FotoProductoSmall { get; set; }
        [DataMember]
        public string FotoProductoMedium { get; set; }


        public BEEstrategia()
        { }

        public BEEstrategia(IDataRecord row, bool partial)
        {
            LimiteVenta = row.ToInt32("LimiteVenta");
            DescripcionCUV2 = row.ToString("DescripcionCUV2");
            CUV2 = row.ToString("CUV2");
            Precio2 = row.ToDecimal("Precio2");
            ID = row.ToInt32("ID");
            FlagMostrarImg = row.ToInt32("OfertaUltimoMinuto");
            CodigoProducto = row.ToString("CodigoProducto");
            ImagenURL = row.ToString("ImagenURL");
            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");
            EsOfertaIndependiente = row.ToBoolean("EsOfertaIndependiente");
            ImagenOfertaIndependiente = row.ToString("ImagenOfertaIndependiente");
            MostrarImgOfertaIndependiente = row.ToBoolean("MostrarImgOfertaIndependiente");
        }

        public BEEstrategia(IDataRecord row, int liteVersion)
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
            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");
            EsOfertaIndependiente = row.ToBoolean("EsOfertaIndependiente");
            ImagenOfertaIndependiente = row.ToString("ImagenOfertaIndependiente");
            MostrarImgOfertaIndependiente = row.ToBoolean("MostrarImgOfertaIndependiente");
            Orden = row.ToInt32("Orden");
            ID = row.ToInt32("ID");
            //BPT-369
            FlagValidarImagen = row.ToInt32("FlagValidarImagen");
            PesoMaximoImagen = row.ToInt32("PesoMaximoImagen");
        }

        public BEEstrategia(IDataRecord row)
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
            CodigoGenerico = row.ToString("CodigoGenerico");
            ProdComentarioId = row.ToInt32("ProdComentarioId");
            CantComenAprob = row.ToInt32("CantComenAprob");
            CantComenRecom = row.ToInt32("CantComenRecom");
            PromValorizado = row.ToInt32("PromValorizado");
            Niveles = row.ToString("Niveles");
            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");
            EsOfertaIndependiente = row.ToBoolean("EsOfertaIndependiente");
            ImagenOfertaIndependiente = row.ToString("ImagenOfertaIndependiente");
            MostrarImgOfertaIndependiente = row.ToBoolean("MostrarImgOfertaIndependiente");
            ImagenMiniaturaURL = row.ToString("ImagenMiniaturaURL");
            EsSubCampania = row.ToInt32("EsSubCampania");
            Niveles = row.ToString("Niveles");
            FlagRevista = row.ToInt32("FlagRevista");
            ImgFichaDesktop = row.ToString("ImgFichaDesktop");
            ImgFichaMobile = row.ToString("ImgFichaMobile");
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
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "RegionID"))
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "RegionNombre"))
                RegionNombre = Convert.ToString(row["RegionNombre"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "ZonaNombre"))
                ZonaNombre = Convert.ToString(row["ZonaNombre"]);
            if (DataRecord.HasColumn(row, "ValidacionActiva"))
                ValidacionActiva = Convert.ToInt16(row["ValidacionActiva"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronograma"))
                DiasDuracionCronograma = Convert.ToInt16(Convert.IsDBNull(row["DiasDuracionCronograma"]) ? 1 : row["DiasDuracionCronograma"]);
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
        public decimal Ganancia { get; set; }
        public string Niveles { get; set; }
    }
}
