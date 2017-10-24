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
        public string GananciaString { get; set; }
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
        public bool EsOfertaIndependiente { get; set; }

        [DataMember]
        public string ImagenOfertaIndependiente { get; set; }
        [DataMember]
        public bool MostrarImgOfertaIndependiente { get; set; }

        [DataMember]
        public decimal PrecioPublico { get; set; }
        [DataMember]
        public decimal Ganancia { get; set; }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        public BEEstrategia()
        { }

        public BEEstrategia(IDataRecord row, bool partial)
        {
            LimiteVenta = DataRecord.GetColumn<int>(row, "LimiteVenta");
            DescripcionCUV2 = DataRecord.GetColumn<string>(row, "DescripcionCUV2");
            CUV2 = DataRecord.GetColumn<string>(row, "CUV2");
            Precio2 = DataRecord.GetColumn<decimal>(row, "Precio2");
            ID = DataRecord.GetColumn<int>(row, "ID");
            FlagMostrarImg = DataRecord.GetColumn<int>(row, "FlagMostrarImg");
            CodigoProducto = DataRecord.GetColumn<string>(row, "CodigoProducto");
            ImagenURL = DataRecord.GetColumn<string>(row, "ImagenURL");
            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");
            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente"))
                ImagenOfertaIndependiente = row["ImagenOfertaIndependiente"].ToString();

            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente"))
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"].ToString());
        }

        public BEEstrategia(IDataRecord row, int liteVersion)
        {
            EstrategiaID = DataRecord.GetColumn<int>(row, "EstrategiaID");
            Precio2 = DataRecord.GetColumn<decimal>(row, "Precio2");
            NumeroPedido = DataRecord.GetColumn<int>(row, "NumeroPedido");
            CUV2 = DataRecord.GetColumn<string>(row, "CUV2");
            DescripcionCUV2 = DataRecord.GetColumn<string>(row, "DescripcionCUV2");

            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToInt32(row["Activo"]);

            ImagenURL = DataRecord.GetColumn<string>(row, "ImagenURL");
            LimiteVenta = DataRecord.GetColumn<int>(row, "LimiteVenta");
            CodigoProducto = DataRecord.GetColumn<string>(row, "CodigoProducto");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");

            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente"))
                ImagenOfertaIndependiente = row["ImagenOfertaIndependiente"].ToString();

            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente"))
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"].ToString());
        }

        public BEEstrategia(IDataRecord row)
        {
            TipoTallaColor = DataRecord.GetColumn<string>(row, "TipoTallaColor");
            EstrategiaID = DataRecord.GetColumn<int>(row, "EstrategiaID");
            TipoEstrategiaID = DataRecord.GetColumn<int>(row, "TipoEstrategiaID");
            CampaniaID = DataRecord.GetColumn<int>(row, "CampaniaID");
            CampaniaIDFin = DataRecord.GetColumn<int>(row, "CampaniaIDFin");
            NumeroPedido = DataRecord.GetColumn<int>(row, "NumeroPedido");

            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToInt32(row["Activo"]);

            LimiteVenta = DataRecord.GetColumn<int>(row, "LimiteVenta");
            DescripcionCUV2 = DataRecord.GetColumn<string>(row, "DescripcionCUV2");
            FlagDescripcion = DataRecord.GetColumn<int>(row, "FlagDescripcion");
            CUV1 = DataRecord.GetColumn<string>(row, "CUV");
            EtiquetaID = DataRecord.GetColumn<int>(row, "EtiquetaID");
            Precio = DataRecord.GetColumn<decimal>(row, "Precio");
            FlagCEP = DataRecord.GetColumn<int>(row, "FlagCEP");
            CUV2 = DataRecord.GetColumn<string>(row, "CUV2");
            EtiquetaID2 = DataRecord.GetColumn<int>(row, "EtiquetaID2");
            Precio2 = DataRecord.GetColumn<decimal>(row, "Precio2");
            FlagCEP2 = DataRecord.GetColumn<int>(row, "FlagCEP2");
            TextoLibre = DataRecord.GetColumn<string>(row, "TextoLibre");
            FlagTextoLibre = DataRecord.GetColumn<int>(row, "FlagTextoLibre");
            Cantidad = DataRecord.GetColumn<int>(row, "Cantidad");
            FlagCantidad = DataRecord.GetColumn<int>(row, "FlagCantidad");
            Zona = DataRecord.GetColumn<string>(row, "Zona");
            Orden = DataRecord.GetColumn<int>(row, "Orden");
            ID = DataRecord.GetColumn<int>(row, "ID");
            PrecioUnitario = DataRecord.GetColumn<decimal>(row, "PrecioUnitario");
            CodigoProducto = DataRecord.GetColumn<string>(row, "CodigoProducto");
            ColorFondo = DataRecord.GetColumn<string>(row, "ColorFondo");
            FlagEstrella = DataRecord.GetColumn<int>(row, "FlagEstrella");
            EtiquetaDescripcion = DataRecord.GetColumn<string>(row, "EtiquetaDescripcion");
            EtiquetaDescripcion2 = DataRecord.GetColumn<string>(row, "EtiquetaDescripcion2");
            MarcaID = DataRecord.GetColumn<int>(row, "MarcaID");
            TallaColor = DataRecord.GetColumn<string>(row, "TallaColor");
            TipoOferta = DataRecord.GetColumn<int>(row, "TipoOferta");
            IndicadorMontoMinimo = DataRecord.GetColumn<int>(row, "IndicadorMontoMinimo");
            Mensaje = DataRecord.GetColumn<string>(row, "Mensaje");
            DescripcionMarca = DataRecord.GetColumn<string>(row, "DescripcionMarca");
            DescripcionCategoria = DataRecord.GetColumn<string>(row, "DescripcionCategoria");
            DescripcionEstrategia = DataRecord.GetColumn<string>(row, "DescripcionEstrategia");
            FlagNueva = DataRecord.GetColumn<int>(row, "FlagNueva");
            TipoEstrategiaImagenMostrar = DataRecord.GetColumn<int>(row, "TipoEstrategiaImagenMostrar");
            TieneStockProl = DataRecord.GetColumn<bool>(row, "TieneStockProl");
            FlagMostrarImg = DataRecord.GetColumn<int>(row, "FlagMostrarImg");
            OfertaUltimoMinuto = DataRecord.GetColumn<int>(row, "OfertaUltimoMinuto");
            CodigoSAP = DataRecord.GetColumn<string>(row, "CodigoSAP");
            EnMatrizComercial = DataRecord.GetColumn<int>(row, "EnMatrizComercial");
            CodigoEstrategia = DataRecord.GetColumn<string>(row, "CodigoEstrategia");
            TieneVariedad = DataRecord.GetColumn<int>(row, "TieneVariedad");
            IdMatrizComercial = DataRecord.GetColumn<int>(row, "IdMatrizComercial");
            FotoProducto01 = DataRecord.GetColumn<string>(row, "FotoProducto01");
            CodigoGenerico = DataRecord.GetColumn<string>(row, "CodigoGenerico");
            ProdComentarioId = DataRecord.GetColumn<int>(row, "ProdComentarioId");
            CantComenAprob = DataRecord.GetColumn<int>(row, "CantComenAprob");
            CantComenRecom = DataRecord.GetColumn<int>(row, "CantComenRecom");
            PromValorizado = DataRecord.GetColumn<int>(row, "PromValorizado");
            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");

            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente"))
                ImagenOfertaIndependiente = row["ImagenOfertaIndependiente"].ToString();

            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente"))
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"].ToString());

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
            CampaniaID = DataRecord.GetColumn<int>(row, "CampaniaID");
            RegionID = DataRecord.GetColumn<int>(row, "RegionID");
            RegionNombre = DataRecord.GetColumn<string>(row, "RegionNombre");
            ZonaID = DataRecord.GetColumn<int>(row, "ZonaID");
            ZonaNombre = DataRecord.GetColumn<string>(row, "ZonaNombre");
            ValidacionActiva = DataRecord.GetColumn<short>(row, "ValidacionActiva");
            DiasDuracionCronograma = DataRecord.GetColumn<short>(row, "DiasDuracionCronograma");
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
        public decimal Ganancia { get; set; }
    }
}
