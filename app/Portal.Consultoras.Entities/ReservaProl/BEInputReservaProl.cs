using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ReservaProl
{
    [DataContract]
    public class BEInputReservaProl
    {
        [DataMember]
        public string PaisISO { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public DateTime FechaFacturacion { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreConsultora { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public DateTime FechaInicioCampania { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
        [DataMember]
        public decimal MontoMinimo { get; set; }
        [DataMember]
        public decimal MontoMaximo { get; set; }
        [DataMember]
        public int ConsultoraNueva { get; set; }
        [DataMember]
        public bool ValidacionAbierta { get; set; }
        [DataMember]
        public bool FechaHoraReserva { get; set; }
        [DataMember]
        public bool ProlV2 { get; set; }
        public byte VersionProl { get; set; }
        [DataMember]
        public bool ZonaValida { get; set; }
        [DataMember]
        public bool ValidacionInteractiva { get; set; }
        [DataMember]
        public bool EnviarCorreo { get; set; }
        [DataMember]
        public string Sobrenombre { get; set; }
        [DataMember]
        public string CodigosConcursos { get; set; }
        public bool ZonaProlActiva { get { return ZonaValida && ValidacionInteractiva; } }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public int SegmentoInternoID { get; set; }
        [DataMember]
        public int EsOpt { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int ConsecutivoNueva { get; set; }
    }
}
