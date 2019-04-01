

using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.DetalleEstrategia
{
    public class ComponenteDetalleModel
    {
        public string Marca { get; set; }
        public string Descripcion { get; set; }
         
        public List<string> UnidadMedida { get; set; }

        public string Moneda { get; set; }
        public double? PrecioCliente { get; set; }

        public List<SeccionComponenteDetalle> ModoUso { get; set; }
        public List<SeccionComponenteDetalle> DescubreMas { get; set; }
        public List<SeccionComponenteDetalle> TipVenta { get; set; }
        public List<SeccionComponenteDetalle> Video { get; set; }
    }
    public class SeccionComponenteDetalle {
        public string Titulo { get; set; }
        public string Valor { get; set; }
    }
}