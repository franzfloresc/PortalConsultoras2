using System;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomBannerLateralModel
    {
        public bool ConsultoraNoEncontrada { get; set; }
        public bool EventoNoEncontrado { get; set; }

        public ShowRoomEventoConsultoraModel BEShowRoomConsultora { get; set; }

        public ShowRoomEventoModel BEShowRoom { get; set; }


        public int DiasFaltantes { get; set; }

        public int MesFaltante { get; set; }

        public int AnioFaltante { get; set; }

        public bool MostrarShowRoomProductos { get; set; }

        public bool EstaActivoLateral { get; set; }

        public string RutaShowRoomBannerLateral { get; set; }

        private string _letrasDias;
        public string LetrasDias
        {
            private set { _letrasDias = value; }

            get
            {
                _letrasDias = string.Empty;
                if (DiasFaltantes > 1)
                {
                    _letrasDias = "FALTAN " + Convert.ToInt32(DiasFaltantes) + " DÍAS";
                }
                else
                {
                    _letrasDias = LetrasDias = "FALTA " + Convert.ToInt32(DiasFaltantes) + " DÍA";
                }

                return _letrasDias;
            }

        }

        public string ImagenPopupShowroomIntriga { get; set; }

        public string ImagenBannerShowroomIntriga { get; set; }

        public int DiasFalta { get; set; }

        public string ImagenPopupShowroomVenta { get; set; }

        public string ImagenBannerShowroomVenta { get; set; }
        public string EstadoActivo { get; set; }

    }
}