using Portal.Consultoras.Web.ServiceZonificacion;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ServicioModel
    {
        public int ServicioId { get; set; }
        public string Descripcion { get; set; }
        public string Url { get; set; }
        public int ParametroId { get; set; }
        public IEnumerable<ParametroModel> listaParametros { get; set; }
        public List<BECampania> DropDownListCampania { get; set; }
        public string NombreCorto { get; set; }
    }
}