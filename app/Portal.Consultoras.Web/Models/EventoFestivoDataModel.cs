using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EventoFestivoDataModel
    {
        public List<EventoFestivoModel> ListaEventoFestivo { get; set; }
        public string EfRutaPedido { get; set; }
        public string EfSaludo { get; set; }
        public List<EventoFestivoModel> ListaGifMenuContenedorOfertas { get; set; }

        public EventoFestivoDataModel()
        {
            ListaEventoFestivo = new List<EventoFestivoModel>();
            ListaGifMenuContenedorOfertas = new List<EventoFestivoModel>();
        }
    }

}