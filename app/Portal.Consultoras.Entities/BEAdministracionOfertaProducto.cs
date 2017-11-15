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
            if (DataRecord.HasColumn(row, "OfertaAdmID") && row["OfertaAdmID"] != DBNull.Value)
                OfertaAdmID = Convert.ToInt32(row["OfertaAdmID"]);
            if (DataRecord.HasColumn(row, "Correos") && row["Correos"] != DBNull.Value)
                Correos = Convert.ToString(row["Correos"]);
            if (DataRecord.HasColumn(row, "StockMinimo") && row["StockMinimo"] != DBNull.Value)
                StockMinimo = Convert.ToInt32(row["StockMinimo"]);
        }
    }
}
