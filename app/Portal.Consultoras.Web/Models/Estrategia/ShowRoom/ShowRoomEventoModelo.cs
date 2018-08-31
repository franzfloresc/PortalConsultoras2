using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    public class ShowRoomEventoModelo
    {
        //[global::System.ComponentModel.BrowsableAttribute(false)]
        //public System.Runtime.Serialization.ExtensionDataObject ExtensionData { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string _id { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public int CampaniaID { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal Descuento { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public int DiasAntes { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public int DiasDespues { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public int Estado { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public int EventoID { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.DateTime FechaCreacion { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.DateTime FechaModificacion { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Imagen1 { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Imagen2 { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ImagenCabeceraProducto { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ImagenPestaniaShowRoom { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ImagenPreventaDigital { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ImagenVentaSetPopup { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ImagenVentaTagLateral { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Nombre { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public int NumeroPerfiles { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal OfertaEstrategia { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Tema { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string TextoEstrategia { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool TieneCategoria { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool TieneCompraXcompra { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool TienePersonalizacion { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool TieneSubCampania { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string UsuarioCreacion { get; set; }

        [System.Runtime.Serialization.DataMemberAttribute()]
        public string UsuarioModificacion { get; set; }
    }
}