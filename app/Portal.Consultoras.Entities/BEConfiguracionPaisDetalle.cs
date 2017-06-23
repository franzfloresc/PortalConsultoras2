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
            if (row.HasColumn("ConfiguracionPaisDetalleID")) ConfiguracionPaisDetalleID = Convert.ToInt32(row["ConfiguracionPaisDetalleID"]);
            if (row.HasColumn("ConfiguracionPaisID")) ConfiguracionPaisID = Convert.ToInt32(row["ConfiguracionPaisID"]);
            if (row.HasColumn("CodigoRegion")) CodigoRegion = Convert.ToString(row["CodigoRegion"]);
            if (row.HasColumn("CodigoZona")) CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (row.HasColumn("CodigoSeccion")) CodigoSeccion = Convert.ToString(row["CodigoSeccion"]);
            if (row.HasColumn("CodigoConsultora")) CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToBoolean(row["Estado"]);
        }
    }
}
