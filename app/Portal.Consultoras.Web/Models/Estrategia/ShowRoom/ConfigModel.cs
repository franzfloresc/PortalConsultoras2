namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    using System;
    using System.Collections.Generic;
    using Portal.Consultoras.Web.ServicePedido;

    [Serializable()]
    public class ConfigModel
    {
        public bool CargoEntidadesShowRoom { get; set; }
        //@001 FSV INICIO
        //public BEShowRoomEvento BeShowRoom { get; set; }
        //public BEShowRoomEventoConsultora BeShowRoomConsultora { get; set; }
        public ServiceOferta.BEShowRoomEvento BeShowRoom { get; set; }
        public ServiceOferta.BEShowRoomEventoConsultora BeShowRoomConsultora { get; set; }
        //@001 FSV FIN

        public int ShowRoomNivelId { get; set; }
        public List<BEShowRoomNivel> ListaNivel { get; set; }
        public List<ShowRoomPersonalizacionModel> ListaPersonalizacionConsultora { get; set; }
    }
}