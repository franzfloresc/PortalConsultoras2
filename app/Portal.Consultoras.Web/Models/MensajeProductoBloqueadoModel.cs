using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class MensajeProductoBloqueadoModel
    {
        public MensajeProductoBloqueadoModel()
        {
            MensajeTieneDudas = true;
        }
        public string divId { get; set; }
        public bool MensajeIconoSuperior { get; set; }
        public bool BtnInscribirse { get; set; }
        public string MensajeTitulo { get; set; }
        public bool IsMobile { get; set; }
        public bool MensajeTieneDudas { get; set; }
    }
}