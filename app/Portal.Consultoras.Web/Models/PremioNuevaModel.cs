using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class PremioNuevaModel
    {
        public  int IdActivarPremioNuevas { get; set; }
        [Required]
        [RegularExpression("[0-9]{3}")]
        public string CodigoPrograma { get; set; }
        public int AnoCampanaIni { get; set; }
        public int AnoCampanaFin { get; set; }
        [Required]
        [RegularExpression("[a-zA-Z0-9]{2}")]
        public string Nivel { get; set; }
        public bool ActiveTooltip { get; set; }
        public bool ActiveMonto { get; set; }
        public bool ActivePremioAuto { get; set; }
        public bool ActivePremioElectivo { get; set; }
        public List<CampaniaModel> DropDownListCampania { get; set; }
        public List<object> DropDownListNivel { get; set; }
        public List<object> DropDownListEstado { get; set; }
        public  int Operacion { get; set; }

        public int PaisID { get; set; }
        public string CodigoUsuario { get; set; }
    }
}