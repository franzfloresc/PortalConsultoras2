using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class EstrategiaMDbAdapterModel
    {
        public string _id { get; set; }
        public bool FlagConfig { get; set; }
        public BEEstrategia BEEstrategia { get; set; }
    }
}