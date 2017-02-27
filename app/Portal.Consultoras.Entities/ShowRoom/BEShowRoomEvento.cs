using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

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

        public BEShowRoomEvento(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "EventoID") && datarec["EventoID"] != DBNull.Value)
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID") && datarec["CampaniaID"] != DBNull.Value)
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "Nombre") && datarec["Nombre"] != DBNull.Value)
                Nombre = DbConvert.ToString(datarec["Nombre"]);
            if (DataRecord.HasColumn(datarec, "Imagen1") && datarec["Imagen1"] != DBNull.Value)
                Imagen1 = DbConvert.ToString(datarec["Imagen1"]);
            if (DataRecord.HasColumn(datarec, "Imagen2") && datarec["Imagen2"] != DBNull.Value)
                Imagen2 = DbConvert.ToString(datarec["Imagen2"]);
            if (DataRecord.HasColumn(datarec, "Descuento") && datarec["Descuento"] != DBNull.Value)
                Descuento = DbConvert.ToDecimal(datarec["Descuento"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "TextoEstrategia") && datarec["TextoEstrategia"] != DBNull.Value)
                TextoEstrategia = DbConvert.ToString(datarec["TextoEstrategia"]);
            if (DataRecord.HasColumn(datarec, "OfertaEstrategia") && datarec["OfertaEstrategia"] != DBNull.Value)
                OfertaEstrategia = DbConvert.ToDecimal(datarec["OfertaEstrategia"]);
            if (DataRecord.HasColumn(datarec, "Tema") && datarec["Tema"] != DBNull.Value)
                Tema = DbConvert.ToString(datarec["Tema"]);
            if (DataRecord.HasColumn(datarec, "DiasAntes") && datarec["DiasAntes"] != DBNull.Value)
                DiasAntes = DbConvert.ToInt32(datarec["DiasAntes"]);
            if (DataRecord.HasColumn(datarec, "DiasDespues") && datarec["DiasDespues"] != DBNull.Value)
                DiasDespues = DbConvert.ToInt32(datarec["DiasDespues"]);
            if (DataRecord.HasColumn(datarec, "NumeroPerfiles") && datarec["NumeroPerfiles"] != DBNull.Value)
                NumeroPerfiles = DbConvert.ToInt32(datarec["NumeroPerfiles"]);
            if (DataRecord.HasColumn(datarec, "ImagenCabeceraProducto") && datarec["ImagenCabeceraProducto"] != DBNull.Value)
                ImagenCabeceraProducto = DbConvert.ToString(datarec["ImagenCabeceraProducto"]);
            if (DataRecord.HasColumn(datarec, "ImagenVentaSetPopup") && datarec["ImagenVentaSetPopup"] != DBNull.Value)
                ImagenVentaSetPopup = DbConvert.ToString(datarec["ImagenVentaSetPopup"]);
            if (DataRecord.HasColumn(datarec, "ImagenVentaTagLateral") && datarec["ImagenVentaTagLateral"] != DBNull.Value)
                ImagenVentaTagLateral = DbConvert.ToString(datarec["ImagenVentaTagLateral"]);
            if (DataRecord.HasColumn(datarec, "ImagenPestaniaShowRoom") && datarec["ImagenPestaniaShowRoom"] != DBNull.Value)
                ImagenPestaniaShowRoom = DbConvert.ToString(datarec["ImagenPestaniaShowRoom"]);
            if (DataRecord.HasColumn(datarec, "ImagenPreventaDigital") && datarec["ImagenPreventaDigital"] != DBNull.Value)
                ImagenPreventaDigital = DbConvert.ToString(datarec["ImagenPreventaDigital"]);            
            if (DataRecord.HasColumn(datarec, "Estado") && datarec["Estado"] != DBNull.Value)
                Estado = DbConvert.ToInt32(datarec["Estado"]);
            if (DataRecord.HasColumn(datarec, "TieneCategoria") && datarec["TieneCategoria"] != DBNull.Value)
                TieneCategoria = DbConvert.ToBoolean(datarec["TieneCategoria"]);
        }
    }
}
