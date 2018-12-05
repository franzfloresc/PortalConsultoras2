using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfigPremioProgNuevasOFModel
    {
        public string CodigoNivel { get; set; }
        public PremioProgNuevasOFModel PremioAuto { get; set; }
        public List<PremioProgNuevasOFModel> ListPremioElec { get; set; }
        public bool TienePremio { get { return PremioAuto != null || (ListPremioElec != null && ListPremioElec.Any()); } }
    }
}