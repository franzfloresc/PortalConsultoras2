using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class UpdatePassSACModel
    {
        public Int32 PaisID { get; set; }
        public string CodigoConsultora { get; set; }
        public string Clave { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
    }
}