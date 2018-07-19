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
            FactorGananciaID = row.ToInt32("FactorGananciaID");
            PaisID = row.ToInt32("PaisID");
            PaisNombre = row.ToString("Nombre");
            RangoMinimo = row.ToDecimal("RangoMinimo");
            RangoMaximo = row.ToDecimal("RangoMaximo");
            Porcentaje = row.ToDecimal("Porcentaje");
            Escala = row.ToInt32("Escala");
        }
    }
}
