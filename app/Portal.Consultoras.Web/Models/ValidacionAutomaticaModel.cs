using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ValidacionAutomaticaModel
    {
        public string FechaFacturacion { get; set; }
        public List<ValidacionAutomaticaDetalleModel> ListaValidacionAutomatica { get; set; }
    }
}