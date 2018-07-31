using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class BarraTippingPoint
    {
        public int CampaniaID { get; set; }
        public int CampaniaIDFin { get; set; }
        public decimal Ganancia { get; set; }
        public decimal Precio { get; set; }
        public decimal Precio2 { get; set; }
        public decimal PrecioPublico { get; set; }
        public decimal PrecioUnitario { get; set; }
        public string CUV1 { get; set; }
        public string CUV2 { get; set; }
        public string ImagenURL { get; set; }
        public string DescripcionCUV2 { get; set; }
        public string LinkURL { get; set; }
        public bool ActiveTooltip { get; set; }
        public bool ActiveMonto { get; set; }
        public bool Active { get; set; }
        public string TippingPointMontoStr { get; set; }


        public BarraTippingPoint()
        {
            this.CampaniaID = default(int);
            this.CampaniaIDFin = default(int);
            this.Ganancia = default(decimal);
            this.Precio = default(decimal);
            this.Precio2 = default(decimal);
            this.PrecioPublico = default(decimal);
            this.PrecioUnitario = default(decimal);
            this.CUV1 = default(string);
            this.CUV2 = default(string);
            this.ImagenURL = default(string);
            this.DescripcionCUV2 = default(string);
            this.LinkURL = default(string);
            this.ActiveTooltip = false;
            this.ActiveMonto = false;
            this.Active = false;
        }
    }
}