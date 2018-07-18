using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogConfiguracionCronograma
    {
        [DataMember]
        public string FechaRegistro { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public int CodigoZona { get; set; }
        [DataMember]
        public int CodigoRegion { get; set; }
        [DataMember]
        public Int16 DiasDuracionAnterior { get; set; }
        [DataMember]
        public Int16 DiasDuracionActual { get; set; }

        public BELogConfiguracionCronograma(IDataRecord row)
        {
            FechaRegistro = row.ToString("FechaRegistro");
            CodigoUsuario = row.ToString("CodigoUsuario");
            CodigoRegion = row.ToInt16("CodigoRegion");
            CodigoZona = row.ToInt16("CodigoZona");
            DiasDuracionAnterior = row.ToInt16("DiasDuracionAnterior");
            DiasDuracionActual = row.ToInt16("DiasDuracionActual");
        }
    }

}
