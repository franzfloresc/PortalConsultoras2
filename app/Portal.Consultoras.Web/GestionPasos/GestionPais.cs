using System.Collections.Generic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia;

namespace Portal.Consultoras.Web.GestionPasos
{
    public class GestionPais
    {
        public static Dictionary<string, IEvaluacionCrediticia> EvaluacionCrediticia = new Dictionary<string, IEvaluacionCrediticia>();

        static GestionPais()
        {
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Chile, new EvaluacionCrediticiaChile());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Colombia, new EvaluacionCrediticiaColombia());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Mexico, new EvaluacionCrediticiaMexico());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Peru, new EvaluacionCrediticiaPeru());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Ecuador, new EvaluacionCrediticiaEcuador());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.CostaRica, new EvaluacionCrediticiaCam());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Guatemala, new EvaluacionCrediticiaCam());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Panama, new EvaluacionCrediticiaCam());
            EvaluacionCrediticia.Add(Constantes.CodigosISOPais.Salvador, new EvaluacionCrediticiaCam());
            
        }
    }
}