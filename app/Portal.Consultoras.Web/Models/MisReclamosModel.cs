using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class MisReclamosModel
    {
        public int CDRWebID { get; set; }
        public int PedidoID { get; set; }
        public int CampaniaID { get; set; }
        public List<CampaniaModel> ListaCampania { get; set; }
        public string Campania { get; set; }
        public string EstadoSsic { get; set; }
        public string CUV { get; set; }
        public int Cantidad { get; set; }
        public string DescripcionProd { get; set; }
        public string EstadoSsic2 { get; set; }
        public string CUV2 { get; set; }
        public int Cantidad2 { get; set; }
        public string DescripcionProd2 { get; set; }
        public string DescripcionConfirma { get; set; }
        public string DescripcionConfirma2 { get; set; }
        public string Motivo { get; set; }
        public string Operacion { get; set; }
        public List<Campo> ListaMotivo { get; set; }
        public int CDRWebDetalleID { get; set; }

        public string Accion { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }

        public List<CDRWebModel> ListaCDRWeb { get; set; } 
        
        public int IndicadorBloqueoCDR { get; set; }
    }
}