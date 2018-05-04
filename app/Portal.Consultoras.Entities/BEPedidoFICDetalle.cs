using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoFICDetalle
    {
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public int PedidoID { set; get; }
        [DataMember]
        public Int16 PedidoDetalleID { set; get; }
        [DataMember]
        public Int16 PedidoDetalleIDPadre { set; get; }
        [DataMember]
        public byte MarcaID { set; get; }
        [DataMember]
        public long ConsultoraID { set; get; }
        [DataMember]
        public Int16 ClienteID { set; get; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnidad { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionProd { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string eMail { get; set; }
        [DataMember]
        public bool OfertaWeb { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string ClaseFila { get; set; }
        [DataMember]
        public int TipoObservacion { get; set; }
        [DataMember]
        public string CUVPadre { get; set; }
        [DataMember]
        public bool ModificaPedidoReservado { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public int Clientes { get; set; }
        [DataMember]
        public decimal ImporteTotalPedido { get; set; }
        [DataMember]
        public short EstadoItem { get; set; }
        [DataMember]
        public bool CUVNuevo { get; set; }
        [DataMember]
        public bool EliminadoTemporal { get; set; }
        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int CantidadAnterior { set; get; }
        [DataMember]
        public int Flag { set; get; }
        [DataMember]
        public int Stock { set; get; }
        [DataMember]
        public int IndicadorMontoMinimo { get; set; }
        [DataMember]
        public string IPUsuario { get; set; }

        public BEPedidoFICDetalle()
        { }

        public BEPedidoFICDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleID"))
                PedidoDetalleID = Convert.ToInt16(row["PedidoDetalleID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToByte(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "ClienteID"))
                ClienteID = row["ClienteID"] == DBNull.Value ? (short)0 : Convert.ToInt16(row["ClienteID"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnidad"))
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "DescripcionProd"))
                DescripcionProd = Convert.ToString(row["DescripcionProd"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "eMail"))
                eMail = Convert.ToString(row["eMail"]);
            if (DataRecord.HasColumn(row, "OfertaWeb"))
                OfertaWeb = Convert.ToBoolean(row["OfertaWeb"]);
            if (DataRecord.HasColumn(row, "CUVPadre"))
                CUVPadre = Convert.ToString(row["CUVPadre"]);
            if (DataRecord.HasColumn(row, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(row["ModificaPedidoReservado"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
        }

        public BEPedidoFICDetalle(IDataRecord row, string Consultora)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleID"))
                PedidoDetalleID = Convert.ToInt16(row["PedidoDetalleID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToByte(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "ClienteID"))
                ClienteID = row["ClienteID"] == DBNull.Value ? (short)0 : Convert.ToInt16(row["ClienteID"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnidad"))
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "DescripcionProd"))
                DescripcionProd = Convert.ToString(row["DescripcionProd"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = row["Nombre"] == DBNull.Value ? Consultora : Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "eMail"))
                eMail = Convert.ToString(row["eMail"]);
            if (DataRecord.HasColumn(row, "OfertaWeb"))
                OfertaWeb = Convert.ToBoolean(row["OfertaWeb"]);
            if (DataRecord.HasColumn(row, "CUVPadre"))
                CUVPadre = Convert.ToString(row["CUVPadre"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleIDPadre"))
                PedidoDetalleIDPadre = row["PedidoDetalleIDPadre"] == DBNull.Value ? (short)0 : Convert.ToInt16(row["PedidoDetalleIDPadre"]);
            if (DataRecord.HasColumn(row, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(row["ModificaPedidoReservado"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo"))
                IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            else
                IndicadorMontoMinimo = 1;
        }
    }
}
