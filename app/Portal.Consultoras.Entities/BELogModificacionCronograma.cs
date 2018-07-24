using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogModificacionCronograma
    {
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigosRegionZona { get; set; }
        [DataMember]
        public Int16 DiasDuracionCronogramaAnterior { get; set; }
        [DataMember]
        public Int16 DiasDuracionCronogramaActual { get; set; }

        public BELogModificacionCronograma(IDataRecord row)
        {
            Fecha = row.ToString("Fecha");
            CodigoUsuario = row.ToString("CodigoUsuario");
            CodigosRegionZona = row.ToString("CodigosRegionZona");
            DiasDuracionCronogramaAnterior = row.ToInt16("DiasDuracionCronogramaAnterior");
            DiasDuracionCronogramaActual = row.ToInt16("DiasDuracionCronogramaActual");
        }
    }
}
