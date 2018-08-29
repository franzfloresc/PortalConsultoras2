using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class JwtToken
    {
        public string Token { get; set; }
        public DateTime FechaExpiracion { get; set; }
    }
}
