﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceCDR;

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
        public DateTime? FechaCulminado { get; set; }        
        public DateTime? FechaAtencion { get; set; }        
        public decimal Importe { get; set; }
        public int CantidadDetalle { get; set; }
        public string NombreConsultora { get; set; }

        public string CodigoIso { get; set; }

        public string Simbolo { get; set; }
        public decimal ConsultoraSaldo { get; set; }    //EPD-1665

        public List<BECDRWebDetalle> ListaDetalle { get; set; }
        public string EstadoDescripcion
        {
            get
            {
                return Estado == Constantes.EstadoCDRWeb.Pendiente
                    ? "PENDIENTE"
                    : Estado == Constantes.EstadoCDRWeb.Enviado
                        ? "EN EVALUACION"
                        : Estado == Constantes.EstadoCDRWeb.Observado
                        ? "OBSERVADO"
                        : Estado == Constantes.EstadoCDRWeb.Aceptado
                            ? "APROBADO"
                            : "";
            }
        }

        public string ResumenResolucion
        {
            get
            {
                return Estado == Constantes.EstadoCDRWeb.Pendiente
                    ? "Pendiente"
                    : Estado == Constantes.EstadoCDRWeb.Enviado
                        ? "Enviado"
                        : Estado == Constantes.EstadoCDRWeb.Observado
                        ? "Resuelve las observaciones y envía nuevamente la solicitud"
                        : Estado == Constantes.EstadoCDRWeb.Aceptado
                            ? "Todos los productos fueron aprobados"
                            : "";
            }
        }

        public int ZonaID { get; set; }
        public int PaisID { get; set; }
        public int RegionID { get; set; }

        public IEnumerable<CampaniaModel> lista { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public IEnumerable<ZonaModel> listaZonas { get; set; }
        public IEnumerable<RegionModel> listaRegiones { get; set; }
    }
}