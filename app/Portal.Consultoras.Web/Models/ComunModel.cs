using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ComunModel
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public string Valor { get; set; }
        public string ValorOpcional { get; set; }
    }
}