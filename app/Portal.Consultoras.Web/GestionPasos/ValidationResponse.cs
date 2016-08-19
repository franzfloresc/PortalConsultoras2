using System.Web.UI;

namespace CORP.BEL.Unete.UI.UB.Validaciones
{
    public class ValidationResponse
    {
        public bool Valid { get; set; }
        public string Mensaje { get; set; }
        public object Data { get; set; }
    }
}