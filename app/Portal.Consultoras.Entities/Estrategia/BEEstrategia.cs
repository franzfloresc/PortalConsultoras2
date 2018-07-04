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
            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = row["DescripcionCUV2"].ToString();

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = row["CUV2"].ToString();

            if (DataRecord.HasColumn(row, "Precio2"))
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "OfertaUltimoMinuto"))
                FlagMostrarImg = Convert.ToInt32(row["OfertaUltimoMinuto"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = row["CodigoProducto"].ToString();

            if (DataRecord.HasColumn(row, "ImagenURL"))
                ImagenURL = row["ImagenURL"].ToString();

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
            if (DataRecord.HasColumn(row, "EstrategiaID"))
                EstrategiaID = Convert.ToInt32(row["EstrategiaID"]);

            if (DataRecord.HasColumn(row, "Precio2"))
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "NumeroPedido"))
                NumeroPedido = Convert.ToInt32(row["NumeroPedido"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = row["CUV2"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = row["DescripcionCUV2"].ToString();

            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToInt32(row["Activo"]);

            if (DataRecord.HasColumn(row, "ImagenURL"))
                ImagenURL = row["ImagenURL"].ToString();

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = row["CodigoProducto"].ToString();

            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");

            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente"))
                ImagenOfertaIndependiente = row["ImagenOfertaIndependiente"].ToString();

            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente"))
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);

            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);
            //BPT-369
            if (DataRecord.HasColumn(row, "FlagValidarImagen"))
                FlagValidarImagen = int.Parse((row["FlagValidarImagen"].ToString()));

            if (DataRecord.HasColumn(row, "PesoMaximoImagen"))
                PesoMaximoImagen = int.Parse((row["PesoMaximoImagen"].ToString()));



        }

        public BEEstrategia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoTallaColor"))
                TipoTallaColor = row["TipoTallaColor"].ToString();

            if (DataRecord.HasColumn(row, "EstrategiaID"))
                EstrategiaID = Convert.ToInt32(row["EstrategiaID"]);

            if (DataRecord.HasColumn(row, "TipoEstrategiaID"))
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);

            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CampaniaIDFin"))
                CampaniaIDFin = Convert.ToInt32(row["CampaniaIDFin"]);

            if (DataRecord.HasColumn(row, "NumeroPedido"))
                NumeroPedido = Convert.ToInt32(row["NumeroPedido"]);

            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToInt32(row["Activo"]);

            if (DataRecord.HasColumn(row, "ImagenURL"))
                ImagenURL = row["ImagenURL"].ToString();

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = row["DescripcionCUV2"].ToString();

            if (DataRecord.HasColumn(row, "FlagDescripcion"))
                FlagDescripcion = Convert.ToInt32(row["FlagDescripcion"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV1 = row["CUV"].ToString();

            if (DataRecord.HasColumn(row, "EtiquetaID"))
                EtiquetaID = Convert.ToInt32(row["EtiquetaID"]);

            if (DataRecord.HasColumn(row, "Precio"))
                Precio = Convert.ToDecimal(row["Precio"]);

            if (DataRecord.HasColumn(row, "FlagCEP"))
                FlagCEP = Convert.ToInt32(row["FlagCEP"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = row["CUV2"].ToString();

            if (DataRecord.HasColumn(row, "EtiquetaID2"))
                EtiquetaID2 = Convert.ToInt32(row["EtiquetaID2"]);

            if (DataRecord.HasColumn(row, "Precio2"))
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "FlagCEP2"))
                FlagCEP2 = Convert.ToInt32(row["FlagCEP2"]);

            if (DataRecord.HasColumn(row, "TextoLibre"))
                TextoLibre = row["TextoLibre"].ToString();

            if (DataRecord.HasColumn(row, "FlagTextoLibre"))
                FlagTextoLibre = Convert.ToInt32(row["FlagTextoLibre"]);

            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "FlagCantidad"))
                FlagCantidad = Convert.ToInt32(row["FlagCantidad"]);

            if (DataRecord.HasColumn(row, "Zona"))
                Zona = row["Zona"].ToString();

            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);

            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = row["CodigoProducto"].ToString();

            if (DataRecord.HasColumn(row, "ColorFondo"))
                ColorFondo = row["ColorFondo"].ToString();

            if (DataRecord.HasColumn(row, "FlagEstrella"))
                FlagEstrella = Convert.ToInt32(row["FlagEstrella"]);

            if (DataRecord.HasColumn(row, "EtiquetaDescripcion"))
                EtiquetaDescripcion = row["EtiquetaDescripcion"].ToString();

            if (DataRecord.HasColumn(row, "EtiquetaDescripcion2"))
                EtiquetaDescripcion2 = row["EtiquetaDescripcion2"].ToString();

            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "TallaColor"))
                TallaColor = row["TallaColor"].ToString();

            if (DataRecord.HasColumn(row, "TipoOferta"))
                TipoOferta = Convert.ToInt32(row["TipoOferta"]);

            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);

            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = row["Mensaje"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionMarca"))
                DescripcionMarca = row["DescripcionMarca"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionCategoria"))
                DescripcionCategoria = row["DescripcionCategoria"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = row["DescripcionEstrategia"].ToString();

            if (DataRecord.HasColumn(row, "FlagNueva"))
                FlagNueva = Convert.ToInt32(row["FlagNueva"].ToString());

            if (DataRecord.HasColumn(row, "TipoEstrategiaImagenMostrar"))
                TipoEstrategiaImagenMostrar = Convert.ToInt32(row["TipoEstrategiaImagenMostrar"].ToString());

            if (DataRecord.HasColumn(row, "TieneStockProl"))
                TieneStockProl = Convert.ToBoolean(row["TieneStockProl"].ToString());

            if (DataRecord.HasColumn(row, "FlagMostrarImg"))
                FlagMostrarImg = Convert.ToInt32(row["FlagMostrarImg"]);

            if (DataRecord.HasColumn(row, "OfertaUltimoMinuto"))
                FlagMostrarImg = Convert.ToInt32(row["OfertaUltimoMinuto"]);

            if (DataRecord.HasColumn(row, "CodigoSAP"))
                CodigoSAP = row["CodigoSAP"].ToString().Trim();

            if (DataRecord.HasColumn(row, "EnMatrizComercial"))
                EnMatrizComercial = Convert.ToInt32(row["EnMatrizComercial"]);

            if (DataRecord.HasColumn(row, "CodigoEstrategia"))
                CodigoEstrategia = Convert.ToString(row["CodigoEstrategia"]);

            if (DataRecord.HasColumn(row, "TieneVariedad"))
                TieneVariedad = Convert.ToInt32(row["TieneVariedad"]);

            if (DataRecord.HasColumn(row, "IdMatrizComercial"))
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);

            if (DataRecord.HasColumn(row, "FotoProducto01"))
                FotoProducto01 = row["FotoProducto01"].ToString();

            if (DataRecord.HasColumn(row, "CodigoGenerico"))
                CodigoGenerico = Convert.ToString(row["CodigoGenerico"]);

            if (DataRecord.HasColumn(row, "ProdComentarioId"))
                ProdComentarioId = Convert.ToInt32(row["ProdComentarioId"]);

            if (DataRecord.HasColumn(row, "CantComenAprob"))
                CantComenAprob = Convert.ToInt32(row["CantComenAprob"]);

            if (DataRecord.HasColumn(row, "CantComenRecom"))
                CantComenRecom = Convert.ToInt32(row["CantComenRecom"]);

            if (DataRecord.HasColumn(row, "PromValorizado"))
                PromValorizado = Convert.ToInt32(row["PromValorizado"]);

            if (DataRecord.HasColumn(row, "Niveles"))
                Niveles = Convert.ToString(row["Niveles"]);

            PrecioPublico = DataRecord.GetColumn<decimal>(row, "PrecioPublico");
            Ganancia = DataRecord.GetColumn<decimal>(row, "Ganancia");

            if (DataRecord.HasColumn(row, "EsOfertaIndependiente"))
                EsOfertaIndependiente = Convert.ToBoolean(row["EsOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "ImagenOfertaIndependiente"))
                ImagenOfertaIndependiente = row["ImagenOfertaIndependiente"].ToString();

            if (DataRecord.HasColumn(row, "MostrarImgOfertaIndependiente"))
                MostrarImgOfertaIndependiente = Convert.ToBoolean(row["MostrarImgOfertaIndependiente"].ToString());

            if (DataRecord.HasColumn(row, "ImagenMiniaturaURL"))
                ImagenMiniaturaURL = row["ImagenMiniaturaURL"].ToString();

            if (DataRecord.HasColumn(row, "EsSubCampania"))
                EsSubCampania = Convert.ToInt32(row["EsSubCampania"]);

            if (DataRecord.HasColumn(row, "Niveles"))
                Niveles = row["Niveles"].ToString();
            
            if (DataRecord.HasColumn(row, "FlagRevista"))
                FlagRevista = Convert.ToInt32(row["FlagRevista"]);

            if (DataRecord.HasColumn(row, "ImgFichaDesktop"))
                ImgFichaDesktop = row["ImgFichaDesktop"].ToString();

            if (DataRecord.HasColumn(row, "ImgFichaMobile"))
                ImgFichaMobile = row["ImgFichaMobile"].ToString();

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