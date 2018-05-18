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
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "CodigorRegion"))
                CodigorRegion = Convert.ToString(row["CodigorRegion"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "EstadoActividad"))
                EstadoActividad = Convert.ToString(row["EstadoActividad"]);
            if (DataRecord.HasColumn(row, "segmentoid"))
                segmentoid = Convert.ToInt32(row["segmentoid"]);
            if (DataRecord.HasColumn(row, "Segmento"))
                Segmento = Convert.ToString(row["Segmento"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento"))
                FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "EstadoCivil"))
                EstadoCivil = Convert.ToString(row["EstadoCivil"]);
            if (DataRecord.HasColumn(row, "KtiNueva"))
                KtiNueva = Convert.ToString(row["KtiNueva"]);
            if (DataRecord.HasColumn(row, "AutorizaPedido"))
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);
            if (DataRecord.HasColumn(row, "EMail"))
                EMail = Convert.ToString(row["EMail"]);
            if (DataRecord.HasColumn(row, "MontoUltimoPedido"))
                MontoUltimoPedido = Convert.ToDecimal(row["MontoUltimoPedido"]);
            if (DataRecord.HasColumn(row, "MontoFlexipago"))
                MontoFlexipago = Convert.ToDecimal(row["MontoFlexipago"]);
            if (DataRecord.HasColumn(row, "UltimaCampanaFacturada"))
                UltimaCampanaFacturada = Convert.ToInt32(row["UltimaCampanaFacturada"]);
            if (DataRecord.HasColumn(row, "MontoMaximoPedido"))
                MontoMaximoPedido = Convert.ToDecimal(row["MontoMaximoPedido"]);
            if (DataRecord.HasColumn(row, "MontoMinimoPedido"))
                MontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
            if (DataRecord.HasColumn(row, "FechaIngreso"))
                FechaIngreso = Convert.ToDateTime(row["FechaIngreso"]);
            if (DataRecord.HasColumn(row, "MontoSaldoActual"))
                MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);
            if (DataRecord.HasColumn(row, "PasePedidoWeb"))
                PasePedidoWeb = Convert.ToInt32(row["PasePedidoWeb"]);
            if (DataRecord.HasColumn(row, "TipoOferta2"))
                TipoOferta2 = Convert.ToInt32(row["TipoOferta2"]);
            if (DataRecord.HasColumn(row, "IndicadorDupla"))
                IndicadorDupla = Convert.ToInt32(row["IndicadorDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaEspecial"))
                CompraOfertaEspecial = Convert.ToInt32(row["CompraOfertaEspecial"]);
            if (DataRecord.HasColumn(row, "Simbolo"))
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "NombrePais"))
                NombrePais = Convert.ToString(row["NombrePais"]);
            if (DataRecord.HasColumn(row, "Telefono"))
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "Celular"))
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "CompraKitDupla"))
                CompraKitDupla = Convert.ToInt32(row["CompraKitDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaDupla"))
                CompraOfertaDupla = Convert.ToInt32(row["CompraOfertaDupla"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
        }
    }
}
