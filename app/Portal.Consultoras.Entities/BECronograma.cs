using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

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
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt16(row["PaisID"]);
            if (DataRecord.HasColumn(row, "TipoCronogramaID"))
                TipoCronogramaID = Convert.ToInt16(row["TipoCronogramaID"]);
            if (DataRecord.HasColumn(row, "FechaInicioWeb"))
                FechaInicioWeb = Convert.ToDateTime(row["FechaInicioWeb"]);
            if (DataRecord.HasColumn(row, "FechaFinWeb"))
                FechaFinWeb = Convert.ToDateTime(row["FechaFinWeb"]);
            if (DataRecord.HasColumn(row, "FechaInicioDD"))
                FechaInicioDD = Convert.ToDateTime(row["FechaInicioDD"]);
            if (DataRecord.HasColumn(row, "FechaFinDD"))
                FechaFinDD = Convert.ToDateTime(row["FechaFinDD"]);
            if (DataRecord.HasColumn(row, "ZonaNombre"))
                ZonaNombre = Convert.ToString(row["ZonaNombre"]);
            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            
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
