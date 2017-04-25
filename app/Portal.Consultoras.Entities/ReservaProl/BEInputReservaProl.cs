using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ReservaProl
{
    [DataContract]
    public class BEInputReservaProl
    {
        [DataMember]
        public string PaisISO { get; set; } //Parametro
        [DataMember]
        public int PaisID { get; set; } //Util.GetPais
        [DataMember]
        public string Simbolo { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public int CampaniaID { get; set; } //Parametro
        [DataMember]
        public DateTime FechaFacturacion { get; set; } //DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes) ? oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes) : oBEUsuario.FechaFinFacturacion;        
        [DataMember]
        public long ConsultoraID { get; set; } //Parametro
        [DataMember]
        public string CodigoUsuario { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public string CodigoConsultora { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public string NombreConsultora { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public string PrimerNombre { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public string Email { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public string CodigoZona { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public DateTime FechaInicioCampania { get; set; } //FechaInicioCampania: SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public double ZonaHoraria { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public bool PROLSinStock { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public decimal MontoMinimo { get; set; } // MontoMinimoPedido o Hana
        [DataMember]
        public decimal MontoMaximo { get; set; } // MontoMaximoPedido o Hana
        [DataMember]
        public int ConsultoraNueva { get; set; } //SP GetConfiguracionByUsuarioAndCampania
        [DataMember]
        public bool ValidacionAbierta { get; set; } //GetEstadoPedido
        [DataMember]
        public bool FechaHoraReserva { get; set; } //SP GetConfiguracionByUsuarioAndCampania.DiasAntes
        [DataMember]
        public bool ProlV2 { get; set; }        
        [DataMember]
        public bool ZonaProlActiva { get; set; }
        [DataMember]
        public bool EsMovil { get; set; }

        public int PedidoID { get; set; }
    }
}
