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

        public BEShowRoomEvento(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "EventoID"))
                EventoID = Convert.ToInt32(datarec["EventoID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = Convert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "Nombre"))
                Nombre = Convert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "Imagen1"))
                Imagen1 = Convert.ToString(datarec["Imagen1"]);
            if (DataRecord.HasColumn(datarec, "Imagen2"))
                Imagen2 = Convert.ToString(datarec["Imagen2"]);
            if (DataRecord.HasColumn(datarec, "Descuento"))
                Descuento = Convert.ToDecimal(datarec["Descuento"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion"))
                UsuarioCreacion = Convert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "TextoEstrategia"))
                TextoEstrategia = Convert.ToString(datarec["TextoEstrategia"]);
            if (DataRecord.HasColumn(datarec, "OfertaEstrategia"))
                OfertaEstrategia = Convert.ToDecimal(datarec["OfertaEstrategia"]);
            if (DataRecord.HasColumn(datarec, "Tema"))
                Tema = Convert.ToString(datarec["Tema"]);
            if (DataRecord.HasColumn(datarec, "DiasAntes"))
                DiasAntes = Convert.ToInt32(datarec["DiasAntes"]);
            if (DataRecord.HasColumn(datarec, "DiasDespues"))
                DiasDespues = Convert.ToInt32(datarec["DiasDespues"]);
            if (DataRecord.HasColumn(datarec, "NumeroPerfiles"))
                NumeroPerfiles = Convert.ToInt32(datarec["NumeroPerfiles"]);
            if (DataRecord.HasColumn(datarec, "ImagenCabeceraProducto"))
                ImagenCabeceraProducto = Convert.ToString(datarec["ImagenCabeceraProducto"]);
            if (DataRecord.HasColumn(datarec, "ImagenVentaSetPopup"))
                ImagenVentaSetPopup = Convert.ToString(datarec["ImagenVentaSetPopup"]);
            if (DataRecord.HasColumn(datarec, "ImagenVentaTagLateral"))
                ImagenVentaTagLateral = Convert.ToString(datarec["ImagenVentaTagLateral"]);
            if (DataRecord.HasColumn(datarec, "ImagenPestaniaShowRoom"))
                ImagenPestaniaShowRoom = Convert.ToString(datarec["ImagenPestaniaShowRoom"]);
            if (DataRecord.HasColumn(datarec, "ImagenPreventaDigital"))
                ImagenPreventaDigital = Convert.ToString(datarec["ImagenPreventaDigital"]);
            if (DataRecord.HasColumn(datarec, "Estado"))
                Estado = Convert.ToInt32(datarec["Estado"]);
            if (DataRecord.HasColumn(datarec, "TieneCategoria"))
                TieneCategoria = Convert.ToBoolean(datarec["TieneCategoria"]);
            if (DataRecord.HasColumn(datarec, "TieneCompraXcompra"))
                TieneCompraXcompra = Convert.ToBoolean(datarec["TieneCompraXcompra"]);
            if (DataRecord.HasColumn(datarec, "TieneSubCampania"))
                TieneSubCampania = Convert.ToBoolean(datarec["TieneSubCampania"]);
            if (DataRecord.HasColumn(datarec, "TienePersonalizacion"))
                TienePersonalizacion = Convert.ToBoolean(datarec["TienePersonalizacion"]);
        }
    }
}
