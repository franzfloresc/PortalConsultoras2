namespace Portal.Consultoras.Entities
{
    using OpenSource.Library.DataAccess;
    using Portal.Consultoras.Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEConsultoraDatoSAC
    {
        [DataMember]
        public long consultoraID { get; set; }
        [DataMember]
        public string codigo { get; set; }
        [DataMember]
        public string nombreCompleto { get; set; }
        [DataMember]
        public string seccion { get; set; }
        [DataMember]
        public string zona { get; set; }
        [DataMember]
        public string region { get; set; }
        [DataMember]
        public string direccionDomicilio { get; set; }
        [DataMember]
        public string direccionEntrega { get; set; }
        [DataMember]
        public string telefono1 { get; set; }
        [DataMember]
        public string telefono2 { get; set; }
        [DataMember]
        public string email { get; set; }
        [DataMember]
        public string validoEmail { get; set; }
        [DataMember]
        public string fechaNacimiento { get; set; }
        [DataMember]
        public string estadoCivil { get; set; }
        [DataMember]
        public string ofertaWeb { get; set; }
        [DataMember]
        public string cataloVirtual { get; set; }

        public BEConsultoraDatoSAC(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "consultoraID"))
                consultoraID = Convert.ToInt32(datarec["consultoraID"]);
            if (DataRecord.HasColumn(datarec, "codigo"))
                codigo = Convert.ToString(datarec["codigo"]);
            if (DataRecord.HasColumn(datarec, "nombreCompleto"))
                nombreCompleto = Convert.ToString(datarec["nombreCompleto"]);
            if (DataRecord.HasColumn(datarec, "seccion"))
                seccion = Convert.ToString(datarec["seccion"]);
            if (DataRecord.HasColumn(datarec, "zona"))
                zona = Convert.ToString(datarec["zona"]);
            if (DataRecord.HasColumn(datarec, "region"))
                region = Convert.ToString(datarec["region"]);
            if (DataRecord.HasColumn(datarec, "direccionDomicilio"))
                direccionDomicilio = Convert.ToString(datarec["direccionDomicilio"]);
            if (DataRecord.HasColumn(datarec, "direccionEntrega"))
                direccionEntrega = Convert.ToString(datarec["direccionEntrega"]);
            if (DataRecord.HasColumn(datarec, "telefono1"))
                telefono1 = Convert.ToString(datarec["telefono1"]);
            if (DataRecord.HasColumn(datarec, "telefono2"))
                telefono2 = Convert.ToString(datarec["telefono2"]);
            if (DataRecord.HasColumn(datarec, "email"))
                email = Convert.ToString(datarec["email"]);
            if (DataRecord.HasColumn(datarec, "validoEmail"))
                validoEmail = Convert.ToString(datarec["validoEmail"]);
            if (DataRecord.HasColumn(datarec, "fechaNacimiento"))
                fechaNacimiento = Convert.ToString(datarec["fechaNacimiento"]);
            if (DataRecord.HasColumn(datarec, "estadoCivil"))
                estadoCivil = Convert.ToString(datarec["estadoCivil"]);
            if (DataRecord.HasColumn(datarec, "ofertaWeb"))
                ofertaWeb = Convert.ToString(datarec["ofertaWeb"]);
            if (DataRecord.HasColumn(datarec, "cataloVirtual"))
                cataloVirtual = Convert.ToString(datarec["cataloVirtual"]);

        }
    }
}
