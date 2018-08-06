using Portal.Consultoras.Common;
using System;
using System.Data;

namespace Portal.Consultoras.Entities
{
    public class BEConsultoraEmail
    {
        public string NombreCompleto { get; set; }
        public string Codigo { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }
        public string CodigoZona { get; set; }
        public string GerenteZonaNombre { get; set; }
        public string GerenteZonaEmail { get; set; }
        public bool EsPostulante { get; set; }
        public string CodigoUsuario { get; set; }
        public string Clave { get; set; }

        public BEConsultoraEmail(IDataRecord row)
        {
            CodigoUsuario = row.ToString("CodigoUsuario");
            Codigo = row.ToString("CodigoConsultora");
            NombreCompleto = row.ToString("Nombre");
            Email = row.ToString("Email");
            CodigoZona = row.ToString("CodigoZona");
            GerenteZonaEmail = row.ToString("GZEmail");
            GerenteZonaNombre = row.ToString("GerenteZona");
            Clave = row.ToString("ClaveSecreta");
            EsPostulante = true;
        }
    }
}
