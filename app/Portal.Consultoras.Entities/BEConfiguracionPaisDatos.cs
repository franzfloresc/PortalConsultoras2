using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPaisDatos : BaseEntidad
    {
        [DataMember]
        public int ConfiguracionPaisID { get; set; }
        [DataMember]
        public BEConfiguracionPais ConfiguracionPais { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string Componente { get; set; }
        [DataMember]
        public string Valor1 { get; set; }
        [DataMember]
        public string Valor2 { get; set; }
        [DataMember]
        public string Valor3 { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEConfiguracionPaisDatos() { }

        public BEConfiguracionPaisDatos(IDataRecord row)
        {
            if (row.HasColumn("ConfiguracionPaisID")) ConfiguracionPaisID = Convert.ToInt32(row["ConfiguracionPaisID"]);
            if (row.HasColumn("Codigo")) Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("CampaniaID")) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (row.HasColumn("Valor1")) Valor1 = Convert.ToString(row["Valor1"]);
            if (row.HasColumn("Valor2")) Valor2 = Convert.ToString(row["Valor2"]);
            if (row.HasColumn("Valor3")) Valor3 = Convert.ToString(row["Valor3"]);
            if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToBoolean(row["Estado"]);
        }
    }
}
