using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalInformativoModel
    {
        public bool EsSuscrita { get; set; }
        public int EstadoSuscripcion { get; set; }
        public string Video { get; set; }
        public string UrlTerminosCondiciones { get; set; }
        public string UrlPreguntasFrecuentes { get; set; }
        public string Origen { get; set; }
        public string NombreConsultora{ get; set; }
        public string Email{ get; set; }
        public string Celular { get; set; }
        public int LimiteMax { get; set; }
        public int LimiteMin { get; set; }
        public string UrlTerminosCondicionesDatosUsuario { get; set; }
        public string CampaniaX1 { get; set; }
        public bool MostrarCancelarSuscripcion { get; set; }
        public bool CancelarSuscripcion { get; set; }
        public bool EsSuscripcionInmediata { get; set; }
    }
}