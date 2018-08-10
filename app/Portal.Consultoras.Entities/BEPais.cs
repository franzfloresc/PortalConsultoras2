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
            PaisID = row.ToInt32("PaisID");
            CodigoISO = row.ToString("CodigoISO");
            NombreCorto = row.ToString("NombreSimple");
            Nombre = row.ToString("NombreComplejo");
            CodigoISOProd = row.ToString("CodigoISOProd");
            ZonaHoraria = row.ToDouble("ZonaHoraria");
            DiasAntes = row.ToInt32("DiasAntes");
            HabilitarRestriccionHoraria = row.ToBoolean("HabilitarRestriccionHoraria");
            HorasDuracionRestriccion = row.ToInt32("HorasDuracionRestriccion");
            Mensajes = row.ToString("Mensajes");
        }
    }
}
