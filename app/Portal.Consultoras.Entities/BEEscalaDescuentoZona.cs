using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEscalaDescuentoZona : BEEscalaDescuento
    {
        [DataMember]
        public string CampaniaId { get; set; }
        [DataMember]
        public string CodRegion { get; set; }
        [DataMember]
        public string CodZona { get; set; }
        [DataMember]
        public DateTime? FechaCarga { get; set; }
        [DataMember]
        public string NameDocumento
        {
            get
            {
                return CodZona == null ? string.Empty : string.Format("{0}_{1}", CodRegion, CodZona);
            }
            set { NameDocumento = value; }
        }

        public BEEscalaDescuentoZona()
        {
            CampaniaId = default(string);
            CodRegion = default(string);
            CodZona = default(string);
            MontoHasta = default(decimal);
            PorDescuento = default(Int32);
            FechaCarga = default(DateTime);
        }
       
        public BEEscalaDescuentoZona(IDataRecord row)
        {
            CampaniaId = DataRecord.GetColumn<string>(row, "CampaniaId");
            CodRegion = DataRecord.GetColumn<string>(row, "CodRegion");
            CodZona = DataRecord.GetColumn<string>(row, "CodZona");
            FechaCarga = DataRecord.GetColumn<DateTime>(row, "FechaCarga");
            MontoDesde = DataRecord.GetColumn<decimal>(row, "MontoDesde");
            MontoHasta = DataRecord.GetColumn<decimal>(row, "MontoHasta");
            PorDescuento = DataRecord.GetColumn<int>(row, "PorDescuento");
            PrecioMinimo = DataRecord.GetColumn<decimal>(row, "PrecioMinimo");

        }

        public BEEscalaDescuento GetEscalaDescuento(IDataRecord row)
        {
            BEEscalaDescuento ent = new BEEscalaDescuento
            {
                MontoDesde = DataRecord.GetColumn<decimal>(row, "MontoDesde"),
                MontoHasta = DataRecord.GetColumn<decimal>(row, "MontoHasta"),
                PorDescuento = DataRecord.GetColumn<int>(row, "PorDescuento"),
                TipoParametriaOfertaFinal = DataRecord.GetColumn<string>(row, "TipoParametriaOfertaFinal"),
                PrecioMinimo = DataRecord.GetColumn<decimal>(row, "PrecioMinimo"),
                Algoritmo = DataRecord.GetColumn<string>(row, "Algoritmo"),

            };
            return ent;
        }

    }
}
