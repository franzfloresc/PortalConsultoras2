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

        public string Simbolo { get; set; }

        public List<ShowRoomOfertaModel> ListaShowRoomOferta { get; set; }

        public int PosicionCarrusel { get; set; }
    }
}