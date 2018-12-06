namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    using System;

    public class WaEventoConsultora
    {
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