using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class EstrategiaMDbAdapterModel
    {
        public string _id { get; set; }
        public bool FlagConfig { get; set; }
        public bool FlagImagenURL { get; set; }
        public BEEstrategia BEEstrategia { get; set; }
        public List<BEEstrategiaProducto> Componentes { get; set; }
    }
}