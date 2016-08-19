using System.Collections.Generic;
using CORP.BEL.Unete.UI.UB.Validaciones;

namespace CORP.BEL.Unete.UI.UB.GestionPasos
{
    public class ValidationPasoResponse
    {
        public bool Valid { get; set; }
        public int IndicePrimerError { get; set; }
        public object Data { get; set; }
        public List<ValidationResponse> DetalleRespuestas { get; set; } 
    }
}