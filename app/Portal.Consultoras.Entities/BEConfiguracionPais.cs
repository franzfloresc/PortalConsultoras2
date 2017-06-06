using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPais : BaseEntidad
    {
        [DataMember]
        public int ConfiguracionPaisID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public bool Excluyente { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        [DataMember]
        public BEConfiguracionPaisDetalle Detalle  { get; set; }

        public BEConfiguracionPais() {
            Detalle = new BEConfiguracionPaisDetalle();
        }

        public BEConfiguracionPais(IDataRecord row)
        {
            if (row.HasColumn("ConfiguracionPaisID")) ConfiguracionPaisID = Convert.ToInt32(row["ConfiguracionPaisID"]);
            if (row.HasColumn("Codigo")) Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Excluyente")) Excluyente = Convert.ToBoolean(row["Excluyente"]);
            if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToBoolean(row["Estado"]);
            Detalle = new BEConfiguracionPaisDetalle();
        }
    }
}
