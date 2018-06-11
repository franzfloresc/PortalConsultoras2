namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    using System;
    using System.Collections.Generic;

    [Serializable()]
    public class ConfigModel
    {
        public bool CargoEntidadesShowRoom { get; set; }
        public ShowRoomEventoModel BeShowRoom { get; set; }
        public ShowRoomEventoConsultoraModel BeShowRoomConsultora { get; set; }
        public int ShowRoomNivelId { get; set; }
        public List<ShowRoomNivelModel> ListaNivel { get; set; }
        public List<ShowRoomPersonalizacionModel> ListaPersonalizacionConsultora { get; set; }
    }
}