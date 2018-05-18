using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaFlexipago
    {
        [DataMember]
        [ViewProperty]
        public int PaisID { get; set; }

        [DataMember]
        [ViewProperty]
        public int OfertaProductoID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Stock { get; set; }
        [DataMember]
        public string CategoriaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [ViewProperty]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        [ViewProperty]
        public string Descripcion { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioNormal { get; set; }
        [DataMember]
        [ViewProperty]
        public string ImagenProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public int Orden { get; set; }
        [DataMember]
        [ViewProperty]
        public int UnidadesPermitidas { get; set; }
        [DataMember]
        [ViewProperty]
        public int FlagHabilitarProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoCampania { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoTipoOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public string TipoOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public int NroOrden { get; set; }
        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionLegal { get; set; }
        [DataMember]
        [ViewProperty]
        public int MarcaID { get; set; }
        [DataMember]
        [ViewProperty]
        public int Flag { get; set; }
        [DataMember]
        [ViewProperty]
        public int StockInicial { get; set; }

        [DataMember]
        [ViewProperty]
        public string LinksFlexipago { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoTotal { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoPagado { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoPorCuota { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal InteresePorCuota { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal CuotaPendCampaniaActual { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal CuotaPendCampaniaSiguiente { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PedidoBase { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal LineaCredito { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoMinimoFlexipago { get; set; }

        public BEOfertaFlexipago() { }
        public BEOfertaFlexipago(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OfertaProductoID"))
                OfertaProductoID = Convert.ToInt32(row["OfertaProductoID"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "NroOrden"))
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "TipoOferta"))
                TipoOferta = Convert.ToString(row["TipoOferta"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta"))
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "PrecioNormal"))
                PrecioNormal = Convert.ToDecimal(row["PrecioNormal"]);
            if (DataRecord.HasColumn(row, "Stock"))
                Stock = Convert.ToInt32(row["Stock"]);
            if (DataRecord.HasColumn(row, "StockInicial"))
                StockInicial = Convert.ToInt32(row["StockInicial"]);
            if (DataRecord.HasColumn(row, "ImagenProducto"))
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas"))
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto"))
                FlagHabilitarProducto = Convert.ToInt32(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "DescripcionLegal"))
                DescripcionLegal = Convert.ToString(row["DescripcionLegal"]);
            if (DataRecord.HasColumn(row, "CategoriaID"))
                CategoriaID = Convert.ToString(row["CategoriaID"]);

            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "LinksFlexipago"))
                LinksFlexipago = Convert.ToString(row["LinksFlexipago"]);
            if (DataRecord.HasColumn(row, "MontoTotal"))
                MontoTotal = Convert.ToDecimal(row["MontoTotal"]);
            if (DataRecord.HasColumn(row, "MontoPagado"))
                MontoPagado = Convert.ToDecimal(row["MontoPagado"]);
            if (DataRecord.HasColumn(row, "MontoPorCuota"))
                MontoPorCuota = Convert.ToDecimal(row["MontoPorCuota"]);
            if (DataRecord.HasColumn(row, "InteresePorCuota"))
                InteresePorCuota = Convert.ToDecimal(row["InteresePorCuota"]);
            if (DataRecord.HasColumn(row, "CuotaPendCampaniaActual"))
                CuotaPendCampaniaActual = Convert.ToDecimal(row["CuotaPendCampaniaActual"]);
            if (DataRecord.HasColumn(row, "CuotaPendCampaniaSiguiente"))
                CuotaPendCampaniaSiguiente = Convert.ToDecimal(row["CuotaPendCampaniaSiguiente"]);
            if (DataRecord.HasColumn(row, "PedidoBase"))
                PedidoBase = Convert.ToDecimal(row["PedidoBase"]);
            if (DataRecord.HasColumn(row, "LineaCredito"))
                LineaCredito = Convert.ToDecimal(row["LineaCredito"]);
            if (DataRecord.HasColumn(row, "MontoMinimoFlexipago"))
                MontoMinimoFlexipago = Convert.ToDecimal(row["MontoMinimoFlexipago"]);
        }
    }
}
