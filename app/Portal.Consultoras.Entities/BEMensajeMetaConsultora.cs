using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMensajeMetaConsultora
    {
        [DataMember]
        public string TipoMensaje { get; set; }
        [DataMember]
        public string Titulo { get; set; }
        [DataMember]
        public string Mensaje { get; set; }

        public BEMensajeMetaConsultora()
        {

        }
        public BEMensajeMetaConsultora(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "TipoMensaje") && datarec["TipoMensaje"] != DBNull.Value)
                TipoMensaje = DbConvert.ToString(datarec["TipoMensaje"]);
            if (DataRecord.HasColumn(datarec, "Titulo") && datarec["Titulo"] != DBNull.Value)
                Titulo = DbConvert.ToString(datarec["Titulo"]);
            if (DataRecord.HasColumn(datarec, "Mensaje") && datarec["Mensaje"] != DBNull.Value)
                Mensaje = DbConvert.ToString(datarec["Mensaje"]);

        }
    }
}
