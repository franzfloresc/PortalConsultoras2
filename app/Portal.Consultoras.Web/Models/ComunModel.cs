using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ComunModel
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public string Valor { get; set; }
        public string ValorOpcional { get; set; }
        public string mongoIds { get; set; }
    }
}