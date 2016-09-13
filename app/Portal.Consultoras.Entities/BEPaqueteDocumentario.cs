namespace Portal.Consultoras.Entities
{
    using Common;
    using OpenSource.Library.DataAccess;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEPaqueteDocumentario
    {
        [DataMember]
        public string codigoConsultora { get; set; }

        [DataMember]
        public string campaniaID { get; set; }

        [DataMember]
        public string estado { get; set; }

        public BEPaqueteDocumentario(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "codigoConsultora") && datarec["codigoConsultora"] != DBNull.Value)
                codigoConsultora = DbConvert.ToString(datarec["codigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "campaniaID") && datarec["campaniaID"] != DBNull.Value)
                campaniaID = DbConvert.ToString(datarec["campaniaID"]);
            if (DataRecord.HasColumn(datarec, "estado") && datarec["estado"] != DBNull.Value)
                estado = DbConvert.ToString(datarec["estado"]);
        }
    }
}
