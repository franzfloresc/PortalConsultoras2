using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalModel
    {
        public RevistaDigitalModel()
        {
            SuscripcionModel = new RevistaDigitalSuscripcionModel();
        }

        public int Activo { get; set; }
        public int EstadoSuscripcion { get; set; }
        public bool NoVolverMostrar { get; set; }

        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
    }
}