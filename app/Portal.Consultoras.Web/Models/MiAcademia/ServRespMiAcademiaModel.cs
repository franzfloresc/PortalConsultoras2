using System;

namespace Portal.Consultoras.Web.Models.MiAcademia
{
    [Serializable]
    public class ServRespMiAcademiaModel
    {
        public string GetUserCod { get; set; }
        public string CreateUserCod { get; set; }
        public string Token { get; set; }
    }
}