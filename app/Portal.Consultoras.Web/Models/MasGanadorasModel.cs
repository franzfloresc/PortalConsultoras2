using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class MasGanadorasModel
    {
        public MasGanadorasModel()
        {
            this.TieneLanding = true;
        }
        public bool TieneMG{ get; set; }
        public bool TieneLanding { get; set; }
    }
}