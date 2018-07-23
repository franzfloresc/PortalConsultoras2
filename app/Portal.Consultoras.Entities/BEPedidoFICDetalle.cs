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
            CampaniaID = row.ToInt32("CampaniaID");
            PedidoID = row.ToInt32("PedidoID");
            PedidoDetalleID = row.ToInt16("PedidoDetalleID");
            MarcaID = row.ToByte("MarcaID");
            ConsultoraID = row.ToInt64("ConsultoraID");
            ClienteID = row.ToInt16("ClienteID");
            Cantidad = row.ToInt32("Cantidad");
            PrecioUnidad = row.ToDecimal("PrecioUnidad");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            CUV = row.ToString("CUV");
            DescripcionProd = row.ToString("DescripcionProd");
            Nombre = row.ToString("Nombre");
            eMail = row.ToString("eMail");
            OfertaWeb = row.ToBoolean("OfertaWeb");
            CUVPadre = row.ToString("CUVPadre");
            ModificaPedidoReservado = row.ToBoolean("ModificaPedidoReservado");
            Simbolo = row.ToString("Simbolo");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
        }

        public BEPedidoFICDetalle(IDataRecord row, string Consultora)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            PedidoID = row.ToInt32("PedidoID");
            PedidoDetalleID = row.ToInt16("PedidoDetalleID");
            MarcaID = row.ToByte("MarcaID");
            ConsultoraID = row.ToInt64("ConsultoraID");
            ClienteID = row.ToInt16("ClienteID");
            Cantidad = row.ToInt32("Cantidad");
            PrecioUnidad = row.ToDecimal("PrecioUnidad");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            CUV = row.ToString("CUV");
            DescripcionProd = row.ToString("DescripcionProd");
            Nombre = row.ToString("Nombre");
            eMail = row.ToString("eMail");
            OfertaWeb = row.ToBoolean("OfertaWeb");
            CUVPadre = row.ToString("CUVPadre");
            PedidoDetalleIDPadre = row.ToInt16("PedidoDetalleIDPadre");
            ModificaPedidoReservado = row.ToBoolean("ModificaPedidoReservado");
            Simbolo = row.ToString("Simbolo");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            IndicadorMontoMinimo = row.ToInt32("IndicadorMontoMinimo", 1);
        }
    }
}
