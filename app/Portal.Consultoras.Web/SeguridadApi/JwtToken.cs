using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web
{
    public class JwtToken
    {
        public string Token { get; set; }
        public DateTime FechaExpiracion { get; set; }
    }
}