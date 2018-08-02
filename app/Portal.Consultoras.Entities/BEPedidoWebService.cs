using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebService
    {
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string ConsultoraNombre { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public string UsuarioResponsable { get; set; }
        [DataMember]
        public decimal ConsultoraSaldo { get; set; }
        [DataMember]
        public string EstadoValidacion { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public decimal PrecioTotal { get; set; }
        [DataMember]
        public string ZonaCodigo { get; set; }
        [DataMember]
        public string Origen { get; set; }
        [DataMember]
        public int NroRegistro { get; set; }
        [DataMember]
        public decimal ImporteTotalMM { get; set; }
        [DataMember]
        public int DigitoVerificador { get; set; }
        [DataMember]
        public string EstadoConsultora { get; set; }
        [DataMember]
        public string AutorizaPedido { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public bool Bloqueado { get; set; }
        [DataMember]
        public string DescripcionBloqueo { get; set; }
        [DataMember]
        public string Territorio { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Segmento { get; set; }
        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }
        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }
        [DataMember]
        public string CodigoProducto { get; set; }
        [DataMember]
        public string CodigoTipoOferta { get; set; }
        [DataMember]
        public int PedidoWebID { get; set; }
        [DataMember]
        public int PedidoWebDetalleID { get; set; }

        public BEPedidoWebService(IDataRecord row)
        {
            NroRegistro = row.ToInt32("NroRegistro");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            Campania = row.ToInt32("Campania");
            PedidoWebID = row.ToInt32("PedidoID");
            PedidoWebDetalleID = row.ToInt32("PedidoWebDetalleID");
            Seccion = row.ToString("Seccion");
            CodigoConsultora = row.ToString("CodigoConsultora");
            ConsultoraNombre = row.ToString("ConsultoraNombre");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            UsuarioResponsable = row.ToString("UsuarioResponsable");
            ConsultoraSaldo = row.ToDecimal("ConsultoraSaldo");
            EstadoValidacion = row.ToString("EstadoValidacion");
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
            Descripcion = row.ToString("Descripcion");
            Cantidad = row.ToInt32("Cantidad");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            PrecioTotal = row.ToDecimal("PrecioTotal");
            ZonaCodigo = row.ToString("ZonaCodigo");
            ImporteTotalMM = row.ToDecimal("ImporteTotalMM");
            DigitoVerificador = row.ToInt32("DigitoVerificador");
            EstadoConsultora = row.ToString("EstadoConsultora");
            AutorizaPedido = row.ToString("AutorizaPedido");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            Bloqueado = row.ToBoolean("Bloqueado");
            DescripcionBloqueo = row.ToString("DescripcionBloqueo");
            Territorio = row.ToString("Territorio");
            Direccion = row.ToString("Direccion");
            Telefono = row.ToString("Telefono");
            Segmento = row.ToString("Segmento");
            FechaInicioFacturacion = row.ToDateTime("FechaInicioFacturacion");
            FechaFinFacturacion = row.ToDateTime("FechaFinFacturacion");
            CodigoProducto = row.ToString("CodigoProducto");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            Origen = row.ToString("Origen");
        }
    }
}
