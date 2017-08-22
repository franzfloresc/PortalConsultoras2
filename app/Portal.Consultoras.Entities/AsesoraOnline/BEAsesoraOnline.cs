using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.AsesoraOnline
{
    [DataContract]
    public class BEAsesoraOnline
    {
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string FechaCreacion { get; set; }
        [DataMember]
        public string FechaModificacion { get; set; }
        [DataMember]
        public string Origen { get; set; }
        [DataMember]
        public int TipsVentas { get; set; }
        [DataMember]
        public int TipsGestionClientes { get; set; }
        [DataMember]
        public int MasCatalogos { get; set; }
        [DataMember]
        public int TipsMasClientes { get; set; }

        public BEAsesoraOnline(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = row["CodigoConsultora"] == null ? String.Empty : Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "TipsVentas") && row["TipsVentas"] != DBNull.Value)
                TipsVentas = row["TipsVentas"] == null ? 0 : Convert.ToInt32(row["TipsVentas"]);

            if (DataRecord.HasColumn(row, "TipsGestionClientes") && row["TipsGestionClientes"] != DBNull.Value)
                TipsGestionClientes = row["TipsGestionClientes"] == null ? 0 : Convert.ToInt32(row["TipsGestionClientes"]);

            if (DataRecord.HasColumn(row, "MasCatalogos") && row["MasCatalogos"] != DBNull.Value)
                MasCatalogos = row["MasCatalogos"] == null ? 0 : Convert.ToInt32(row["MasCatalogos"]);

            if (DataRecord.HasColumn(row, "TipsMasClientes") && row["TipsMasClientes"] != DBNull.Value)
                TipsMasClientes = row["TipsMasClientes"] == null ? 0 : Convert.ToInt32(row["TipsMasClientes"]);

        }
    }
}
