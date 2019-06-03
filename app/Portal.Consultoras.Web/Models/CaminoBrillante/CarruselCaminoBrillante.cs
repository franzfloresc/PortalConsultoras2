using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class CarruselCaminoBrillanteModel
    {
        public List<ItemCarruselCaminoBrillanteModel> Items { get; set; }
        public bool VerMas { get; set; }
    }

    public class ItemCarruselCaminoBrillanteModel
    {
        public KitCaminoBrillanteModel Kit { get; set; }
        public DemostradorCaminoBrillanteModel Demostrador { get; set; }
    }
}