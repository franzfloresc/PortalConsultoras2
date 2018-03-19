using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class SolicitudClienteModel : SolicitudClienteConsultoraModel
    {
        public IEnumerable<CampaniaModel> listaCampania { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public Dictionary<int, string> listaMarcas { get; set; }
        public List<BESolicitudClienteDetalle> listaDetalle { get; set; }
        public List<BEEstadoSolicitudCliente> listaEstadoSolicitudCliente { get; set; }
        public string UnidadGeografica1 { get; set; }
        public string UnidadGeografica2 { get; set; }
        public string UnidadGeografica3 { get; set; }
        public int TipoDistribucion { get; set; }
        public string Seccion { get; set; }
        public string NombreConsultoraAsignada { get; set; }
        public string CorreoConsultoraAsginada { get; set; }
        public string NombreGZ { get; set; }
        public string EmailGZ { get; set; }
        public string MensajeaGZ { get; set; }
        public int PaisID { get; set; }
        public string Direccion { get; set; }
        public int EstadoSolicitudClienteID { get; set; }
        public string Paginacion { get; set; }
    }
}