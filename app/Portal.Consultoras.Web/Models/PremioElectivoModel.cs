using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class PremioElectivoModel : EstrategiaPersonalizadaProductoModel
    {
        public bool CuponElectivoDefault { get; set; }
    }
}