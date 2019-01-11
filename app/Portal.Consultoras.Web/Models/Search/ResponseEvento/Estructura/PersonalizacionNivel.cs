using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseEvento.Estructura
{
    public class PersonalizacionNivel
    {
        public int EventoId { get; set; }
        public int NivelId { get; set; }
        public int PersonalizacionId { get; set; }
        public string TipoPersonalizacion { get; set; }
        public string TipoAplicacion { get; set; }
        public string TipoAtributo { get; set; }
        public string Atributo { get; set; }
        public string TextoAyuda { get; set; }
        public int Orden { get; set; }
        public int Estado { get; set; }
        public string Valor { get; set; }
    }
}