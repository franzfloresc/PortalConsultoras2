using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioExternoPais
    {
        [DataMember]
        public string Proveedor { get; set; }

        [DataMember]
        public string IdAplicacion { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        public BEUsuarioExternoPais()
        {

        }

        public BEUsuarioExternoPais(IDataRecord row)
        {
            Proveedor = row.ToString("Proveedor");
            IdAplicacion = row.ToString("IdAplicacion");
            PaisID = row.ToInt16("PaisID");
            CodigoISO = row.ToString("CodigoISO");
        }

    }
}
