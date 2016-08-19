using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionOferta
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public string CodigoOferta { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int EstadoRegistro { get; set; }


        public BEConfiguracionOferta(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "CodigoOferta") && row["CodigoOferta"] != DBNull.Value)
                CodigoOferta = Convert.ToString(row["CodigoOferta"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "EstadoRegistro") && row["EstadoRegistro"] != DBNull.Value)
                EstadoRegistro = Convert.ToInt32(row["EstadoRegistro"]);
        }
    }
}
