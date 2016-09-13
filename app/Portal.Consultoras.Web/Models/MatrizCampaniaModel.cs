using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Models
{
    public class MatrizCampaniaModel
    {
        [Display(Name = "Campaña")]
        [Required(ErrorMessage = "Debe seleccionar una campaña.")]
        public string Nombre { set; get; }
        public Int32 PaisID { get; set; }

        public List<BECampania> DropDownListCampania { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }

        public string CUV { get; set; }
        public int CampaniaID { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioProducto { get; set; }
        public int FactorRepeticion { get; set; }
    }
}