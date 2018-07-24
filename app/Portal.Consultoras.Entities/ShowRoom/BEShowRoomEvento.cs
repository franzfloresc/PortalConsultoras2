using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomEvento
    {
        [DataMember]
        public int EventoID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string Imagen1 { get; set; }

        [DataMember]
        public string Imagen2 { get; set; }

        [DataMember]
        public decimal Descuento { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public string TextoEstrategia { get; set; }

        [DataMember]
        public decimal OfertaEstrategia { get; set; }

        [DataMember]
        public string Tema { get; set; }

        [DataMember]
        public int DiasAntes { get; set; }

        [DataMember]
        public int DiasDespues { get; set; }

        [DataMember]
        public int NumeroPerfiles { get; set; }

        [DataMember]
        public string ImagenCabeceraProducto { get; set; }

        [DataMember]
        public string ImagenVentaSetPopup { get; set; }

        [DataMember]
        public string ImagenVentaTagLateral { get; set; }

        [DataMember]
        public string ImagenPestaniaShowRoom { get; set; }

        [DataMember]
        public string ImagenPreventaDigital { get; set; }

        [DataMember]
        public int Estado { get; set; }

        [DataMember]
        public bool TieneCategoria { get; set; }

        [DataMember]
        public bool TieneCompraXcompra { get; set; }

        [DataMember]
        public bool TieneSubCampania { get; set; }
        [DataMember]
        public bool TienePersonalizacion { get; set; }

        public BEShowRoomEvento(IDataRecord row)
        {
            EventoID = row.ToInt32("EventoID");
            CampaniaID = row.ToInt32("CampaniaID");
            Nombre = row.ToString("Nombre");
            Imagen1 = row.ToString("Imagen1");
            Imagen2 = row.ToString("Imagen2");
            Descuento = row.ToDecimal("Descuento");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            TextoEstrategia = row.ToString("TextoEstrategia");
            OfertaEstrategia = row.ToDecimal("OfertaEstrategia");
            Tema = row.ToString("Tema");
            DiasAntes = row.ToInt32("DiasAntes");
            DiasDespues = row.ToInt32("DiasDespues");
            NumeroPerfiles = row.ToInt32("NumeroPerfiles");
            ImagenCabeceraProducto = row.ToString("ImagenCabeceraProducto");
            ImagenVentaSetPopup = row.ToString("ImagenVentaSetPopup");
            ImagenVentaTagLateral = row.ToString("ImagenVentaTagLateral");
            ImagenPestaniaShowRoom = row.ToString("ImagenPestaniaShowRoom");
            ImagenPreventaDigital = row.ToString("ImagenPreventaDigital");
            Estado = row.ToInt32("Estado");
            TieneCategoria = row.ToBoolean("TieneCategoria");
            TieneCompraXcompra = row.ToBoolean("TieneCompraXcompra");
            TieneSubCampania = row.ToBoolean("TieneSubCampania");
            TienePersonalizacion = row.ToBoolean("TienePersonalizacion");
        }
    }
}
