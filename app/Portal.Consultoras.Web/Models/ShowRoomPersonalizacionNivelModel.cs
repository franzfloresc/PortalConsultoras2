using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ShowRoomPersonalizacionNivelModel
    {
        public int PersonalizacionNivelId { get; set; }
        public int EventoID { get; set; }
        public int PersonalizacionId { get; set; }
        public int NivelId { get; set; }
        public string Valor { get; set; }

        public string NombreImagen { get; set; }
        public string NombreImagenAnterior { get; set; }
        public bool EsImagen { get; set; }
    }
}