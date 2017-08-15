using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomPersonalizacionModel
    {
        public int PersonalizacionId { get; set; }
        public string TipoAplicacion { get; set; }
        public string Atributo { get; set; }
        public string TextoAyuda { get; set; }
        public string TipoAtributo { get; set; }
        public string TipoPersonalizacion { get; set; }
        public int Orden { get; set; }
        public bool Estado { get; set; }

        /*Valores necesarios para la configuracion (viene de la tabla ShowRoom.PersonalizacionNivel*/
        public int PersonalizacionNivelId { get; set; }
        public string Valor { get; set; }
    }
}