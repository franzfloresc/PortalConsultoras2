using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "EsAfiliado"))
                EsAfiliado = Convert.ToBoolean(row["EsAfiliado"]);
            if (DataRecord.HasColumn(row, "CodigoUbigeo"))
                CodigoUbigeo = Convert.ToString(row["CodigoUbigeo"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica1"))
                UnidadGeografica1 = Convert.ToString(row["UnidadGeografica1"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica2"))
                UnidadGeografica2 = Convert.ToString(row["UnidadGeografica2"]);
            if (DataRecord.HasColumn(row, "UnidadGeografica3"))
                UnidadGeografica3 = Convert.ToString(row["UnidadGeografica3"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "Edad"))
                Edad = Convert.ToInt32(row["Edad"]);
            if (DataRecord.HasColumn(row, "Segmento"))
                Segmento = Convert.ToString(row["Segmento"]);
            if (DataRecord.HasColumn(row, "AnoCampanaIngreso"))
                AnoCampanaIngreso = Convert.ToString(row["AnoCampanaIngreso"]);
            if (DataRecord.HasColumn(row, "FechaCreacion"))
                FechaCreacionString = Convert.ToString(row["FechaCreacion"]);
            if (DataRecord.HasColumn(row, "FechaModificacion"))
                FechaModificacionString = Convert.ToString(row["FechaModificacion"]);

        }


    }
}
