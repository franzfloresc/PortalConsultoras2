﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoNivel
    {
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public int CodigoNivel { get; set; }
        [DataMember]
        public int PuntosNivel { get; set; }
        [DataMember]
        public int PuntosFaltantes { get; set; }
        [DataMember]
        public bool IndicadorPremiacionPedido { get; set; }
        [DataMember]
        public decimal MontoPremiacionPedido { get; set; }
        [DataMember]
        public bool IndicadorBelCenter { get; set; }
        [DataMember]
        public DateTime? FechaVentaRetail { get; set; }
        [DataMember]
        public bool IndicadorNivelElectivo { get; set; }
        [DataMember]
        public int PuntosExigidos { get; set; }
        [DataMember]
        public int PuntosExigidosFaltantes { get; set; }
        [DataMember]
        public string CodigoPremio { get; set; }
        [DataMember]
        public string DescripcionPremio { get; set; }

        public BEIncentivoNivel(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConcurso"))
                CodigoConcurso = Convert.ToString(row["CodigoConcurso"]);

            if (DataRecord.HasColumn(row, "CodigoNivel"))
                CodigoNivel = Convert.ToInt32(row["CodigoNivel"]);

            if (DataRecord.HasColumn(row, "PuntosNivel"))
                PuntosNivel = Convert.ToInt32(row["PuntosNivel"]);

            if (DataRecord.HasColumn(row, "PuntosFaltantes"))
                PuntosFaltantes = Convert.ToInt32(row["PuntosFaltantes"]);

            if (DataRecord.HasColumn(row, "IndicadorPremiacionPedido"))
                IndicadorPremiacionPedido = Convert.ToBoolean(row["IndicadorPremiacionPedido"]);

            if (DataRecord.HasColumn(row, "MontoPremiacionPedido"))
                MontoPremiacionPedido = Convert.ToDecimal(row["MontoPremiacionPedido"]);

            if (DataRecord.HasColumn(row, "IndicadorBelCenter"))
                IndicadorBelCenter = Convert.ToBoolean(row["IndicadorBelCenter"]);

            if (DataRecord.HasColumn(row, "FechaVentaRetail") && row["FechaVentaRetail"] != DBNull.Value)
                FechaVentaRetail = Convert.ToDateTime(row["FechaVentaRetail"]);

            if (DataRecord.HasColumn(row, "IndicadorNivelElectivo"))
                IndicadorNivelElectivo = Convert.ToBoolean(row["IndicadorNivelElectivo"]);

            if (DataRecord.HasColumn(row, "PuntosExigidos"))
                PuntosExigidos = Convert.ToInt32(row["PuntosExigidos"]);

            if (DataRecord.HasColumn(row, "PuntosExigidosFaltantes"))
                PuntosExigidosFaltantes = Convert.ToInt32(row["PuntosExigidosFaltantes"]);
        }
    }
}
