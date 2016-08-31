using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "CodigoZona") && row["CodigoZona"] != DBNull.Value)
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "CodigorRegion") && row["CodigorRegion"] != DBNull.Value)
                CodigorRegion = Convert.ToString(row["CodigorRegion"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "EstadoActividad") && row["EstadoActividad"] != DBNull.Value)
                EstadoActividad = Convert.ToString(row["EstadoActividad"]);
            if (DataRecord.HasColumn(row, "segmentoid") && row["segmentoid"] != DBNull.Value)
                segmentoid = Convert.ToInt32(row["segmentoid"]);
            if (DataRecord.HasColumn(row, "Segmento") && row["Segmento"] != DBNull.Value)
                Segmento = Convert.ToString(row["Segmento"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento") && row["FechaNacimiento"] != DBNull.Value)
                FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "EstadoCivil") && row["EstadoCivil"] != DBNull.Value)
                EstadoCivil = Convert.ToString(row["EstadoCivil"]);
            if (DataRecord.HasColumn(row, "KtiNueva") && row["KtiNueva"] != DBNull.Value)
                KtiNueva = Convert.ToString(row["KtiNueva"]);
            if (DataRecord.HasColumn(row, "AutorizaPedido") && row["AutorizaPedido"] != DBNull.Value)
                AutorizaPedido = Convert.ToString(row["AutorizaPedido"]);
            if (DataRecord.HasColumn(row, "EMail") && row["EMail"] != DBNull.Value)
                EMail = Convert.ToString(row["EMail"]);
            if (DataRecord.HasColumn(row, "MontoUltimoPedido") && row["MontoUltimoPedido"] != DBNull.Value)
                MontoUltimoPedido = Convert.ToDecimal(row["MontoUltimoPedido"]);
            if (DataRecord.HasColumn(row, "MontoFlexipago") && row["MontoFlexipago"] != DBNull.Value)
                MontoFlexipago = Convert.ToDecimal(row["MontoFlexipago"]);
            if (DataRecord.HasColumn(row, "UltimaCampanaFacturada") && row["UltimaCampanaFacturada"] != DBNull.Value)
                UltimaCampanaFacturada = Convert.ToInt32(row["UltimaCampanaFacturada"]);
            if (DataRecord.HasColumn(row, "MontoMaximoPedido") && row["MontoMaximoPedido"] != DBNull.Value)
                MontoMaximoPedido = Convert.ToDecimal(row["MontoMaximoPedido"]);
            if (DataRecord.HasColumn(row, "MontoMinimoPedido") && row["MontoMinimoPedido"] != DBNull.Value)
                MontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
            if (DataRecord.HasColumn(row, "FechaIngreso") && row["FechaIngreso"] != DBNull.Value)
                FechaIngreso = Convert.ToDateTime(row["FechaIngreso"]);
            if (DataRecord.HasColumn(row, "MontoSaldoActual") && row["MontoSaldoActual"] != DBNull.Value)
                MontoSaldoActual = Convert.ToDecimal(row["MontoSaldoActual"]);
            if (DataRecord.HasColumn(row, "PasePedidoWeb") && row["PasePedidoWeb"] != DBNull.Value)
                PasePedidoWeb = Convert.ToInt32(row["PasePedidoWeb"]);
            if (DataRecord.HasColumn(row, "TipoOferta2") && row["TipoOferta2"] != DBNull.Value)
                TipoOferta2 = Convert.ToInt32(row["TipoOferta2"]);
            if (DataRecord.HasColumn(row, "IndicadorDupla") && row["IndicadorDupla"] != DBNull.Value)
                IndicadorDupla = Convert.ToInt32(row["IndicadorDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaEspecial") && row["CompraOfertaEspecial"] != DBNull.Value)
                CompraOfertaEspecial = Convert.ToInt32(row["CompraOfertaEspecial"]);
            if (DataRecord.HasColumn(row, "Simbolo") && row["Simbolo"] != DBNull.Value)
                Simbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "NombrePais") && row["NombrePais"] != DBNull.Value)
                NombrePais = Convert.ToString(row["NombrePais"]);
            if (DataRecord.HasColumn(row, "Telefono") && row["Telefono"] != DBNull.Value)
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "CompraKitDupla") && row["CompraKitDupla"] != DBNull.Value)
                CompraKitDupla = Convert.ToInt32(row["CompraKitDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaDupla") && row["CompraOfertaDupla"] != DBNull.Value)
                CompraOfertaDupla = Convert.ToInt32(row["CompraOfertaDupla"]);
            if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                Campania = Convert.ToString(row["Campania"]);
        }
    }
}
