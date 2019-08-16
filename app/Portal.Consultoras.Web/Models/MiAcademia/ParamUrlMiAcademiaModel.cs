using System;

namespace Portal.Consultoras.Web.Models.MiAcademia
{
    [Serializable]
    public class ParamUrlMiAcademiaModel
    {
        public string IsoUsuario { get; set; }
        public string Token { get; set; }
        public string CodigoClasificacion { get; set; }
        public string CodigoSubClasificacion { get; set; }
        public string DescripcionSubClasificacion { get; set; }
        public int IdCurso { get; set; }
        public bool FlagVideo { get; set; }
        public bool FlagPdf { get; set; }
    }
}