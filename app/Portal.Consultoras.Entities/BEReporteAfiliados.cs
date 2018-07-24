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
            CodigoConsultora = row.ToString("CodigoConsultora");
            EsAfiliado = row.ToBoolean("EsAfiliado");
            CodigoUbigeo = row.ToString("CodigoUbigeo");
            UnidadGeografica1 = row.ToString("UnidadGeografica1");
            UnidadGeografica2 = row.ToString("UnidadGeografica2");
            UnidadGeografica3 = row.ToString("UnidadGeografica3");
            NombreCompleto = row.ToString("NombreCompleto");
            Correo = row.ToString("Correo");
            Edad = row.ToInt32("Edad");
            Segmento = row.ToString("Segmento");
            AnoCampanaIngreso = row.ToString("AnoCampanaIngreso");
            FechaCreacionString = row.ToString("FechaCreacion");
            FechaModificacionString = row.ToString("FechaModificacion");
        }


    }
}
