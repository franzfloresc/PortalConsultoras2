using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ParticipantesDemandaAnticipadaModel
    {
        public int PaisID { get; set; }
        public int ConfiguracionConsultoraDAID { get; set; }
        public IEnumerable<CampaniaModel> listaCampania { get; set; }
        public string CodigoZona { get; set; }
        public int ConsultoraID { get; set; }
        public string CodigoConsultora { get; set; }
        public string NombreCompleto { get; set; }
        public bool TipoConfiguracion { get; set; }
        public decimal ImporteTotal { get; set; }
        public DateTime Fecha { get; set; }
        public DateTime FechaModificada { get; set; }
        public string CodigoUsuario { get; set; }
    }
}