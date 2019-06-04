using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    //DH-3703 EINCA
    public class ProductoComplementarioModel
    {
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public int Cantidad { get; set; }
    }
}