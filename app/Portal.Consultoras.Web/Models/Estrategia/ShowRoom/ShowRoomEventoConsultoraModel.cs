using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    [Serializable]
    public class ShowRoomEventoConsultoraModel
    {
        public int EventoConsultoraID { get; set; }
        public int EventoID { get; set; }
        public int CampaniaID { get; set; }
        public string CodigoConsultora { get; set; }
        public string Segmento { get; set; }
        public bool MostrarPopup { get; set; }
        public bool MostrarPopupVenta { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string UsuarioCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public bool Suscripcion { get; set; }
        public int Envio { get; set; }
        public string CorreoEnvioAviso { get; set; }
    }
}