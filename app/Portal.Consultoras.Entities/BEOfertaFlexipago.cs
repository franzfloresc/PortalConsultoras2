using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
            if (DataRecord.HasColumn(row, "OfertaProductoID") && row["OfertaProductoID"] != DBNull.Value)
                OfertaProductoID = Convert.ToInt32(row["OfertaProductoID"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "NroOrden") && row["NroOrden"] != DBNull.Value)
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoCampania") && row["CodigoCampania"] != DBNull.Value)
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "TipoOferta") && row["TipoOferta"] != DBNull.Value)
                TipoOferta = Convert.ToString(row["TipoOferta"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta") && row["PrecioOferta"] != DBNull.Value)
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "PrecioNormal") && row["PrecioNormal"] != DBNull.Value)
                PrecioNormal = Convert.ToDecimal(row["PrecioNormal"]);
            if (DataRecord.HasColumn(row, "Stock") && row["Stock"] != DBNull.Value)
                Stock = Convert.ToInt32(row["Stock"]);
            if (DataRecord.HasColumn(row, "StockInicial") && row["StockInicial"] != DBNull.Value)
                StockInicial = Convert.ToInt32(row["StockInicial"]);
            if (DataRecord.HasColumn(row, "ImagenProducto") && row["ImagenProducto"] != DBNull.Value)
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "UnidadesPermitidas") && row["UnidadesPermitidas"] != DBNull.Value)
                UnidadesPermitidas = Convert.ToInt32(row["UnidadesPermitidas"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto") && row["FlagHabilitarProducto"] != DBNull.Value)
                FlagHabilitarProducto = Convert.ToInt32(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "CodigoProducto") && row["CodigoProducto"] != DBNull.Value)
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "DescripcionLegal") && row["DescripcionLegal"] != DBNull.Value)
                DescripcionLegal = Convert.ToString(row["DescripcionLegal"]);
            if (DataRecord.HasColumn(row, "CategoriaID") && row["CategoriaID"] != DBNull.Value)
                CategoriaID = Convert.ToString(row["CategoriaID"]);

            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "MarcaID") && row["MarcaID"] != DBNull.Value)
                MarcaID = Convert.ToInt32(row["MarcaID"]);

            if (DataRecord.HasColumn(row, "LinksFlexipago") && row["LinksFlexipago"] != DBNull.Value)
                LinksFlexipago = Convert.ToString(row["LinksFlexipago"]);
            if (DataRecord.HasColumn(row, "MontoTotal") && row["MontoTotal"] != DBNull.Value)
                MontoTotal = Convert.ToDecimal(row["MontoTotal"]);
            if (DataRecord.HasColumn(row, "MontoPagado") && row["MontoPagado"] != DBNull.Value)
                MontoPagado = Convert.ToDecimal(row["MontoPagado"]);
            if (DataRecord.HasColumn(row, "MontoPorCuota") && row["MontoPorCuota"] != DBNull.Value)
                MontoPorCuota = Convert.ToDecimal(row["MontoPorCuota"]);
            if (DataRecord.HasColumn(row, "InteresePorCuota") && row["InteresePorCuota"] != DBNull.Value)
                InteresePorCuota = Convert.ToDecimal(row["InteresePorCuota"]);
            if (DataRecord.HasColumn(row, "CuotaPendCampaniaActual") && row["CuotaPendCampaniaActual"] != DBNull.Value)
                CuotaPendCampaniaActual = Convert.ToDecimal(row["CuotaPendCampaniaActual"]);
            if (DataRecord.HasColumn(row, "CuotaPendCampaniaSiguiente") && row["CuotaPendCampaniaSiguiente"] != DBNull.Value)
                CuotaPendCampaniaSiguiente = Convert.ToDecimal(row["CuotaPendCampaniaSiguiente"]);
            if (DataRecord.HasColumn(row, "PedidoBase") && row["PedidoBase"] != DBNull.Value)
                PedidoBase = Convert.ToDecimal(row["PedidoBase"]);
            if (DataRecord.HasColumn(row, "LineaCredito") && row["LineaCredito"] != DBNull.Value)
                LineaCredito = Convert.ToDecimal(row["LineaCredito"]);
            if (DataRecord.HasColumn(row, "MontoMinimoFlexipago") && row["MontoMinimoFlexipago"] != DBNull.Value)
                MontoMinimoFlexipago = Convert.ToDecimal(row["MontoMinimoFlexipago"]);
        }
    }
}
