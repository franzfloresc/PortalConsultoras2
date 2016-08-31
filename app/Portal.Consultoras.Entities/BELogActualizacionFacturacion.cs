using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
            if (DataRecord.HasColumn(row, "TipoRegistro") && row["TipoRegistro"] != DBNull.Value)
                TipoRegistro = Convert.ToString(row["TipoRegistro"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "Fecha") && row["Fecha"] != DBNull.Value)
                Fecha = Convert.ToString(row["Fecha"]);
            if (DataRecord.HasColumn(row, "CodigosZonaRegion") && row["CodigosZonaRegion"] != DBNull.Value)
                CodigosZonaRegion = Convert.ToString(row["CodigosZonaRegion"]);
            if (DataRecord.HasColumn(row, "CodigosZonaRegionIncompleto") && row["CodigosZonaRegionIncompleto"] != DBNull.Value)
                CodigosZonaRegionIncompleto = Convert.ToString(row["CodigosZonaRegionIncompleto"]);
            if (DataRecord.HasColumn(row, "FechaFacturacion") && row["FechaFacturacion"] != DBNull.Value)
                FechaFacturacion = Convert.ToString(row["FechaFacturacion"]);
            if (DataRecord.HasColumn(row, "FechaFinFacturacion") && row["FechaFinFacturacion"] != DBNull.Value)
                FechaFinFacturacion = Convert.ToString(row["FechaFinFacturacion"]);
            if (DataRecord.HasColumn(row, "FechaRefacturacion") && row["FechaRefacturacion"] != DBNull.Value)
                FechaRefacturacion = Convert.ToString(row["FechaRefacturacion"]);
            if (DataRecord.HasColumn(row, "Mensaje") && row["Mensaje"] != DBNull.Value)
                Mensaje = Convert.ToString(row["Mensaje"]);
            if (DataRecord.HasColumn(row, "CampaniaCodigo") && row["CampaniaCodigo"] != DBNull.Value)
                CampaniaCodigo = Convert.ToString(row["CampaniaCodigo"]);
        }
    }
}
