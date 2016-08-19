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
    public class BEShowRoomEventoConsultora
    {
        [DataMember]
        public int EventoConsultoraID { get; set; }

        [DataMember]
        public int EventoID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string Segmento { get; set; }

        [DataMember]
        public bool MostrarPopup { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BEShowRoomEventoConsultora(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "EventoConsultoraID") && datarec["EventoConsultoraID"] != DBNull.Value)
                EventoConsultoraID = DbConvert.ToInt32(datarec["EventoConsultoraID"]);
            if (DataRecord.HasColumn(datarec, "EventoID") && datarec["EventoID"] != DBNull.Value)
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID") && datarec["CampaniaID"] != DBNull.Value)
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CodigoConsultora") && datarec["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "Segmento") && datarec["Segmento"] != DBNull.Value)
                Segmento = DbConvert.ToString(datarec["Segmento"]);
            if (DataRecord.HasColumn(datarec, "MostrarPopup") && datarec["MostrarPopup"] != DBNull.Value)
                MostrarPopup = DbConvert.ToBoolean(datarec["MostrarPopup"]);            
            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
        }
    }
}
