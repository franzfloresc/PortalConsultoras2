using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogActualizacionFacturacion
    {
        [DataMember]
        public string TipoRegistro { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string CodigosZonaRegion { get; set; }
        [DataMember]
        public string CodigosZonaRegionIncompleto { get; set; }
        [DataMember]
        public string FechaFacturacion { get; set; }
        [DataMember]
        public string FechaFinFacturacion { get; set; }
        [DataMember]
        public string FechaRefacturacion { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string CampaniaCodigo { get; set; }

        public BELogActualizacionFacturacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "TipoRegistro"))
                TipoRegistro = Convert.ToString(row["TipoRegistro"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToString(row["Fecha"]);
            if (DataRecord.HasColumn(row, "CodigosZonaRegion"))
                CodigosZonaRegion = Convert.ToString(row["CodigosZonaRegion"]);
            if (DataRecord.HasColumn(row, "CodigosZonaRegionIncompleto"))
                CodigosZonaRegionIncompleto = Convert.ToString(row["CodigosZonaRegionIncompleto"]);
            if (DataRecord.HasColumn(row, "FechaFacturacion"))
                FechaFacturacion = Convert.ToString(row["FechaFacturacion"]);
            if (DataRecord.HasColumn(row, "FechaFinFacturacion"))
                FechaFinFacturacion = Convert.ToString(row["FechaFinFacturacion"]);
            if (DataRecord.HasColumn(row, "FechaRefacturacion"))
                FechaRefacturacion = Convert.ToString(row["FechaRefacturacion"]);
            if (DataRecord.HasColumn(row, "Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);
            if (DataRecord.HasColumn(row, "CampaniaCodigo"))
                CampaniaCodigo = Convert.ToString(row["CampaniaCodigo"]);
        }
    }
}
