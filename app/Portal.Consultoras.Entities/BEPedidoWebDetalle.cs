using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebDetalle
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
        public string DescripcionCortadaProd { get; set; }
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
        [DataMember]
        public string CodigoUsuarioCreacion { get; set; }
        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }
        [DataMember]
        public int SubTipoOfertaSisID { get; set; }
        [DataMember]
        public string TipoPedido { get; set; }
        [DataMember]
        public string DescripcionOferta { get; set; }
        [DataMember]
        public string ObservacionPROL { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public string DescripcionLarga { get; set; }
        [DataMember]
        public string Categoria { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }

        [DataMember]
        public bool IndicadorOfertaCUV { get; set; }
        [DataMember]
        public decimal MontoTotalProl { get; set; }

        [DataMember]
        public string NombreCliente { get; set; }

        [DataMember]
        public bool EsSugerido { get; set; }

        [DataMember]
        public bool EsKitNueva { get; set; }

        [DataMember]
        public int OrdenPedidoWD { get; set; }

        [DataMember]
        public decimal DescuentoProl { get; set; }
        [DataMember]
        public bool FlagConsultoraOnline { get; set; }

        [DataMember]
        public decimal MontoEscala { get; set; }
        [DataMember]
        public decimal MontoAhorroCatalogo { get; set; }
        [DataMember]
        public decimal MontoAhorroRevista { get; set; }
        [DataMember]
        public int OrigenPedidoWeb { get; set; }
        [DataMember]
        public bool EsBackOrder { get; set; }
        [DataMember]
        public bool AceptoBackOrder { get; set; }
        [DataMember]
        public bool EsCompraPorCompra { get; set; }

        [DataMember]
        public BEIndicadorPedidoAutentico IndicadorPedidoAutentico { get; set; }

        [DataMember]
        public int CodigoCatalago { get; set; }

        [DataMember]
        public bool EsOfertaIndependiente { get; set; }

        [DataMember]
        public string TipoEstrategiaCodigo { get; set; }

        [DataMember]
        public bool FlagNueva { get; set; }

        [DataMember]
        public bool ProgramaNuevoActivado { get; set; }

        [DataMember]
        public string CodigoTipoOferta { get; set; }

        [DataMember]
        public int SetID { get; set; }

        public BEPedidoWebDetalle()
        { }

        public BEPedidoWebDetalle(IDataRecord row)
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
            SubTipoOfertaSisID = row.ToInt32("SubTipoOfertaSisID");
            TipoPedido = row.ToString("TipoPedido");
            DescripcionOferta = row.ToString("DescripcionOferta");
            DescripcionLarga = row.ToString("DescripcionLarga");
            Categoria = row.ToString("Categoria");
            DescripcionEstrategia = row.ToString("DescripcionEstrategia");
            TipoEstrategiaID = row.ToInt32("TipoEstrategiaID");
            IndicadorOfertaCUV = row.ToBoolean("IndicadorOfertaCUV");
            MontoTotalProl = row.ToDecimal("MontoTotalProl");
            NombreCliente = row.ToString("NombreCliente");
            EsSugerido = row.ToBoolean("EsSugerido");
            EsKitNueva = row.ToBoolean("EsKitNueva");
            OrdenPedidoWD = row.ToInt32("OrdenPedidoWD");
            DescuentoProl = row.ToDecimal("DescuentoProl");
            FlagConsultoraOnline = row.ToBoolean("FlagConsultoraOnline");
            MontoEscala = row.ToDecimal("MontoEscala");
            MontoAhorroCatalogo = row.ToDecimal("MontoAhorroCatalogo");
            MontoAhorroRevista = row.ToDecimal("MontoAhorroRevista");
            OrigenPedidoWeb = row.ToInt32("OrigenPedidoWeb");
            EsBackOrder = row.ToBoolean("EsBackOrder");
            AceptoBackOrder = row.ToBoolean("AceptoBackOrder");
            EsCompraPorCompra = row.ToBoolean("EsCompraPorCompra");
            CodigoCatalago = row.ToInt32("CodigoCatalago");
            EsOfertaIndependiente = row.ToBoolean("EsOfertaIndependiente");
            TipoEstrategiaCodigo = row.ToString("TipoEstrategiaCodigo");
            FlagNueva = row.ToBoolean("FlagNueva");
            ProgramaNuevoActivado = row.ToBoolean("ProgramaNuevoActivado");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            SetID = row.ToInt32("SetID");
        }

        public BEPedidoWebDetalle(IDataRecord row, string Consultora)
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
            NombreCliente = row.ToString("Nombre");
            eMail = row.ToString("eMail");
            OfertaWeb = row.ToBoolean("OfertaWeb");
            CUVPadre = row.ToString("CUVPadre");
            PedidoDetalleIDPadre = row.ToInt16("PedidoDetalleIDPadre");
            ModificaPedidoReservado = row.ToBoolean("ModificaPedidoReservado");
            Simbolo = row.ToString("Simbolo");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo")) IndicadorMontoMinimo = Convert.ToInt32(row["IndicadorMontoMinimo"]);
            else IndicadorMontoMinimo = 1;
            SubTipoOfertaSisID = row.ToInt32("SubTipoOfertaSisID");
            TipoPedido = row.ToString("TipoPedido");
            DescripcionOferta = row.ToString("DescripcionOferta");
            ObservacionPROL = row.ToString("ObservacionPROL");
            DescripcionLarga = row.ToString("DescripcionLarga");
            Categoria = row.ToString("Categoria");
            DescripcionEstrategia = row.ToString("DescripcionEstrategia");
            TipoEstrategiaID = row.ToInt32("TipoEstrategiaID");
            IndicadorOfertaCUV = row.ToBoolean("IndicadorOfertaCUV");
            MontoTotalProl = row.ToDecimal("MontoTotalProl");
            NombreCliente = row.ToString("NombreCliente");
            EsSugerido = row.ToBoolean("EsSugerido");
            EsKitNueva = row.ToBoolean("EsKitNueva");
            OrdenPedidoWD = row.ToInt32("OrdenPedidoWD");
            DescuentoProl = row.ToDecimal("DescuentoProl");
            FlagConsultoraOnline = row.ToBoolean("FlagConsultoraOnline");
            MontoEscala = row.ToDecimal("MontoEscala");
            MontoAhorroCatalogo = row.ToDecimal("MontoAhorroCatalogo");
            MontoAhorroRevista = row.ToDecimal("MontoAhorroRevista");
            OrigenPedidoWeb = row.ToInt32("OrigenPedidoWeb");
            EsBackOrder = row.ToBoolean("EsBackOrder");
            AceptoBackOrder = row.ToBoolean("AceptoBackOrder");
            EsCompraPorCompra = row.ToBoolean("EsCompraPorCompra");
            CodigoCatalago = row.ToInt32("CodigoCatalago");
            EsOfertaIndependiente = row.ToBoolean("EsOfertaIndependiente");
            TipoEstrategiaCodigo = row.ToString("TipoEstrategiaCodigo");
            FlagNueva = row.ToBoolean("FlagNueva");
            ProgramaNuevoActivado = row.ToBoolean("ProgramaNuevoActivado");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            SetID = row.ToInt32("SetID");
        }
    }

}
