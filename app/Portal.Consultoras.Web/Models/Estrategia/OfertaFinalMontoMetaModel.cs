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
        public decimal MontoMeta { get; set; } 
        public decimal MontoPedido { get; set; } 
        public DateTime? FechaRegistro { get; set; }
    }
}