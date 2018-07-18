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
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            CodigoOferta = row.ToString("CodigoOferta");
            Descripcion = row.ToString("Descripcion");
            EstadoRegistro = row.ToInt32("EstadoRegistro");
        }
    }
}
