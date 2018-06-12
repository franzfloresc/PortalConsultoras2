using System;
 

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class OfertaFinalMontoMetaModel
    {  
        public int Campania { get; set; } 
        public string Codigo { get; set; } 
        public string Nombre { get; set; } 
        public string CuvRegalo { get; set; } 
        public string NombreRegalo { get; set; } 
        public decimal MontoInicial { get; set; } 
        public decimal MontoPedido { get; set; } 
        public DateTime? FechaRegistro { get; set; }

        public decimal RangoInicial { get; set; }
        public decimal RangoFinal { get; set; }
        public decimal MontoAgregar { get; set; }
        public decimal MontoMeta { get; set; }
        public decimal MontoGanador { get; set; }
        public decimal ImporteReal { get; set; }
    }
}