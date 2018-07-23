using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraDatos
    {
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string CodigorRegion { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public string EstadoActividad { get; set; }
        [DataMember]
        public int segmentoid { get; set; }
        [DataMember]
        public string Segmento { get; set; }
        [DataMember]
        public DateTime FechaNacimiento { get; set; }
        [DataMember]
        public string EstadoCivil { get; set; }
        [DataMember]
        public string KtiNueva { get; set; }
        [DataMember]
        public string AutorizaPedido { get; set; }
        [DataMember]
        public string EMail { get; set; }
        [DataMember]
        public decimal MontoUltimoPedido { get; set; }
        [DataMember]
        public decimal MontoFlexipago { get; set; }
        [DataMember]
        public int UltimaCampanaFacturada { get; set; }
        [DataMember]
        public decimal MontoMaximoPedido { get; set; }
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }
        [DataMember]
        public DateTime FechaIngreso { get; set; }
        [DataMember]
        public decimal MontoSaldoActual { get; set; }
        [DataMember]
        public int PasePedidoWeb { get; set; }
        [DataMember]
        public int TipoOferta2 { get; set; }
        [DataMember]
        public int IndicadorDupla { get; set; }
        [DataMember]
        public int CompraOfertaEspecial { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public string NombrePais { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Celular { get; set; }
        [DataMember]
        public int CompraKitDupla { get; set; }
        [DataMember]
        public int CompraOfertaDupla { get; set; }
        [DataMember]
        public string Campania { get; set; }

        public BEConsultoraDatos()
        {

        }

        public BEConsultoraDatos(IDataRecord row)
        {
            CodigoConsultora = row.ToString("CodigoConsultora");
            NombreCompleto = row.ToString("NombreCompleto");
            CodigoZona = row.ToString("CodigoZona");
            CodigorRegion = row.ToString("CodigorRegion");
            IdEstadoActividad = row.ToInt32("IdEstadoActividad");
            EstadoActividad = row.ToString("EstadoActividad");
            segmentoid = row.ToInt32("segmentoid");
            Segmento = row.ToString("Segmento");
            FechaNacimiento = row.ToDateTime("FechaNacimiento");
            EstadoCivil = row.ToString("EstadoCivil");
            KtiNueva = row.ToString("KtiNueva");
            AutorizaPedido = row.ToString("AutorizaPedido");
            EMail = row.ToString("EMail");
            MontoUltimoPedido = row.ToDecimal("MontoUltimoPedido");
            MontoFlexipago = row.ToDecimal("MontoFlexipago");
            UltimaCampanaFacturada = row.ToInt32("UltimaCampanaFacturada");
            MontoMaximoPedido = row.ToDecimal("MontoMaximoPedido");
            MontoMinimoPedido = row.ToDecimal("MontoMinimoPedido");
            FechaIngreso = row.ToDateTime("FechaIngreso");
            MontoSaldoActual = row.ToDecimal("MontoSaldoActual");
            PasePedidoWeb = row.ToInt32("PasePedidoWeb");
            TipoOferta2 = row.ToInt32("TipoOferta2");
            IndicadorDupla = row.ToInt32("IndicadorDupla");
            CompraOfertaEspecial = row.ToInt32("CompraOfertaEspecial");
            Simbolo = row.ToString("Simbolo");
            NombrePais = row.ToString("NombrePais");
            Telefono = row.ToString("Telefono");
            Celular = row.ToString("Celular");
            CompraKitDupla = row.ToInt32("CompraKitDupla");
            CompraOfertaDupla = row.ToInt32("CompraOfertaDupla");
            Campania = row.ToString("Campania");
        }
    }
}
