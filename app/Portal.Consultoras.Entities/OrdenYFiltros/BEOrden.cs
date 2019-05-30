using System.Collections.Generic;

namespace Portal.Consultoras.Entities.OrdenYFiltros
{
    public class BEOrden
    {
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }

    public class BEOrdenGrupo
    {        
        public string NombreGrupo { get; set; }
        public List<BEOrden> Opciones { get; set; }

        public BEOrdenGrupo()
        {
            NombreGrupo = string.Empty;
            Opciones = new List<BEOrden>();
        }
    }
}