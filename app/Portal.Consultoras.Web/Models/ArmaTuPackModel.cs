using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ArmaTuPackModel
    {
        public bool TieneAtp { get; set; }
        public int CampaniaID { get; set; }
    }
}