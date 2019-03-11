using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseEvento.Estructura
{
    public class EventoConsultora
    {
        public string _id { get; set; }
        public int EventoConsultoraId { get; set; }
        public int EventoId { get; set; }
        public string CampaniaId { get; set; }
        public string CodigoConsultora { get; set; }
        public string Segmento { get; set; }
        public bool MostrarPopup { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string UsuarioCreacion { get; set; }
        public bool MostrarPopupVenta { get; set; }
        public bool EsGenerica { get; set; }
        public DateTime FechaModificacion { get; set; }
        public string UsuarioModificacion { get; set; }
    }
}