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
            if (DataRecord.HasColumn(datarec, "consultoraID") && datarec["consultoraID"] != DBNull.Value)
                consultoraID = DbConvert.ToInt32(datarec["consultoraID"]);
            if (DataRecord.HasColumn(datarec, "codigo") && datarec["Codigo"] != DBNull.Value)
                codigo = DbConvert.ToString(datarec["codigo"]);
            if (DataRecord.HasColumn(datarec, "nombreCompleto") && datarec["nombreCompleto"] != DBNull.Value)
                nombreCompleto = DbConvert.ToString(datarec["nombreCompleto"]);
            if (DataRecord.HasColumn(datarec, "seccion") && datarec["seccion"] != DBNull.Value)
                seccion = DbConvert.ToString(datarec["seccion"]);
            if (DataRecord.HasColumn(datarec, "zona") && datarec["zona"] != DBNull.Value)
                zona = DbConvert.ToString(datarec["Zona"]);
            if (DataRecord.HasColumn(datarec, "region") && datarec["region"] != DBNull.Value)
                region = DbConvert.ToString(datarec["region"]);
            if (DataRecord.HasColumn(datarec, "direccionDomicilio") && datarec["direccionDomicilio"] != DBNull.Value)
                direccionDomicilio = DbConvert.ToString(datarec["direccionDomicilio"]);
            if (DataRecord.HasColumn(datarec, "direccionEntrega") && datarec["direccionEntrega"] != DBNull.Value)
                direccionEntrega = DbConvert.ToString(datarec["direccionEntrega"]);
            if (DataRecord.HasColumn(datarec, "telefono1") && datarec["telefono1"] != DBNull.Value)
                telefono1 = DbConvert.ToString(datarec["telefono1"]);
            if (DataRecord.HasColumn(datarec, "telefono2") && datarec["telefono2"] != DBNull.Value)
                telefono2 = DbConvert.ToString(datarec["telefono2"]);
            if (DataRecord.HasColumn(datarec, "email") && datarec["email"] != DBNull.Value)
                email = DbConvert.ToString(datarec["email"]);
            if (DataRecord.HasColumn(datarec, "validoEmail") && datarec["validoEmail"] != DBNull.Value)
                validoEmail = DbConvert.ToString(datarec["validoEmail"]);
            if (DataRecord.HasColumn(datarec, "fechaNacimiento") && datarec["fechaNacimiento"] != DBNull.Value)
                fechaNacimiento = DbConvert.ToString(datarec["fechaNacimiento"]);
            if (DataRecord.HasColumn(datarec, "estadoCivil") && datarec["estadoCivil"] != DBNull.Value)
                estadoCivil = DbConvert.ToString(datarec["estadoCivil"]);
            if (DataRecord.HasColumn(datarec, "ofertaWeb") && datarec["ofertaWeb"] != DBNull.Value)
                ofertaWeb = DbConvert.ToString(datarec["ofertaWeb"]);
            if (DataRecord.HasColumn(datarec, "cataloVirtual") && datarec["cataloVirtual"] != DBNull.Value)
                cataloVirtual = DbConvert.ToString(datarec["cataloVirtual"]);

        }
    }
}
