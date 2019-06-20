using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.ProgramaNuevas
{
    [Serializable]
    public class ConfigPremioProgNuevasModel
    {
        public string CodigoNivel { get; set; }
        public PremioProgNuevasModel PremioAuto { get; set; }
        public List<PremioProgNuevasModel> ListPremioElec { get; set; }
        public bool MostrarRegaloOF { get; set; }
    }
}