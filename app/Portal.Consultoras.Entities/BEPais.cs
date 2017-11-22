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
            CodigoISO = row["CodigoISO"].ToString();
            NombreCorto = row["NombreSimple"].ToString();
            Nombre = row["NombreComplejo"].ToString();

            if (DataRecord.HasColumn(row, "CodigoISOProd") && row["CodigoISOProd"] != DBNull.Value)
                CodigoISOProd = row["CodigoISOProd"].ToString();
            if (DataRecord.HasColumn(row, "ZonaHoraria") && row["ZonaHoraria"] != DBNull.Value)
                ZonaHoraria = Convert.ToDouble(row["ZonaHoraria"]);
            if (DataRecord.HasColumn(row, "DiasAntes") && row["DiasAntes"] != DBNull.Value)
                DiasAntes = Convert.ToInt32(row["DiasAntes"]);
            if (DataRecord.HasColumn(row, "HabilitarRestriccionHoraria") && row["HabilitarRestriccionHoraria"] != DBNull.Value)
                HabilitarRestriccionHoraria = Convert.ToBoolean(row["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(row, "HorasDuracionRestriccion") && row["HorasDuracionRestriccion"] != DBNull.Value)
                HorasDuracionRestriccion = Convert.ToInt32(row["HorasDuracionRestriccion"]);
            if (DataRecord.HasColumn(row, "Mensajes") && row["Mensajes"] != DBNull.Value)
                Mensajes = row["Mensajes"].ToString();
        }
    }
}