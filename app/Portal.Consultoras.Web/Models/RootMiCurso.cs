using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class RootMiCurso
    {
        public List<MiCurso> Cursos { get; set; }
    }

    public class MiCurso
    {
        public string id { get; set; }
        public string nombre { get; set; }
        public string descripcion { get; set; }
        public string porcentaje_de_avance { get; set; }
        public string estado { get; set; }
        public string url { get; set; }
        public string imagen { get; set; }
        public string video { get; set; }
    }

}