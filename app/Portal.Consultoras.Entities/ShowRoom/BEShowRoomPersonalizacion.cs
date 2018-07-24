using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomPersonalizacion
    {
        [DataMember]
        public int PersonalizacionId { get; set; }
        [DataMember]
        public string TipoAplicacion { get; set; }
        [DataMember]
        public string Atributo { get; set; }
        [DataMember]
        public string TextoAyuda { get; set; }
        [DataMember]
        public string TipoAtributo { get; set; }
        [DataMember]
        public string TipoPersonalizacion { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEShowRoomPersonalizacion(IDataRecord row)
        {
            PersonalizacionId = row.ToInt32("PersonalizacionId");
            TipoAplicacion = row.ToString("TipoAplicacion");
            Atributo = row.ToString("Atributo");
            TextoAyuda = row.ToString("TextoAyuda");
            TipoAtributo = row.ToString("TipoAtributo");
            TipoPersonalizacion = row.ToString("TipoPersonalizacion");
            Orden = row.ToInt32("Orden");
            Estado = row.ToBoolean("Estado");
        }
    }
}
