using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "CodigoOferta"))
                CodigoOferta = Convert.ToString(row["CodigoOferta"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "EstadoRegistro"))
                EstadoRegistro = Convert.ToInt32(row["EstadoRegistro"]);
        }
    }
}
