using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class CDRWebModel
    {
        public int CDRWebID { get; set; }        
        public int PedidoID { get; set; }       
        public int PedidoNumero { get; set; }        
        public int CampaniaID { get; set; }        
        public int ConsultoraID { get; set; }        
        public DateTime FechaRegistro { get; set; }        
        public int Estado { get; set; }        
        public DateTime FechaCulminado { get; set; }        
        public DateTime FechaAtencion { get; set; }        
        public decimal Importe { get; set; }

        public string EstadoDescripcion
        {
            get
            {
                return Estado == Constantes.EstadoCDRWeb.EnProceso || Estado == Constantes.EstadoCDRWeb.Culminado
                    ? "PENDIENTE"
                    : Estado == Constantes.EstadoCDRWeb.Rechazado
                        ? "RECHAZADO"
                        : Estado == Constantes.EstadoCDRWeb.Aprobado
                            ? "APROBADO"
                            : "";
            }
        }
    }
}