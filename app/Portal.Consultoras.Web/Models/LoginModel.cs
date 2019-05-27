using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class LoginModel
    {
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
        public string CodigoUsuario { get; set; }
        public string ClaveSecreta { get; set; }
        public IEnumerable<PaisModel> ListaPaises { get; set; }
        public List<EventoFestivoModel> ListaEventos { get; set; }
        public string NombreClase { get; set; }
        public string RutaEventoEsika { get; set; }
        public string RutaEventoLBel { get; set; }
        public string Salt { get; set; }
        public string Key { get; set; }
        public string Iv { get; set; }

        public UsuarioExternoModel UsuarioExterno { get; set; }

        public List<LoginAnalyticsModel> ListPaisAnalytics { get; set; }
    }

    public class ActualizaCelularModel
    {
        public int IsConfirmarCel { get; set; }
        public string Celular { get; set; }
        public int IniciaNumeroCelular { get; set; }
        public string UrlPdfTerminosyCondiciones { get; set; }
        public string IsoPais { get; set; }
    }

    public class ActualizaCorreoModel
    {
        public int IsConfirmar { get; set; }
        public string CorreoActual { get; set; }
        public string UrlPdfTerminosyCondiciones { get; set; }

    }

    public class ActualizarCorreoNuevoModel {
        public int CantidadEnvios { get; set; }
        public string CorreoActualizado { get; set; }
    }
}