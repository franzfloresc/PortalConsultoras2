using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
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
        }
    }
}
