using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class AdministrarHistorialDetaUpdModel
    {
        public int IdContenidoDeta { get; set; }
        public int IdContenido { get; set; }
        public string RutaImagen { get; set; }
    }

}