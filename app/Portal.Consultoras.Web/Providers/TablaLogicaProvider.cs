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

        public virtual List<TablaLogicaDatosModel> ObtenerConfiguracion(int paisId, short key)
        {
            using (var cliente = new SACServiceClient())
            {
                var datos = cliente.GetTablaLogicaDatos(paisId, key);
                return Mapper.Map<IEnumerable<BETablaLogicaDatos>, List<TablaLogicaDatosModel>>(datos);
            }
        }

        public string ObtenerValorTablaLogica(List<TablaLogicaDatosModel> datos, short idTablaLogicaDatos)
        {
            var valor = "";
            datos = datos ?? new List<TablaLogicaDatosModel>();
            if (datos.Any())
            {
                var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == idTablaLogicaDatos) ?? new TablaLogicaDatosModel();
                valor = Util.Trim(par.Codigo);
            }
            return valor;
        }

        public int ObtenerValorTablaLogicaInt(List<TablaLogicaDatosModel> lista, short tablaLogicaDatosId)
        {
            var resultadoString = ObtenerValorTablaLogica(lista, tablaLogicaDatosId);

            int resultado;
            int.TryParse(resultadoString, out resultado);
            return resultado;
        }

        public List<TablaLogicaDatosModel> ObtenerParametrosTablaLogica(int paisId, short tablaLogicaId, bool sesion = false)
        {
            var datos = sesion ? sessionManager.GetTablaLogicaDatosLista(Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()) : null;
            if (datos == null)
            {
                datos = ObtenerConfiguracion(paisId, tablaLogicaId);

                if (sesion)
                {
                    sessionManager.SetTablaLogicaDatosLista(Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString(), datos);
                }
            }

            return datos;
        }

        public string ObtenerValorTablaLogica(int paisId, short tablaLogicaId, short idTablaLogicaDatos, bool sesion = false)
        {
            return ObtenerValorTablaLogica(ObtenerParametrosTablaLogica(paisId, tablaLogicaId, sesion), idTablaLogicaDatos);
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
