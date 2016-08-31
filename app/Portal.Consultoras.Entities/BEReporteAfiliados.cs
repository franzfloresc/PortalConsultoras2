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
    public class BEReporteAfiliados
    {
        [DataMember]
        private string CodigoConsultora { get; set; }
        [DataMember]
        private bool EsAfiliado { get; set; }
        [DataMember]
        private string CodigoUbigeo { get; set; }
        [DataMember]
        private string UnidadGeografica1 { get; set; }
        [DataMember]
        private string UnidadGeografica2 { get; set; }
        [DataMember]
        private string UnidadGeografica3 { get; set; }
        [DataMember]
        private string NombreCompleto { get; set; }
        [DataMember]
        private string Correo { get; set; }
        [DataMember]
        private int Edad { get; set; }
        [DataMember]
        private string Segmento { get; set; }
        [DataMember]
        private string AnoCampanaIngreso { get; set; }
        [DataMember]
        private DateTime FechaCreacion { get; set; }
        [DataMember]
        private DateTime FechaModificacion { get; set; }
        [DataMember]
        private string FechaCreacionString { get; set; }
        [DataMember]
        private string FechaModificacionString { get; set; }

        public BEReporteAfiliados(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = row["CodigoConsultora"].ToString();
            if (DataRecord.HasColumn(row, "EsAfiliado") && row["EsAfiliado"] != DBNull.Value)
                EsAfiliado = Convert.ToBoolean(row["EsAfiliado"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo") && row["CodigoUbigeo"] != DBNull.Value)
                CodigoUbigeo = row["CodigoUbigeo"].ToString();
            if (DataRecord.HasColumn(row, "UnidadGeografica1") && row["UnidadGeografica1"] != DBNull.Value)
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica2") && row["UnidadGeografica2"] != DBNull.Value)
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica3") && row["UnidadGeografica3"] != DBNull.Value)
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = row["NombreCompleto"].ToString();
            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "Edad") && row["Edad"] != DBNull.Value)
                Edad = Convert.ToInt32(row["Edad"]);
            if (DataRecord.HasColumn(row, "Segmento") && row["Segmento"] != DBNull.Value)
                Segmento = Convert.ToString(row["Segmento"]);
            if (DataRecord.HasColumn(row, "AnoCampanaIngreso") && row["AnoCampanaIngreso"] != DBNull.Value)
                AnoCampanaIngreso = row["AnoCampanaIngreso"].ToString();
            if (DataRecord.HasColumn(row, "FechaCreacion"))
                FechaCreacionString = row["FechaCreacion"].ToString();
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacionString = row["FechaModificacion"].ToString();
                
        } 


    }
}
