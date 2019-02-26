
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    [Serializable()]
    public class ConfigModel
    {
        public ConfigModel()
        {
            ListaCategoria = new List<ShowRoomCategoriaModel>();
            ListaNivel = new List<ShowRoomNivelModel>();
            ListaPersonalizacionConsultora = new List<ShowRoomPersonalizacionModel>();
        }

        [Obsolete("Esta variable se dejará de usar por estas: CargoEntidadEventoPersonalizacion - CargoEntidadNivel - CargoEntidadEventoConsultora")]
        public bool CargoEntidadesShowRoom { get; set; }

        public bool CargoEntidadEventoPersonalizacion { get; set; }
        public bool CargoEntidadNivel { get; set; }
        public bool CargoEntidadEventoConsultora { get; set; }

        public ShowRoomEventoModel BeShowRoom { get; set; }
        public ShowRoomEventoConsultoraModel BeShowRoomConsultora { get; set; }
        public int ShowRoomNivelId { get; set; }
        public List<ShowRoomNivelModel> ListaNivel { get; set; }
        public List<ShowRoomPersonalizacionModel> ListaPersonalizacionConsultora { get; set; }
        public List<ShowRoomCategoriaModel> ListaCategoria { get; set; }
        public bool BloqueoProductoDigital { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
    }
}