namespace Portal.Consultoras.Web.Models
{
    public class BarraTippingPoint
    {
        public bool Active { get { return ActivePremioAuto || ActivePremioElectivo; } }
        public bool ActivePremioAuto { get; set; }
        public bool ActivePremioElectivo { get; set; }
        public bool ActiveTooltip { get; set; }
        public bool ActiveMonto { get; set; }
        public string DescripcionCUV2 { get; set; }
        public string LinkURL { get; set; }
    }
}