using System.Collections.Generic;
namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class MisLogrosCaminoBrillanteModel
    {
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public List<Indicador> Indicador { get; set; }
    }
}