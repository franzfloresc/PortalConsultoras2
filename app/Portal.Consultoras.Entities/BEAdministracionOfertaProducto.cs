using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEAdministracionOfertaProducto
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int OfertaAdmID { get; set; }
        [DataMember]
        public string Correos { get; set; }
        [DataMember]
        public int StockMinimo { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BEAdministracionOfertaProducto(IDataRecord row)
        {
            OfertaAdmID = row.ToInt32("OfertaAdmID");
            Correos = row.ToString("Correos");
            StockMinimo = row.ToInt32("StockMinimo");
        }
    }
}
