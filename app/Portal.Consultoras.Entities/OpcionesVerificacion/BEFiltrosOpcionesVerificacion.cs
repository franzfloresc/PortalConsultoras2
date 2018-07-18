using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.OpcionesVerificacion
{
    [DataContract]
    public class BEFiltrosOpcionesVerificacion
    {
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public int CampaniaInicio { get; set; }
        [DataMember]
        public int CampaniaFinal { get; set; }
        [DataMember]
        public string  MensajeSaludo { get; set; }

        public BEFiltrosOpcionesVerificacion()
        { }

        public BEFiltrosOpcionesVerificacion(IDataRecord row)
        {
            IdEstadoActividad = row.ToInt32("IdEstadoActividad");
            CampaniaInicio = row.ToInt32("CampaniaInicio");
            CampaniaFinal = row.ToInt32("CampaniaFinal");
            MensajeSaludo = row.ToString("MensajeSaludo");
        }
    }
}
