using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebDetalle
    {
        [DataMember]
        public int CDRWebDetalleID { get; set; }
        [DataMember]
        public int CDRWebID { get; set; }
        [DataMember]
        public string CodigoOperacion { get; set; }
        [DataMember]
        public string CodigoReclamo { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public string CUV2 { get; set; }
        [DataMember]
        public int Cantidad2 { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Observacion { get; set; }
        [DataMember]
        public bool Eliminado { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public decimal Precio { get; set; }

        [DataMember]
        public string Descripcion2 { get; set; }

        [DataMember]
        public decimal Precio2 { get; set; }

        [DataMember]
        public string Solicitud { get; set; }

        [DataMember]
        public string SolucionSolicitada { get; set; }

        public BECDRWebDetalle()
        { }

        public BECDRWebDetalle(IDataRecord row)
        {
            if (row.HasColumn("CDRWebDetalleID")) CDRWebDetalleID = Convert.ToInt32(row["CDRWebDetalleID"]);
            if (row.HasColumn("CDRWebID")) CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (row.HasColumn("CodigoOperacion")) CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (row.HasColumn("CodigoReclamo")) CodigoReclamo = Convert.ToString(row["CodigoReclamo"]);
            if (row.HasColumn("CUV")) CUV = Convert.ToString(row["CUV"]);
            if (row.HasColumn("Cantidad")) Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (row.HasColumn("CUV2")) CUV2 = Convert.ToString(row["CUV2"]);
            if (row.HasColumn("Cantidad2")) Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (row.HasColumn("FechaRegistro")) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToInt32(row["Estado"]);
            if (row.HasColumn("MotivoRechazo")) MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (row.HasColumn("Observacion")) Observacion = Convert.ToString(row["Observacion"]);
            if (row.HasColumn("Eliminado")) Eliminado = Convert.ToBoolean(row["Eliminado"]);
            if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Precio")) Precio = Convert.ToDecimal(row["Precio"]);
            if (row.HasColumn("Descripcion2")) Descripcion2 = Convert.ToString(row["Descripcion2"]);
            if (row.HasColumn("Precio2")) Precio2 = Convert.ToDecimal(row["Precio2"]);
            if (row.HasColumn("SolucionSolicitada")) SolucionSolicitada = Convert.ToString(row["SolucionSolicitada"]);            
        }
    }
}
