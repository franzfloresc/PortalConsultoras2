using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomPersonalizacionNivelModel
    {
        public int PersonalizacionNivelId { get; set; }
        public int EventoID { get; set; }
        public int PersonalizacionId { get; set; }
        public int NivelId { get; set; }
        public int CategoriaId { get; set; }
        public string Valor { get; set; }
        public string ValorAnterior { get; set; }
        public bool EsImagen { get; set; }
    }
}