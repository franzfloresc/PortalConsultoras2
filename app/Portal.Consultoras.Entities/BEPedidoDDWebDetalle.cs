﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoDDWebDetalle
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public Int32 Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public decimal PrecioTotal { get; set; }
        [DataMember]
        public Int32 PedidoDetalleID { get; set; }
        [DataMember]
        public bool IndicadorDigitable { get; set; }
        [DataMember]
        public bool IndicadorMontoMinimo { get; set; }
        [DataMember]
        public bool IndicadorFaltanteAnunciado { get; set; }
        [DataMember]
        public bool IndicadorPromocion { get; set; }
        [DataMember]
        public string UsuarioResponsable { get; set; }
        [DataMember]  // R20151003 - Inicio
        public bool IndicadorEnviado { get; set; }
        [DataMember]
        public DateTime FechaEnvio { get; set; }  // R20151003 - Fin
        //SB20-871
        [DataMember]
        public string MotivoRechazo { get; set; }
        public BEPedidoDDWebDetalle()
        { }

        public BEPedidoDDWebDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);
            if (DataRecord.HasColumn(row, "PrecioTotal"))
                PrecioTotal = Convert.ToDecimal(row["PrecioTotal"]);
            if (DataRecord.HasColumn(row, "IndicadorDigitable") && row["IndicadorDigitable"] != DBNull.Value)
                IndicadorDigitable = Convert.ToBoolean(row["IndicadorDigitable"]);
            if (DataRecord.HasColumn(row, "IndicadorMontoMinimo") && row["IndicadorMontoMinimo"] != DBNull.Value)
                IndicadorMontoMinimo = Convert.ToBoolean(row["IndicadorMontoMinimo"]);
            if (DataRecord.HasColumn(row, "IndicadorFaltanteAnunciado") && row["IndicadorFaltanteAnunciado"] != DBNull.Value)
                IndicadorFaltanteAnunciado = Convert.ToBoolean(row["IndicadorFaltanteAnunciado"]);
            if (DataRecord.HasColumn(row, "IndicadorPromocion") && row["IndicadorPromocion"] != DBNull.Value)
                IndicadorPromocion = Convert.ToBoolean(row["IndicadorPromocion"]);
            if (DataRecord.HasColumn(row, "UsuarioResponsable") && row["UsuarioResponsable"] != DBNull.Value)
                UsuarioResponsable = Convert.ToString(row["UsuarioResponsable"]);
            if (DataRecord.HasColumn(row, "PedidoDetalleID") && row["PedidoDetalleID"] != DBNull.Value)
                PedidoDetalleID = Convert.ToInt32(row["PedidoDetalleID"]);
            if (DataRecord.HasColumn(row, "IndicadorEnviado") && row["IndicadorEnviado"] != DBNull.Value) // R20151003 - Inicio
                IndicadorEnviado = Convert.ToBoolean(row["IndicadorEnviado"]);
            if (DataRecord.HasColumn(row, "FechaEnvio") && row["FechaEnvio"] != DBNull.Value)
                FechaEnvio = Convert.ToDateTime(row["FechaEnvio"]);  // R20151003 - Fin
            // SB20-871
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
        }
    }
}
