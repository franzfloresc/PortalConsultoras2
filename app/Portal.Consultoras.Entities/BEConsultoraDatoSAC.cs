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

        public BEConsultoraDatoSAC(IDataRecord row)
        {
            consultoraID = row.ToInt32("consultoraID");
            codigo = row.ToString("codigo");
            nombreCompleto = row.ToString("nombreCompleto");
            seccion = row.ToString("seccion");
            zona = row.ToString("zona");
            region = row.ToString("region");
            direccionDomicilio = row.ToString("direccionDomicilio");
            direccionEntrega = row.ToString("direccionEntrega");
            telefono1 = row.ToString("telefono1");
            telefono2 = row.ToString("telefono2");
            email = row.ToString("email");
            validoEmail = row.ToString("validoEmail");
            fechaNacimiento = row.ToString("fechaNacimiento");
            estadoCivil = row.ToString("estadoCivil");
            ofertaWeb = row.ToString("ofertaWeb");
            cataloVirtual = row.ToString("cataloVirtual");
        }
    }
}
