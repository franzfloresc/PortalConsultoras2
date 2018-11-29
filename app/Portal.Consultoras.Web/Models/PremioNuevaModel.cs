using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class PremioNuevaModel
    {
        public  int IdActivarPremioNuevas { get; set; }
        public string CodigoPrograma { get; set; }
        public int AnoCampanaIni { get; set; }
        public int AnoCampanaFin { get; set; }
        public string Nivel { get; set; }
        public bool ActiveTooltip { get; set; }
        public bool ActiveTooltipMonto { get; set; }
        public bool Active { get; set; }
        public bool Ind_Cupo_Elec { get; set; }
        public List<CampaniaModel> DropDownListCampania { get; set; }
        public List<object> DropDownListNivel { get; set; }
        public List<object> DropDownListEstado { get; set; }
        public  int Operacion { get; set; }

        public int PaisID { get; set; }
        public string CodigoUsuario { get; set; }
    }
}