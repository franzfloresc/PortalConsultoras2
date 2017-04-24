using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Portal.Consultoras.Common;
using System.Data;

namespace Portal.Consultoras.Entities
{
    public class BEConsultoraEmail
    {
        public string NombreCompleto { get; set; }
        //public string PrimerNombre { get; set; }
        //public string SegundoNombre { get; set; }
        //public string PrimerApellido { get; set; }
        //public string SegundoApellido { get; set; }
        public string Codigo { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }
        //public string TelefonoTrabajo { get; set; }
        //public string Celular { get; set; }
        //public string Numero { get; set; }
        public string CodigoZona { get; set; }
        public string GerenteZonaNombre { get; set; }
        public string GerenteZonaEmail { get; set; }
        //public DateTime FechaCarga { get; set; }
        //public int ZonaID { get; set; }
        public bool EsPostulante { get; set; }
        public string CodigoUsuario { get; set; }
        public string Clave { get; set; }

        public BEConsultoraEmail(IDataRecord row)
        {
            CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            Codigo = Convert.ToString(row["CodigoConsultora"]);
            NombreCompleto = Convert.ToString(row["Nombre"]);
            Email = Convert.ToString(row["Email"]);
            CodigoZona = Convert.ToString(row["CodigoZona"]);
            GerenteZonaEmail = Convert.ToString(row["GZEmail"]);
            GerenteZonaNombre = Convert.ToString(row["GerenteZona"]);
            Clave = Convert.ToString(row["ClaveSecreta"]);
            EsPostulante = true;
        }
    }
}
