using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class CatalogoModel
    {
        public int CampaniaID { get; set; }
        public int MarcaID { get; set; }
        public int PaisID { get; set; }
        public string Direccion { get; set; }
    }
}