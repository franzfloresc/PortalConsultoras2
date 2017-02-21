using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Models
{
    public class ShowRoomBannerLateralModel
    {
        public bool ConsultoraNoEncontrada { get; set; }
        public bool EventoNoEncontrado { get; set; }

        public BEShowRoomEventoConsultora BEShowRoomConsultora { get; set; }

        public BEShowRoomEvento BEShowRoom { get; set; }

        public int DiasFaltantes { get; set; }

        public int MesFaltante { get; set; }

        public int AnioFaltante { get; set; }

        public bool MostrarShowRoomProductos { get; set; }

        public bool EstaActivoLateral { get; set; }

        public string RutaShowRoomBannerLateral { get; set; }

        public string LetrasDias { get; set; }
        public string ImagenPopupShowroomIntriga { get; set; }

        public string ImagenBannerShowroomIntriga { get; set; }

    }
}