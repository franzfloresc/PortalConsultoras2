using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class TablaLogicaProvider
    {
        protected ISessionManager sessionManager;

        public TablaLogicaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        private List<TablaLogicaDatosModel> GetTablaLogicaDatos(int paisId, short tablaLogicaId)
        {
            using (var cliente = new SACServiceClient())
            {
                var datos = cliente.GetTablaLogicaDatos(paisId, tablaLogicaId);
                return Mapper.Map<IEnumerable<BETablaLogicaDatos>, List<TablaLogicaDatosModel>>(datos);
            }
        }

        private string GetTablaLogicaDatoCodigo(List<TablaLogicaDatosModel> datos, short tablaLogicaDatosId)
        {
            datos = datos ?? new List<TablaLogicaDatosModel>();

            var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == tablaLogicaDatosId) ?? new TablaLogicaDatosModel();

            return Util.Trim(par.Codigo);
        }

        public string ObtenerValorDesdeLista(List<TablaLogicaDatosModel> datos, short idTablaLogicaDatos)
        {
            if (datos == null || datos.Count == 0)
            {
                return string.Empty;
            }

            var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == idTablaLogicaDatos) ?? new TablaLogicaDatosModel();

            return Util.Trim(par.Valor);
        }

        public int ObtenerValorTablaLogicaInt(List<TablaLogicaDatosModel> lista, short tablaLogicaDatosId)
        {
            var resultadoString = GetTablaLogicaDatoCodigo(lista, tablaLogicaDatosId);

            int resultado;
            int.TryParse(resultadoString, out resultado);
            return resultado;
        }

        public List<TablaLogicaDatosModel> GetTablaLogicaDatos(int paisId, short tablaLogicaId, bool saveInSession = false)
        {
            var datos = saveInSession ? sessionManager.GetTablaLogicaDatosLista(Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()) : null;
            if (datos == null)
            {
                datos = GetTablaLogicaDatos(paisId, tablaLogicaId);

                if (saveInSession)
                {
                    sessionManager.SetTablaLogicaDatosLista(Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString(), datos);
                }
            }

            return datos;
        }

        public string ObtenerValorTablaLogica(int paisId, short tablaLogicaId, short idTablaLogicaDatos, bool saveInSession = false)
        {
            return GetTablaLogicaDatoCodigo(GetTablaLogicaDatos(paisId, tablaLogicaId, saveInSession), idTablaLogicaDatos);
        }

        public int ObtenerValorTablaLogicaInt(int paisId, short tablaLogicaId, short idTablaLogicaDatos, bool sesion = false)
        {
            var resultadoString = ObtenerValorTablaLogica(paisId, tablaLogicaId, idTablaLogicaDatos, sesion);
            int resultado;
            int.TryParse(resultadoString, out resultado);
            return resultado;
        }

    }
}
