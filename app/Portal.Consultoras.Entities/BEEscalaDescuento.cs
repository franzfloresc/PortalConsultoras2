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
        [DataMember]
        public string Algoritmo { get; set; }

        #region Para la tabla OfertaFinalParametria

        [DataMember]
        public string TipoParametriaOfertaFinal { get; set; }

        [DataMember]
        public decimal PrecioMinimo { get; set; }

        #endregion

        #region Escala Descuento Zona

        [DataMember]
        public string CampaniaId { get; set; }
        [DataMember]
        public string CodRegion { get; set; }
        [DataMember]
        public string CodZona { get; set; }
        [DataMember]
        public DateTime? FechaCarga { get; set; }
        [DataMember]
        public string NameDocumento { get; set; }
      
        #endregion


        public BEEscalaDescuento()
        {
            CampaniaId = default(string);
            CodRegion = default(string);
            CodZona = default(string);
            MontoHasta = default(decimal);
            PorDescuento = default(Int32);
            FechaCarga = default(DateTime);
            NameDocumento = default(string);
        }

        public BEEscalaDescuento(IDataRecord row)
        {
            CampaniaId = DataRecord.GetColumn<string>(row, "CampaniaId");
            CodRegion = DataRecord.GetColumn<string>(row, "CodRegion");
            CodZona = DataRecord.GetColumn<string>(row, "CodZona");
            FechaCarga = DataRecord.GetColumn<DateTime>(row, "FechaCarga");
            MontoDesde = DataRecord.GetColumn<decimal>(row, "MontoDesde");
            MontoHasta = DataRecord.GetColumn<decimal>(row, "MontoHasta");
            PorDescuento = DataRecord.GetColumn<int>(row, "PorDescuento");

            TipoParametriaOfertaFinal = DataRecord.GetColumn<string>(row, "TipoParametriaOfertaFinal");
            PrecioMinimo = DataRecord.GetColumn<decimal>(row, "PrecioMinimo");
            Algoritmo = DataRecord.GetColumn<string>(row, "Algoritmo");
            Seleccionado = DataRecord.GetColumn<bool>(row, "Seleccionado");

            if (!string.IsNullOrEmpty(CodRegion) || !string.IsNullOrEmpty(CodZona))
                NameDocumento = string.Format("{0}_{1}", CodRegion, CodZona);
        }
    }
}
