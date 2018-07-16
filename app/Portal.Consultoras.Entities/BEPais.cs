using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPais
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public string NombreCorto { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string CodigoISOProd { get; set; }
        [DataMember]
        public int MarcaEnfoque { get; set; }

        public double ZonaHoraria { get; set; }
        public int DiasAntes { get; set; }
        public bool HabilitarRestriccionHoraria { get; set; }
        public int HorasDuracionRestriccion { get; set; }

        public string Mensajes { get; set; }

        public BEPais() { }
        public BEPais(IDataRecord row)
        {
            PaisID = Convert.ToInt32(row["PaisID"]);
            CodigoISO = Convert.ToString(row["CodigoISO"]);
            NombreCorto = Convert.ToString(row["NombreSimple"]);
            Nombre = Convert.ToString(row["NombreComplejo"]);

            if (DataRecord.HasColumn(row, "CodigoISOProd"))
                CodigoISOProd = Convert.ToString(row["CodigoISOProd"]);
            if (DataRecord.HasColumn(row, "ZonaHoraria"))
                ZonaHoraria = Convert.ToDouble(row["ZonaHoraria"]);
            if (DataRecord.HasColumn(row, "DiasAntes"))
                DiasAntes = Convert.ToInt32(row["DiasAntes"]);
            if (DataRecord.HasColumn(row, "HabilitarRestriccionHoraria"))
                HabilitarRestriccionHoraria = Convert.ToBoolean(row["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(row, "HorasDuracionRestriccion"))
                HorasDuracionRestriccion = Convert.ToInt32(row["HorasDuracionRestriccion"]);
            if (DataRecord.HasColumn(row, "Mensajes"))
                Mensajes = Convert.ToString(row["Mensajes"]);
        }
    }
}
