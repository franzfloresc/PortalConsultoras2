using System.Collections.Generic;

namespace Portal.Consultoras.Entities.OrdenYFiltros
{
    public class BEFiltro
    {
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
    }

    public class BEFiltroGrupo
    {
        public string NombreGrupo { get; set; }
        public bool Excluyente { get; set; }
        public List<BEFiltro> Opciones { get; set; }

        public BEFiltroGrupo()
        {
            NombreGrupo = string.Empty;
            Opciones = new List<BEFiltro>();
        }
    }
}