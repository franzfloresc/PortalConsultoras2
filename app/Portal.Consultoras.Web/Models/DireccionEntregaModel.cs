using Portal.Consultoras.Web.ServiceUnete;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class DireccionEntregaModel
    {
        public int DireccionEntregaID { get; set; }
        public int ConsultoraID { get; set; }
        public int CampaniaID { get; set; }
        public int CampaniaAnteriorID { get; set; }
        [Required()]
        public int Ubigeo1 { get; set; }
        [Required()]
        public int Ubigeo2 { get; set; }
        public int Ubigeo3 { get; set; }

        public int Ubigeo1Anterior { get; set; }
        public int Ubigeo2Anterior { get; set; }
        public int Ubigeo3Anterior { get; set; }

        public string DireccionAnterior { get; set; }
        [Required(ErrorMessage = "La dirección es requerida.")]
        public string Direccion { get; set; }
        public string Referencia { get; set; }
        public string CodigoConsultora { get; set; }
        public string NombreConsultora { get; set; }
        public decimal LatitudAnterior { get; set; }
        public decimal LongitudAnterior { get; set; }
        public decimal Latitud { get; set; }
        public decimal Longitud { get; set; }
        public DateTime? UltimafechaActualizacion { get; set; }

        public string CodigoUsuario { get; set; }
        public int PaisID { get; set; }
        public int Resultado { get; set; }
        public int Operacion { get; set; }


        public List<ParametroUneteBE> DropDownUbigeo1 { get; set; }
        public List<ParametroUneteBE> DropDownUbigeo2 { get; set; }
        public List<ParametroUneteBE> DropDownUbigeo3 { get; set; }
    }
}