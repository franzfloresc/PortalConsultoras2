
/*
CONTROL DE CAMBIOS
CORRELATIVO -   PERSONA -   FECHA       -   MOTIVO
@001        -   FSV     -   08/06/2018  -   Se traslada llamamientos de ShowRoom y ODD al nuevo servicio unificado "OfertaService".
@002
*/

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
        //@001 FSV INICIO
        //public List<BEShowRoomNivel> ListaNivel { get; set; }
        public List<ServiceOferta.BEShowRoomNivel> ListaNivel { get; set; }
        //@001 FSV FIN
        public List<ShowRoomPersonalizacionModel> ListaPersonalizacionConsultora { get; set; }
    }
}