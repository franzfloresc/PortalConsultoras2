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
            MontoDesde = row.ToDecimal("MontoDesde");
            MontoHasta = row.ToDecimal("MontoHasta");
            PorDescuento = row.ToInt32("PorDescuento");
            TipoParametriaOfertaFinal = row.ToString("TipoParametriaOfertaFinal");
            PrecioMinimo = row.ToDecimal("PrecioMinimo");
            Algoritmo = row.ToString("Algoritmo");
        }
    }
}
