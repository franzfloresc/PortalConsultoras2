using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFactorGanancia
    {
        [DataMember]
        public int FactorGananciaID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public string PaisNombre { set; get; }
        [DataMember]
        public decimal RangoMinimo { set; get; }
        [DataMember]
        public decimal RangoMaximo { set; get; }
        [DataMember]
        public decimal Porcentaje { set; get; }
        [DataMember]
        public int Escala { set; get; }

        public BEFactorGanancia() { }
        public BEFactorGanancia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "FactorGananciaID"))
                FactorGananciaID = Convert.ToInt32(row["FactorGananciaID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                PaisNombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "RangoMinimo"))
                RangoMinimo = Convert.ToDecimal(row["RangoMinimo"]);
            if (DataRecord.HasColumn(row, "RangoMaximo"))
                RangoMaximo = Convert.ToDecimal(row["RangoMaximo"]);
            if (DataRecord.HasColumn(row, "Porcentaje"))
                Porcentaje = Convert.ToDecimal(row["Porcentaje"]);
            if (DataRecord.HasColumn(row, "Escala"))
                Escala = Convert.ToInt32(row["Escala"]);
        }
    }
}
