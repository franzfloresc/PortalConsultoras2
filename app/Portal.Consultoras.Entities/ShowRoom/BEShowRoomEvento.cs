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
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "Nombre"))
                Nombre = DbConvert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "Imagen1"))
                Imagen1 = DbConvert.ToString(datarec["Imagen1"]);
            if (DataRecord.HasColumn(datarec, "Imagen2"))
                Imagen2 = DbConvert.ToString(datarec["Imagen2"]);
            if (DataRecord.HasColumn(datarec, "Descuento"))
                Descuento = DbConvert.ToDecimal(datarec["Descuento"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion"))
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion"))
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion"))
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "TextoEstrategia"))
                TextoEstrategia = DbConvert.ToString(datarec["TextoEstrategia"]);
            if (DataRecord.HasColumn(datarec, "OfertaEstrategia"))
                OfertaEstrategia = DbConvert.ToDecimal(datarec["OfertaEstrategia"]);
            if (DataRecord.HasColumn(datarec, "Tema"))
                Tema = DbConvert.ToString(datarec["Tema"]);
            if (DataRecord.HasColumn(datarec, "DiasAntes"))
                DiasAntes = DbConvert.ToInt32(datarec["DiasAntes"]);
            if (DataRecord.HasColumn(datarec, "DiasDespues"))
                DiasDespues = DbConvert.ToInt32(datarec["DiasDespues"]);
            if (DataRecord.HasColumn(datarec, "NumeroPerfiles"))
                NumeroPerfiles = DbConvert.ToInt32(datarec["NumeroPerfiles"]);
            if (DataRecord.HasColumn(datarec, "ImagenCabeceraProducto"))
                ImagenCabeceraProducto = DbConvert.ToString(datarec["ImagenCabeceraProducto"]);
            if (DataRecord.HasColumn(datarec, "ImagenVentaSetPopup"))
                ImagenVentaSetPopup = DbConvert.ToString(datarec["ImagenVentaSetPopup"]);
            if (DataRecord.HasColumn(datarec, "ImagenVentaTagLateral"))
                ImagenVentaTagLateral = DbConvert.ToString(datarec["ImagenVentaTagLateral"]);
            if (DataRecord.HasColumn(datarec, "ImagenPestaniaShowRoom"))
                ImagenPestaniaShowRoom = DbConvert.ToString(datarec["ImagenPestaniaShowRoom"]);
            if (DataRecord.HasColumn(datarec, "ImagenPreventaDigital"))
                ImagenPreventaDigital = DbConvert.ToString(datarec["ImagenPreventaDigital"]);
            if (DataRecord.HasColumn(datarec, "Estado"))
                Estado = DbConvert.ToInt32(datarec["Estado"]);
            if (DataRecord.HasColumn(datarec, "TieneCategoria"))
                TieneCategoria = DbConvert.ToBoolean(datarec["TieneCategoria"]);
            if (DataRecord.HasColumn(datarec, "TieneCompraXcompra"))
                TieneCompraXcompra = DbConvert.ToBoolean(datarec["TieneCompraXcompra"]);
            if (DataRecord.HasColumn(datarec, "TieneSubCampania"))
                TieneSubCampania = DbConvert.ToBoolean(datarec["TieneSubCampania"]);
            if (DataRecord.HasColumn(datarec, "TienePersonalizacion"))
                TienePersonalizacion = DbConvert.ToBoolean(datarec["TienePersonalizacion"]);
        }
    }
}
