﻿namespace Portal.Consultoras.Entities
{
    using Common;
    using OpenSource.Library.DataAccess;
    using System;
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
            if (DataRecord.HasColumn(datarec, "codigoConsultora"))
                codigoConsultora = DbConvert.ToString(datarec["codigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "campaniaID"))
                campaniaID = DbConvert.ToString(datarec["campaniaID"]);
            if (DataRecord.HasColumn(datarec, "estado"))
                estado = DbConvert.ToString(datarec["estado"]);
        }
    }
}
