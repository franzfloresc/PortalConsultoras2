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

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = Convert.ToString(row["DescripcionCUV2"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = Convert.ToString(row["CUV2"]);

            if (DataRecord.HasColumn(row, "Precio2"))
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "OfertaUltimoMinuto"))
                FlagMostrarImg = Convert.ToInt32(row["OfertaUltimoMinuto"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);

            if (DataRecord.HasColumn(row, "ImagenURL"))
                ImagenURL = Convert.ToString(row["ImagenURL"]);

        }

        public BEFichaProducto(IDataRecord row, int liteVersion)
        {
            if (DataRecord.HasColumn(row, "EstrategiaID"))
                EstrategiaID = Convert.ToInt32(row["EstrategiaID"]);

            if (DataRecord.HasColumn(row, "Precio2"))
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "NumeroPedido"))
                NumeroPedido = Convert.ToInt32(row["NumeroPedido"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = Convert.ToString(row["CUV2"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = Convert.ToString(row["DescripcionCUV2"]);

            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToInt32(row["Activo"]);

            if (DataRecord.HasColumn(row, "ImagenURL"))
                ImagenURL = Convert.ToString(row["ImagenURL"]);

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
        }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        public BEFichaProducto()
        { }

        public BEFichaProducto(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoTallaColor"))
                TipoTallaColor = Convert.ToString(row["TipoTallaColor"]);

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
                ImagenURL = Convert.ToString(row["ImagenURL"]);

            if (DataRecord.HasColumn(row, "LimiteVenta"))
                LimiteVenta = Convert.ToInt32(row["LimiteVenta"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV2"))
                DescripcionCUV2 = Convert.ToString(row["DescripcionCUV2"]);

            if (DataRecord.HasColumn(row, "FlagDescripcion"))
                FlagDescripcion = Convert.ToInt32(row["FlagDescripcion"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV1 = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "EtiquetaID"))
                EtiquetaID = Convert.ToInt32(row["EtiquetaID"]);

            if (DataRecord.HasColumn(row, "Precio"))
                Precio = Convert.ToDecimal(row["Precio"]);

            if (DataRecord.HasColumn(row, "FlagCEP"))
                FlagCEP = Convert.ToInt32(row["FlagCEP"]);

            if (DataRecord.HasColumn(row, "CUV2"))
                CUV2 = Convert.ToString(row["CUV2"]);

            if (DataRecord.HasColumn(row, "EtiquetaID2"))
                EtiquetaID2 = Convert.ToInt32(row["EtiquetaID2"]);

            if (DataRecord.HasColumn(row, "Precio2"))
                Precio2 = Convert.ToDecimal(row["Precio2"]);

            if (DataRecord.HasColumn(row, "FlagCEP2"))
                FlagCEP2 = Convert.ToInt32(row["FlagCEP2"]);

            if (DataRecord.HasColumn(row, "TextoLibre"))
                TextoLibre = Convert.ToString(row["TextoLibre"]);

            if (DataRecord.HasColumn(row, "FlagTextoLibre"))
                FlagTextoLibre = Convert.ToInt32(row["FlagTextoLibre"]);

            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "FlagCantidad"))
                FlagCantidad = Convert.ToInt32(row["FlagCantidad"]);

            if (DataRecord.HasColumn(row, "Zona"))
                Zona = Convert.ToString(row["Zona"]);

            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);

            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);

            if (DataRecord.HasColumn(row, "ColorFondo"))
                ColorFondo = Convert.ToString(row["ColorFondo"]);

            if (DataRecord.HasColumn(row, "FlagEstrella"))
                FlagEstrella = Convert.ToInt32(row["FlagEstrella"]);

            if (DataRecord.HasColumn(row, "EtiquetaDescripcion"))
                EtiquetaDescripcion = Convert.ToString(row["EtiquetaDescripcion"]);

            if (DataRecord.HasColumn(row, "EtiquetaDescripcion2"))
                EtiquetaDescripcion2 = Convert.ToString(row["EtiquetaDescripcion2"]);

            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "TallaColor"))
                TallaColor = Convert.ToString(row["TallaColor"]);

            if (DataRecord.HasColumn(row, "TipoOferta"))
                TipoOferta = Convert.ToInt32(row["TipoOferta"]);

            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);

            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);

            if (DataRecord.HasColumn(row, "DescripcionMarca"))
                DescripcionMarca = Convert.ToString(row["DescripcionMarca"]);

            if (DataRecord.HasColumn(row, "DescripcionCategoria"))
                DescripcionCategoria = Convert.ToString(row["DescripcionCategoria"]);

            if (DataRecord.HasColumn(row, "DescripcionEstrategia"))
                DescripcionEstrategia = Convert.ToString(row["DescripcionEstrategia"]);

            if (DataRecord.HasColumn(row, "FlagNueva"))
                FlagNueva = Convert.ToInt32(row["FlagNueva"]);

            if (DataRecord.HasColumn(row, "TipoEstrategiaImagenMostrar"))
                TipoEstrategiaImagenMostrar = Convert.ToInt32(row["TipoEstrategiaImagenMostrar"]);

            if (DataRecord.HasColumn(row, "TieneStockProl"))
                TieneStockProl = Convert.ToBoolean(row["TieneStockProl"]);

            if (DataRecord.HasColumn(row, "FlagMostrarImg"))
                FlagMostrarImg = Convert.ToInt32(row["FlagMostrarImg"]);

            if (DataRecord.HasColumn(row, "OfertaUltimoMinuto"))
                FlagMostrarImg = Convert.ToInt32(row["OfertaUltimoMinuto"]);

            if (DataRecord.HasColumn(row, "CodigoSAP"))
                CodigoSAP = Convert.ToString(row["CodigoSAP"]);

            if (DataRecord.HasColumn(row, "EnMatrizComercial"))
                EnMatrizComercial = Convert.ToInt32(row["EnMatrizComercial"]);

            if (DataRecord.HasColumn(row, "CodigoEstrategia"))
                CodigoEstrategia = Convert.ToString(row["CodigoEstrategia"]);

            if (DataRecord.HasColumn(row, "TieneVariedad"))
                TieneVariedad = Convert.ToInt32(row["TieneVariedad"]);

            if (DataRecord.HasColumn(row, "IdMatrizComercial"))
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);

            if (DataRecord.HasColumn(row, "FotoProducto01"))
                FotoProducto01 = Convert.ToString(row["FotoProducto01"]);

            if (DataRecord.HasColumn(row, "ProdComentarioId"))
                ProdComentarioId = Convert.ToInt32(row["ProdComentarioId"]);

            if (DataRecord.HasColumn(row, "CantComenAprob"))
                CantComenAprob = Convert.ToInt32(row["CantComenAprob"]);

            if (DataRecord.HasColumn(row, "CantComenRecom"))
                CantComenRecom = Convert.ToInt32(row["CantComenRecom"]);

            if (DataRecord.HasColumn(row, "PromValorizado"))
                PromValorizado = Convert.ToInt32(row["PromValorizado"]);

            EstrategiaDetalle = new BEEstrategiaDetalle(row);
            TipoEstrategia = new BETipoEstrategia(row);
        }
    }
}
