using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEscalaDescuento
    {
        [DataMember]
        public decimal MontoDesde { get; set; }
        [DataMember]
        [Column("MontoHasta")]
        public decimal MontoHasta { get; set; }
        [DataMember]
        [Column("PorDescuento")]
        public int PorDescuento { get; set; }
        [DataMember]
        public bool Seleccionado { get; set; }

        #region Para la tabla OfertaFinalParametria

        [DataMember]
        public string TipoParametriaOfertaFinal { get; set; }

        [DataMember]
        public decimal PrecioMinimo { get; set; }

        #endregion        

        public string Algoritmo { get; set; }

        public BEEscalaDescuento() { }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEEscalaDescuento(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "MontoDesde"))
                MontoDesde = Convert.ToDecimal(row["MontoDesde"]);
            if (DataRecord.HasColumn(row, "MontoHasta"))
                MontoHasta = Convert.ToDecimal(row["MontoHasta"]);
            if (DataRecord.HasColumn(row, "PorDescuento"))
                PorDescuento = Convert.ToInt32(row["PorDescuento"]);
            if (DataRecord.HasColumn(row, "TipoParametriaOfertaFinal"))
                TipoParametriaOfertaFinal = Convert.ToString(row["TipoParametriaOfertaFinal"]);
            if (DataRecord.HasColumn(row, "PrecioMinimo"))
                PrecioMinimo = Convert.ToDecimal(row["PrecioMinimo"]);
            if (DataRecord.HasColumn(row, "Algoritmo"))
                Algoritmo = Convert.ToString(row["Algoritmo"]);
        }
    }
}
