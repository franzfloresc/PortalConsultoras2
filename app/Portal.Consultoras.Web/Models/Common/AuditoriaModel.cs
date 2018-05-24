using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Models.Common
{
    public class AuditoriaModel
    {
        public string UsuarioCreacion { get; set; }
        
        public DateTime FechaCreacion { get; set; }
        
        public string UsuarioModificacion { get; set; }
        
        public DateTime? FechaModificacion { get; set; }
    }
}
