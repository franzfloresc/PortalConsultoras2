using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPaisDetalle : BaseEntidad
    {
        [DataMember]
        public int ConfiguracionPaisDetalleID { get; set; }
        [DataMember]
        public int ConfiguracionPaisID { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string CodigoSeccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEConfiguracionPaisDetalle() { }

        public BEConfiguracionPaisDetalle(IDataRecord row)
        {
            ConfiguracionPaisDetalleID = row.ToInt32("ConfiguracionPaisDetalleID");
            ConfiguracionPaisID = row.ToInt32("ConfiguracionPaisID");
            CodigoRegion = row.ToString("CodigoRegion");
            CodigoZona = row.ToString("CodigoZona");
            CodigoSeccion = row.ToString("CodigoSeccion");
            CodigoConsultora = row.ToString("CodigoConsultora");
            Estado = row.ToBoolean("Estado");
        }
    }
}
