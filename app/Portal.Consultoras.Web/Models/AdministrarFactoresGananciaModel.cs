using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarFactoresGananciaModel
    {
        public int FactorGananciaID { get; set; }
        public int PaisID { set; get; }
        public int RangoMinimo { set; get; }
        public int RangoMaximo { set; get; }
        public Int16 Porcentaje { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}