using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECronograma
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public Int16 TipoCronogramaID { get; set; }

        [DataMember]
        public DateTime? FechaInicioWeb { get; set; }

        [DataMember]
        public DateTime? FechaFinWeb { get; set; }

        [DataMember]
        public DateTime? FechaInicioDD { get; set; }

        [DataMember]
        public DateTime? FechaFinDD { get; set; }

        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }


        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string ZonaNombre { get; set; }


        [DataMember]
        public string CodigoZona { get; set; }

        [DataMember]
        public string CodigoCampania { get; set; }

        public BECronograma()
        { }

        public BECronograma(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            ZonaID = row.ToInt32("ZonaID");
            PaisID = row.ToInt16("PaisID");
            TipoCronogramaID = row.ToInt16("TipoCronogramaID");
            FechaInicioWeb = row.ToDateTime("FechaInicioWeb");
            FechaFinWeb = row.ToDateTime("FechaFinWeb");
            FechaInicioDD = row.ToDateTime("FechaInicioDD");
            FechaFinDD = row.ToDateTime("FechaFinDD");
            ZonaNombre = row.ToString("ZonaNombre");
            CodigoZona = row.ToString("CodigoZona");
        }
    }

    [DataContract]
    public class Cronograma
    {

        [DataMember]
        public string Zona { get; set; }

        [DataMember]
        public DateTime FechaFacturacion { get; set; }

        [DataMember]
        public DateTime FechaRefacturacion { get; set; }

        [DataMember]
        public string Campania { get; set; }

        public Cronograma()
        {

        }

        public Cronograma(IDataRecord row)
        {
            Zona = Convert.ToString(row["Zona"]);
            FechaFacturacion = Convert.ToDateTime(row["FechaFacturacion"]);
            FechaRefacturacion = Convert.ToDateTime(row["FechaRefacturacion"]);
            Campania = Convert.ToString(row["Campania"]);
        }
    }
}
