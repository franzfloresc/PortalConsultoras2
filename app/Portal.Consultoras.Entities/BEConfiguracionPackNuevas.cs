using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPackNuevas
    {
        [DataMember]
        public int ConfiguracionPackID { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public string PedidoAsociado { get; set; }

        public BEConfiguracionPackNuevas(IDataRecord row)
        {
            CodigoPrograma = row.ToString("CodigoPrograma");
            PedidoAsociado = row.ToString("PedidoAsociado");
        }
    }

}
