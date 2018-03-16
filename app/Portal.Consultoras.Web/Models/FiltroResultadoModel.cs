using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class FiltroResultadoModel
    {
        public string Id { get; set; }
        public string Valor1 { get; set; }
        public string Valor2 { get; set; }
        public string Orden { get; set; }
    }
}