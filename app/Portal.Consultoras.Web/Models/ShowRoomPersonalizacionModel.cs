using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomPersonalizacionModel
    {
     
        private string _Valor = string.Empty;

        public int PersonalizacionId { get; set; }
        public string TipoAplicacion { get; set; }
        public string Atributo { get; set; }
        public string TextoAyuda { get; set; }
        public string TipoAtributo { get; set; }
        public string TipoPersonalizacion { get; set; }
        public int Orden { get; set; }
        public bool Estado { get; set; }
        public int PersonalizacionNivelId { get; set; }
        public string Valor {
            get {return _Valor;}
            set {_Valor = value ?? string.Empty;}
        }
        public int NivelId { get; set; }
    }
}