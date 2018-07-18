using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomEventoConsultora
    {
        [DataMember]
        public int EventoConsultoraID { get; set; }

        [DataMember]
        public int EventoID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string Segmento { get; set; }

        [DataMember]
        public bool MostrarPopup { get; set; }

        [DataMember]
        [ViewProperty]
        public bool MostrarPopupVenta { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        public bool Suscripcion { get; set; }

        [DataMember]
        [ViewProperty]
        public int Envio { get; set; }

        [DataMember]
        [ViewProperty]
        public string CorreoEnvioAviso { get; set; }

        public BEShowRoomEventoConsultora(IDataRecord row)
        {
            EventoConsultoraID = row.ToInt32("EventoConsultoraID");
            EventoID = row.ToInt32("EventoID");
            CampaniaID = row.ToInt32("CampaniaID");
            CodigoConsultora = row.ToString("CodigoConsultora");
            Segmento = row.ToString("Segmento");
            MostrarPopup = row.ToBoolean("MostrarPopup");
            MostrarPopupVenta = row.ToBoolean("MostrarPopupVenta");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            Suscripcion = row.ToBoolean("Suscripcion");
            Envio = row.ToInt32("Envio");
            CorreoEnvioAviso = row.ToString("CorreoEnvioAviso");
        }
    }
}
