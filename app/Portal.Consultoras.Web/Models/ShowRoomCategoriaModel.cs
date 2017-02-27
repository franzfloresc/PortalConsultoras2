using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomCategoriaModel
    {
        public int CategoriaId { get; set; }
        public int EventoID { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }
}