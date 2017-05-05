using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioConfiguracion
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        [DataMember]
        public int TieneHana { get; set; }

        [DataMember]
        public string Simbolo { get; set; }

        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; }

        [DataMember]
        public double ZonaHoraria { get; set; }

        [DataMember]
        public bool PROLSinStock { get; set; }

        [DataMember]
        public bool NuevoPROL { get; set; }

        [DataMember]
        public bool ZonaNuevoPROL { get; set; }

        [DataMember]
        public bool ZonaValida { get; set; }

        [DataMember]
        public int DiasAntes { get; set; }

        [DataMember]
        public TimeSpan HoraInicio { get; set; }

        [DataMember]
        public TimeSpan HoraFin { get; set; }

        [DataMember]
        public TimeSpan HoraInicioNoFacturable { get; set; }

        [DataMember]
        public TimeSpan HoraCierreNoFacturable { get; set; }

        [DataMember]
        public bool ValidacionInteractiva { get; set; }

        [DataMember]
        public bool HabilitarRestriccionHoraria { get; set; }

        [DataMember]
        public int HorasDuracionRestriccion { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public string PrimerNombre { get; set; }

        [DataMember]
        public decimal MontoMinimoPedido { get; set; }

        [DataMember]
        public decimal MontoMaximoPedido { get; set; }

        [DataMember]
        public int ConsultoraNueva { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string NombreCompleto { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public int UsuarioPrueba { get; set; }

        [DataMember]
        public int RegionID { get; set; }

        [DataMember]
        public string CodigorRegion { get; set; }

        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public string CodigoZona { get; set; }

        [DataMember]
        public long ConsultoraAsociadoID { get; set; }

        [DataMember]
        public string ConsultoraAsociada { get; set; }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }

        [DataMember]
        public TimeSpan HoraCierreZonaNormal { get; set; }

        [DataMember]
        public TimeSpan HoraCierreZonaDemAnti { get; set; }

        [DataMember]
        public int EsZonaDemAnti { get; set; }

        [DataMember]
        public Int16 TipoUsuario { get; set; }
    }
}
