﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Runtime.Serialization;
using Portal.Consultoras.Common;
using System.Data;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMiCertificado
    {
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string NumeroSecuencial { get; set; }
        //[DataMember]
        //public DateTime FechaCreacion { get; set; }
        [DataMember]
        public string Ciudad { get; set; }
        [DataMember]
        public string Asunto { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string TipoDocumento { get; set; }
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public string DescripcionEstado { get; set; }
        [DataMember]
        public DateTime FechaIngresoConsultora { get; set; }
        [DataMember]
        public decimal PromedioVentas { get; set; }
        [DataMember]
        public string RazonSocial { get; set; }
        [DataMember]
        public string Ruc { get; set; }
        //[DataMember]
        //public string FechaCreacionTexto { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string UrlFirma { get; set; }
        [DataMember]
        public string Responsable { get; set; }
        [DataMember]
        public string Cargo { get; set; }
        [DataMember]
        public Int16 TipoCertificado { get; set; }
        [DataMember]
        public Int16 NumeroVeces { get; set; }

        public BEMiCertificado()
        {
        }

        public BEMiCertificado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToInt32(row["Campania"]);
            if (DataRecord.HasColumn(row, "NumeroSecuencial"))
                NumeroSecuencial = Convert.ToString(row["NumeroSecuencial"]);
            if (DataRecord.HasColumn(row, "Ciudad"))
                Ciudad = Convert.ToString(row["Ciudad"]);
            if (DataRecord.HasColumn(row, "Asunto"))
                Asunto = Convert.ToString(row["Asunto"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "TipoDocumento"))
                TipoDocumento = Convert.ToString(row["TipoDocumento"]);
            if (DataRecord.HasColumn(row, "NumeroDocumento"))
                NumeroDocumento = Convert.ToString(row["NumeroDocumento"]);
            if (DataRecord.HasColumn(row, "DescripcionEstado"))
                DescripcionEstado = Convert.ToString(row["DescripcionEstado"]);
            if (DataRecord.HasColumn(row, "FechaIngresoConsultora"))
                FechaIngresoConsultora = Convert.ToDateTime(row["FechaIngresoConsultora"]);
            if (DataRecord.HasColumn(row, "PromedioVentas"))
                PromedioVentas = Convert.ToDecimal(row["PromedioVentas"]);
            if (DataRecord.HasColumn(row, "RazonSocial"))
                RazonSocial = Convert.ToString(row["RazonSocial"]);
            if (DataRecord.HasColumn(row, "Ruc"))
                Ruc = Convert.ToString(row["Ruc"]);
            if (DataRecord.HasColumn(row, "Telefono"))
                Telefono = Convert.ToString(row["Telefono"]);
            if (DataRecord.HasColumn(row, "UrlFirma"))
                UrlFirma = Convert.ToString(row["UrlFirma"]);
            if (DataRecord.HasColumn(row, "Responsable"))
                Responsable = Convert.ToString(row["Responsable"]);
            if (DataRecord.HasColumn(row, "Cargo"))
                Cargo = Convert.ToString(row["Cargo"]);
            if (DataRecord.HasColumn(row, "TipoCertificado"))
                TipoCertificado = Convert.ToInt16(row["TipoCertificado"]);
            if (DataRecord.HasColumn(row, "NumeroVeces"))
                NumeroVeces = Convert.ToInt16(row["NumeroVeces"]);

        }
    }

}
