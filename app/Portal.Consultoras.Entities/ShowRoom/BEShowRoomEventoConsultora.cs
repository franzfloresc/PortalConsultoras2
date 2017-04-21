﻿using OpenSource.Library.DataAccess;
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
        public bool Suscripcion { get; set; }

        [DataMember]
        public int Envio { get; set; }

        [DataMember]
        public string CorreoEnvioAviso { get; set; }

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
            if (DataRecord.HasColumn(datarec, "MostrarPopupVenta") && datarec["MostrarPopupVenta"] != DBNull.Value)
                MostrarPopupVenta = DbConvert.ToBoolean(datarec["MostrarPopupVenta"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            
            if (DataRecord.HasColumn(datarec, "Suscripcion") && datarec["Suscripcion"] != DBNull.Value)
                Suscripcion = DbConvert.ToBoolean(datarec["Suscripcion"]);
            if (DataRecord.HasColumn(datarec, "Envio") && datarec["Envio"] != DBNull.Value)
                Envio = DbConvert.ToInt32(datarec["Envio"]);
            if (DataRecord.HasColumn(datarec, "CorreoEnvioAviso") && datarec["CorreoEnvioAviso"] != DBNull.Value)
                CorreoEnvioAviso = DbConvert.ToString(datarec["CorreoEnvioAviso"]);
        }
    }
}
