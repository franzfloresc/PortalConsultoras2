using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseEvento.Estructura
{
    public class Evento
    {
        public string _id { get; set; }
        public int EventoId { get; set; }
        public int TieneCategoria { get; set; }
        public int TieneCompraXcompra { get; set; }
        public int TienePersonalizacion { get; set; }
        public int TieneSubCampania { get; set; }
        public int CampaniaId { get; set; }
        public int DiasAntes { get; set; }
        public int DiasDespues { get; set; }
        public int Estado { get; set; }
        public int NumeroPerfiles { get; set; }
        public string Nombre { get; set; }
        public string Tema { get; set; }
        public string UsuarioCreacion { get; set; }
        public IList<PersonalizacionNivel> PersonalizacionNivel { get; set; }
    }
}