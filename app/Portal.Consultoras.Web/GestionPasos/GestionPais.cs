using System.Collections.Generic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia;

namespace Portal.Consultoras.Web.GestionPasos
{
    public class GestionPais
    {
        public static Dictionary<string, IEvaluacionCrediticia> EvaluacionCrediticia = new Dictionary<string, IEvaluacionCrediticia>();

        public GestionPais()
        {
            EvaluacionCrediticia = new Dictionary<string, IEvaluacionCrediticia>
            {
                {Constantes.CodigosISOPais.Chile, new EvaluacionCrediticiaChile()},
                {Constantes.CodigosISOPais.Colombia, new EvaluacionCrediticiaColombia()},
                {Constantes.CodigosISOPais.Mexico, new EvaluacionCrediticiaMexico()},
                {Constantes.CodigosISOPais.Peru, new EvaluacionCrediticiaPeru()}
            };
        }
    }
}