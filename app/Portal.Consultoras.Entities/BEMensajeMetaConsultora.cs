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
            if (DataRecord.HasColumn(datarec, "TipoMensaje"))
                TipoMensaje = Convert.ToString(datarec["TipoMensaje"]);
            if (DataRecord.HasColumn(datarec, "Titulo"))
                Titulo = Convert.ToString(datarec["Titulo"]);
            if (DataRecord.HasColumn(datarec, "Mensaje"))
                Mensaje = Convert.ToString(datarec["Mensaje"]);

        }
    }
}
