using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    [Serializable]
    public class ShowRoomNivelModel
    {
        public int NivelId { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }
}