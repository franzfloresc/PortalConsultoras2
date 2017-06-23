using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class MensajeProductoBloqueadoModel
    {
        public bool MensajeIconoSuperior { get; set; }
        public bool BtnInscribirse { get; set; }
        public string MensajeTitulo { get; set; }
    }
}