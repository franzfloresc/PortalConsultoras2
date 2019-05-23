using System.Collections.Generic;

namespace Portal.Consultoras.Entities.OrdenYFiltros
{
    public class BEOrdenFiltroConfiguracion
    {
        public List<BEOrdenGrupo> Ordenamientos { get; set; }
        public List<BEFiltroGrupo> Filtros { get; set; }

        public BEOrdenFiltroConfiguracion()
        {
            Ordenamientos = new List<BEOrdenGrupo>();
            Filtros = new List<BEFiltroGrupo>();
        }
    }
}
