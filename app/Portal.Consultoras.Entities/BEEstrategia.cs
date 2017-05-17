﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstrategia
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

        //R2469 - JICM - Agregando más campos para la Marcación de los Pedidos
        [DataMember]
        public string DescripcionMarca { get; set; }
        [DataMember]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }
        // FIN 
        /*R2621 -LR - Se añade la propiedad FlagNueva*/
        [DataMember]
        public int FlagNueva { get; set; }

        [DataMember]
        public int TipoEstrategiaImagenMostrar { get; set; }

        [DataMember]
        public bool TieneStockProl { get; set; }

        [DataMember]
        public int FlagMostrarImg { get; set; }      // SB2-353     

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
        public int IdMatrizComercial { get; set; }
        [DataMember]
        public string FotoProducto01 { get; set; }
        // Campos solo para la estrategia de lanzamiento...
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
        public string CodigoTipoEstrategia { get; set; }

        //[DataMember]
        //public string CodigoSAP { get; set; }

        /// <summary>
        /// Url para compartir, es llenado en el servicio de estrategia
        /// GetEstrategiasPedido
        /// </summary>
        [DataMember]
        public string URLCompartir { get; set; }

        /// <summary>
        /// [Filtro] para la validacion del periodo de facturacion
        /// Si es true, verifica que la fecha actual sea mayor que la del inicio de facturacion
        /// </summary>
        [DataMember]
        public bool ValidarPeriodoFacturacion { get; set; }
        
        /// <summary>
        /// [Filtro] del usuario
        /// </summary>
        [DataMember]
        public double ZonaHoraria { get; set; }

        /// <summary>
        /// [Filtro] del usuario
        /// </summary>
        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }
        
        public BEEstrategia()
        { }
        
        public BEEstrategia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoTallaColor") && row["TipoTallaColor"] != DBNull.Value)
                TipoTallaColor = row["TipoTallaColor"].ToString();

            if (DataRecord.HasColumn(row, "EstrategiaID") && row["EstrategiaID"] != DBNull.Value)
                EstrategiaID = Convert.ToInt32(row["EstrategiaID"]);

            if (DataRecord.HasColumn(row, "TipoEstrategiaID") && row["TipoEstrategiaID"] != DBNull.Value)
                TipoEstrategiaID = Convert.ToInt32(row["TipoEstrategiaID"]);

            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CampaniaIDFin") && row["CampaniaIDFin"] != DBNull.Value)
                CampaniaIDFin = Convert.ToInt32(row["CampaniaIDFin"]);

            if (DataRecord.HasColumn(row, "NumeroPedido") && row["NumeroPedido"] != DBNull.Value)
                NumeroPedido = Convert.ToInt32(row["NumeroPedido"]);

            if (DataRecord.HasColumn(row, "Activo") && row["Activo"] != DBNull.Value)
                Activo = Convert.ToInt32(row["Activo"]);

            if (DataRecord.HasColumn(row, "ImagenURL") && row["ImagenURL"] != DBNull.Value)
                ImagenURL = row["ImagenURL"].ToString();

            if (DataRecord.HasColumn(row, "LimiteVenta") && row["LimiteVenta"] != DBNull.Value)
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2") && row["DescripcionCUV2"] != DBNull.Value)
                DescripcionCUV2 = row["DescripcionCUV2"].ToString();

            if (DataRecord.HasColumn(row, "FlagDescripcion") && row["FlagDescripcion"] != DBNull.Value)
                FlagDescripcion = Convert.ToInt32(row["FlagDescripcion"]);

            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV1 = row["CUV"].ToString();

            if (DataRecord.HasColumn(row, "EtiquetaID") && row["EtiquetaID"] != DBNull.Value)
                EtiquetaID = Convert.ToInt32(row["EtiquetaID"]);

            if (DataRecord.HasColumn(row, "Precio") && row["Precio"] != DBNull.Value)
                Precio = Convert.ToDecimal(row["Precio"]);

            if (DataRecord.HasColumn(row, "FlagCEP") && row["FlagCEP"] != DBNull.Value)
                FlagCEP = Convert.ToInt32(row["FlagCEP"]);

            if (DataRecord.HasColumn(row, "CUV2") && row["CUV2"] != DBNull.Value)
                CUV2 = row["CUV2"].ToString();

            if (DataRecord.HasColumn(row, "EtiquetaID2") && row["EtiquetaID2"] != DBNull.Value)
                EtiquetaID2 = Convert.ToInt32(row["EtiquetaID2"]);

            if (DataRecord.HasColumn(row, "Precio2") && row["Precio2"] != DBNull.Value)
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "FlagCEP2") && row["FlagCEP2"] != DBNull.Value)
                FlagCEP2 = Convert.ToInt32(row["FlagCEP2"]);

            if (DataRecord.HasColumn(row, "TextoLibre") && row["TextoLibre"] != DBNull.Value)
                TextoLibre = row["TextoLibre"].ToString();

            if (DataRecord.HasColumn(row, "FlagTextoLibre") && row["FlagTextoLibre"] != DBNull.Value)
                FlagTextoLibre = Convert.ToInt32(row["FlagTextoLibre"]);

            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "FlagCantidad") && row["FlagCantidad"] != DBNull.Value)
                FlagCantidad = Convert.ToInt32(row["FlagCantidad"]);

            if (DataRecord.HasColumn(row, "Zona") && row["Zona"] != DBNull.Value)
                Zona = row["Zona"].ToString();

            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);

            if (DataRecord.HasColumn(row, "ID") && row["ID"] != DBNull.Value)
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "PrecioUnitario") && row["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);

            if (DataRecord.HasColumn(row, "CodigoProducto") && row["CodigoProducto"] != DBNull.Value)
                CodigoProducto = row["CodigoProducto"].ToString();

            if (DataRecord.HasColumn(row, "ColorFondo") && row["ColorFondo"] != DBNull.Value)
                ColorFondo = row["ColorFondo"].ToString();

            if (DataRecord.HasColumn(row, "FlagEstrella") && row["FlagEstrella"] != DBNull.Value)
                FlagEstrella = Convert.ToInt32(row["FlagEstrella"]);

            if (DataRecord.HasColumn(row, "EtiquetaDescripcion") && row["EtiquetaDescripcion"] != DBNull.Value)
                EtiquetaDescripcion = row["EtiquetaDescripcion"].ToString();

            if (DataRecord.HasColumn(row, "EtiquetaDescripcion2") && row["EtiquetaDescripcion2"] != DBNull.Value)
                EtiquetaDescripcion2 = row["EtiquetaDescripcion2"].ToString();

            if (DataRecord.HasColumn(row, "MarcaID") && row["MarcaID"] != DBNull.Value)
                MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "TallaColor") && row["TallaColor"] != DBNull.Value)
                TallaColor = row["TallaColor"].ToString();

            if (DataRecord.HasColumn(row, "TipoOferta") && row["TipoOferta"] != DBNull.Value)
                TipoOferta = Convert.ToInt32(row["TipoOferta"]);

            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo") && row["IndicadorMontoMinimo"] != DBNull.Value)
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);

            if (DataRecord.HasColumn(row, "Mensaje") && row["Mensaje"] != DBNull.Value)
                Mensaje = row["Mensaje"].ToString();

            //R2469 - JICM - Agregando más campos para la Marcación de los Pedidos
            if (DataRecord.HasColumn(row, "DescripcionMarca") && row["DescripcionMarca"] != DBNull.Value)
                DescripcionMarca = row["DescripcionMarca"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionCategoria") && row["DescripcionCategoria"] != DBNull.Value)
                DescripcionCategoria = row["DescripcionCategoria"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionEstrategia") && row["DescripcionEstrategia"] != DBNull.Value)
                DescripcionEstrategia = row["DescripcionEstrategia"].ToString();
            //FIN 
            /*R2621LR - Flag Nueva*/
            if (DataRecord.HasColumn(row, "FlagNueva") && row["FlagNueva"] != DBNull.Value)
                FlagNueva = Convert.ToInt32(row["FlagNueva"].ToString());

            if (DataRecord.HasColumn(row, "TipoEstrategiaImagenMostrar") && row["TipoEstrategiaImagenMostrar"] != DBNull.Value)
                TipoEstrategiaImagenMostrar = Convert.ToInt32(row["TipoEstrategiaImagenMostrar"].ToString());

            if (DataRecord.HasColumn(row, "TieneStockProl") && row["TieneStockProl"] != DBNull.Value)
                TieneStockProl = Convert.ToBoolean(row["TieneStockProl"].ToString());

            // SB2-353
            if (DataRecord.HasColumn(row, "FlagMostrarImg") && row["FlagMostrarImg"] != DBNull.Value)
                FlagMostrarImg = Convert.ToInt32(row["FlagMostrarImg"]);

            if (DataRecord.HasColumn(row, "OfertaUltimoMinuto") && row["OfertaUltimoMinuto"] != DBNull.Value)
                FlagMostrarImg = Convert.ToInt32(row["OfertaUltimoMinuto"]);

            if (DataRecord.HasColumn(row, "CodigoSAP") && row["CodigoSAP"] != DBNull.Value)
                CodigoSAP = row["CodigoSAP"].ToString().Trim();

            if (DataRecord.HasColumn(row, "EnMatrizComercial") && row["EnMatrizComercial"] != DBNull.Value)
                EnMatrizComercial = Convert.ToInt32(row["EnMatrizComercial"]); 

            if (DataRecord.HasColumn(row, "CodigoEstrategia") && row["CodigoEstrategia"] != DBNull.Value)
                CodigoEstrategia = Convert.ToString(row["CodigoEstrategia"]);

            if (DataRecord.HasColumn(row, "TieneVariedad") && row["TieneVariedad"] != DBNull.Value)
                TieneVariedad = Convert.ToInt32(row["TieneVariedad"]);

            if (DataRecord.HasColumn(row, "IdMatrizComercial") && row["IdMatrizComercial"] != DBNull.Value)
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);

            if (DataRecord.HasColumn(row, "FotoProducto01") && row["FotoProducto01"] != DBNull.Value)
                FotoProducto01 = row["FotoProducto01"].ToString();
        }
    }
    // 1747 - Inicio
    [DataContract]
    public class BEConfiguracionValidacionZE
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
        public int PaisID { set; get; }
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
    }
    // 1747 - Fin
}
