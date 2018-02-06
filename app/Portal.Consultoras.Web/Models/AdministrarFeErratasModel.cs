using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class AdministrarFeErratasModel
    {
        public int FeErratasID { get; set; }
        public int PaisID { set; get; }
        public int CampaniaID { set; get; }
        public string Nombre { set; get; }
        public string Titulo { set; get; }
        public int Pagina { get; set; }
        public string Dice { set; get; }
        public string DebeDecir { set; get; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public bool Eliminar { get; set; }

        public AdministrarFeErratasModel()
        {
            listaCampania = new List<CampaniaModel>();
            listaPaises = new List<PaisModel>();
            Eliminar = false;
        }
    }
}