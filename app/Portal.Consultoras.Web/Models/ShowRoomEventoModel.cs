﻿using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
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

        public int Estado { get; set; }

        public bool TieneCategoria { get; set; }

        public bool TieneCompraXcompra { get; set; }

        public bool TieneSubCampania { get; set; }

        public bool TienePersonalizacion { get; set; }

        public string Simbolo { get; set; }

        public List<ShowRoomOfertaModel> ListaShowRoomOferta { get; set; }

        public int PosicionCarrusel { get; set; }

        public string CodigoIso { get; set; }

        public string FormatoCampania { get; set; }

        public List<ShowRoomOfertaModel> ListaShowRoomCompraPorCompra { get; set; }

        public string UrlTerminosCondiciones { get; set; }

        public string TextoCondicionCompraCpc { get; set; }

        public string TextoDescripcionLegalCpc { get; set; }

        public List<ShowRoomCategoriaModel> ListaCategoria { get; set; }

        public List<BETablaLogicaDatos> FiltersBySorting { get; set; }

        public string TextoInicialOfertaSubCampania { get; set; }

        public string ColorTextoInicialOfertaSubCampania { get; set; }

        public string TextoTituloOfertaSubCampania { get; set; }

        public string ColorTextoTituloOfertaSubCampania { get; set; }

        public string ColorFondoTituloOfertaSubCampania { get; set; }

        public string ImagenFondoTituloOfertaSubCampania { get; set; }

        public string ColorFondoContenidoOfertaSubCampania { get; set; }

        public string TextoBotonVerMasOfertaSubCampania { get; set; }
    }
}