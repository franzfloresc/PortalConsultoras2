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
        [DataMember]
        public string Algoritmo { get; set; }
      
        public BEEscalaDescuento() { }
       
        [Obsolete("Use MapUtil.MapToCollection")]
        public BEEscalaDescuento(IDataRecord row)
        {
            MontoDesde = DataRecord.GetColumn<decimal>(row, "MontoDesde");
            MontoHasta = DataRecord.GetColumn<decimal>(row, "MontoHasta");
            PorDescuento = DataRecord.GetColumn<int>(row, "PorDescuento");
            TipoParametriaOfertaFinal = DataRecord.GetColumn<string>(row, "TipoParametriaOfertaFinal");
            PrecioMinimo = DataRecord.GetColumn<decimal>(row, "PrecioMinimo");
            Algoritmo = DataRecord.GetColumn<string>(row, "Algoritmo");
        }



    }
}
