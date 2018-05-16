using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
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
        [ViewProperty]
        public bool MostrarPopupVenta { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        public bool Suscripcion { get; set; }

        [DataMember]
        [ViewProperty]
        public int Envio { get; set; }

        [DataMember]
        [ViewProperty]
        public string CorreoEnvioAviso { get; set; }

        public BEShowRoomEventoConsultora(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "EventoConsultoraID"))
                EventoConsultoraID = DbConvert.ToInt32(datarec["EventoConsultoraID"]);
            if (DataRecord.HasColumn(datarec, "EventoID"))
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CodigoConsultora"))
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "Segmento"))
                Segmento = DbConvert.ToString(datarec["Segmento"]);
            if (DataRecord.HasColumn(datarec, "MostrarPopup"))
                MostrarPopup = DbConvert.ToBoolean(datarec["MostrarPopup"]);
            if (DataRecord.HasColumn(datarec, "MostrarPopupVenta"))
                MostrarPopupVenta = DbConvert.ToBoolean(datarec["MostrarPopupVenta"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion"))
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion"))
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion"))
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion"))
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);

            if (DataRecord.HasColumn(datarec, "Suscripcion"))
                Suscripcion = DbConvert.ToBoolean(datarec["Suscripcion"]);
            if (DataRecord.HasColumn(datarec, "Envio"))
                Envio = DbConvert.ToInt32(datarec["Envio"]);
            if (DataRecord.HasColumn(datarec, "CorreoEnvioAviso"))
                CorreoEnvioAviso = DbConvert.ToString(datarec["CorreoEnvioAviso"]);
        }
    }
}
