using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ShowRoomEventoModel
    {
        public int EventoID { get; set; }

        public int CampaniaID { get; set; }

        public string Nombre { get; set; }

        public string Imagen1 { get; set; }

        public string Imagen2 { get; set; }

        public decimal Descuento { get; set; }

        public DateTime FechaCreacion { get; set; }

        public string UsuarioCreacion { get; set; }

        public DateTime FechaModificacion { get; set; }

        public string UsuarioModificacion { get; set; }

        public string TextoEstrategia { get; set; }

        public decimal OfertaEstrategia { get; set; }

        public string Tema { get; set; }

        public int DiasAntes { get; set; }

        public int DiasDespues { get; set; }

        public int NumeroPerfiles { get; set; }

        public string ImagenCabeceraProducto { get; set; }

        public string ImagenVentaSetPopup { get; set; }

        public string ImagenVentaTagLateral { get; set; }

        public string ImagenPestaniaShowRoom { get; set; }

        public string ImagenPreventaDigital { get; set; }

        public string RutaShowRoomPopup { get; set; }

        public string RutaShowRoomBannerLateral { get; set; }

        public int Estado { get; set; }

        public string Simbolo { get; set; }

        public List<ShowRoomOfertaModel> ListaShowRoomOferta { get; set; }

        public int PosicionCarrusel { get; set; }

        public string CodigoIso { get; set; }
    }
}