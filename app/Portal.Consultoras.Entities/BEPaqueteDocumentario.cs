namespace Portal.Consultoras.Entities
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

        public BEPaqueteDocumentario(IDataRecord row)
        {
            codigoConsultora = row.ToString("codigoConsultora");
            campaniaID = row.ToString("campaniaID");
            estado = row.ToString("estado");
        }
    }
}
