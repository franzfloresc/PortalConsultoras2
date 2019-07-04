using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class AdministrarCaminoBrillanteModel
    {
        public int PaisID { set; get; }
        public string CodigoNivel { get; set; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public IEnumerable<NivelCaminoBrillanteModel> listaNiveles { get; set; }
    }
}