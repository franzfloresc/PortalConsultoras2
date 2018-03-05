using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class PaisModel
    {
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
        public string Nombre { get; set; }
        public string NombreCorto { get; set; }
        public string NombreInterno { get; set; }        
        public string NombreCambioClave { get; set; }
        public string Telefonos { get; set; }
        public string Mensajes { get; set; }
    }
}