using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBuscadorYFiltrosConfiguracion
    {
        [DataMember]
        public bool MostrarBuscador { get; set; }
        [DataMember]
        public short CaracteresBuscador { get; set; }
        [DataMember]
        public short CaracteresBuscadorMostrar { get; set; }
        [DataMember]
        public short TotalResultadosBuscador { get; set; }
        [DataMember]
        public bool IndicadorConsultoraDummy { get; set; }
        [DataMember]
        public bool MostrarBotonVerTodosBuscador { get; set; }
        [DataMember]
        public bool AplicarLogicaCantidadBotonVerTodosBuscador { get; set; }
        [DataMember]
        public bool MostrarOpcionesOrdenamiento { get; set; }
    }
}
