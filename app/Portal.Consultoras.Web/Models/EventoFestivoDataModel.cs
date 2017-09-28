using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Antlr.Runtime.Misc;

namespace Portal.Consultoras.Web.Models
{
    public class EventoFestivoDataModel
    { 
        public List<EventoFestivoModel> ListaEventoFestivo { get; set; }
        public string EfRutaPedido { get; set; }
        public string EfSaludo { get; set; }
        public List<EventoFestivoModel> ListaGifMenuContenedorOfertas { get; set; }

        public EventoFestivoDataModel()
        {
            ListaEventoFestivo = new List<EventoFestivoModel>();
            ListaGifMenuContenedorOfertas  = new List<EventoFestivoModel>();
        }
    }

}