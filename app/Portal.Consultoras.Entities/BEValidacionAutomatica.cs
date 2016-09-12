using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

// R2073 - Toda la clase
namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEValidacionAutomatica
    {
        [DataMember]
        public DateTime FechaHoraInicio { get; set; }
        [DataMember]
        public DateTime FechaHoraFin { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public string DescripcionEstado { get; set; }
        [DataMember]
        public bool EnvioCorreo { get; set; }
        [DataMember]
        public DateTime FechaHoraInicioEnvio { get; set; }
        [DataMember]
        public DateTime FechaHoraFinEnvio { get; set; }

        public BEValidacionAutomatica()
        { 
        
        }

        public BEValidacionAutomatica(IDataRecord row)
        {
            FechaHoraInicio = Convert.ToDateTime(row["FechaHoraInicio"]);
            FechaHoraFin = Convert.ToDateTime(row["FechaHoraFin"]);
            Estado = Convert.ToInt32(row["Estado"]);
            DescripcionEstado = Convert.ToString(row["DescripcionEstado"]);
            EnvioCorreo = Convert.ToBoolean(row["EnvioCorreo"]);
            FechaHoraInicioEnvio = Convert.ToDateTime(row["FechaHoraInicioEnvio"]);
            FechaHoraFinEnvio = Convert.ToDateTime(row["FechaHoraFinEnvio"]);
        }
    }

    [DataContract]
    public class BEValidacionMovil
    {
        [DataMember]
        public long ValidacionMovilPROLLogId { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public int PedidoId { get; set; }
        [DataMember]
        public long ConsultoraId { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public int NumeroItemsEnviados { get; set; }
        [DataMember]
        public decimal MontoMaximoPedido { get; set; }
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }
        [DataMember]
        public int EstadoActividad { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public DateTime FechaHoraRegistro { get; set; }
        [DataMember]
        public DateTime FechaHoraFin { get; set; }
        [DataMember]
        public DateTime FechaHoraValidacion { get; set; }
        [DataMember]
        public string EstadoPROL { get; set; }
        [DataMember]
        public string Observaciones { get; set; }
        [DataMember]
        public string Error { get; set; }
        [DataMember]
        public DateTime FechaFacturacion { get; set; }
        [DataMember]
        public int PaisId { get; set; }
        [DataMember]
        public bool EsMontoMinimo { get; set; }
        [DataMember]
        public decimal MontoTotalProl { get; set; }
        [DataMember]
        public decimal DescuentoProl { get; set; }

        public BEValidacionMovil()
        { }

        public BEValidacionMovil(IDataRecord row)
        {
            ValidacionMovilPROLLogId = Convert.ToInt64(row["ValidacionMovilPROLLogId"]);
            CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            MontoMaximoPedido = Convert.ToDecimal(row["MontoMaximoPedido"]);
            MontoMinimoPedido = row.IsDBNull(row.GetOrdinal("MontoMinimoPedido")) ? 0 : Convert.ToDecimal(row["MontoMinimoPedido"]);
            EstadoActividad = Convert.ToInt32(row["EstadoActividad"]);
            CodigoZona = Convert.ToString(row["CodigoZona"]);
        }
    }

    [DataContract]
    public class BEAccionesPROL
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public int PedidoDetalleID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnidad { get; set; }
        [DataMember]
        public int Tipo { get; set; }
        [DataMember]
        public int Accion { get; set; }
        [DataMember]
        public string MensajePROL { get; set; }
        [DataMember]
        public long ValAutomaticaPROLLogId { get; set; }
        [DataMember]
        public string CodigoObservacion { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
    }
}
