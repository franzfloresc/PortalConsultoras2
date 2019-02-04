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

        private string GetTablaLogicaDatoValor(List<TablaLogicaDatosModel> datos, short idTablaLogicaDatos)
        {
            datos = datos ?? new List<TablaLogicaDatosModel>();

            var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == idTablaLogicaDatos) ?? new TablaLogicaDatosModel();

            return Util.Trim(par.Valor);
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

        public string GetTablaLogicaDatoCodigo(int paisId, short tablaLogicaId, short tablaLogicaDatosId, bool saveInSession = false)
        {
            var datos = GetTablaLogicaDatos(paisId, tablaLogicaId, saveInSession);
            return GetTablaLogicaDatoCodigo(datos, tablaLogicaDatosId);
        }

        public int GetTablaLogicaDatoCodigoInt(int paisId, short tablaLogicaId, short tablaLogicaDatosId, bool saveInSession = false)
        {
            var strCodigo = GetTablaLogicaDatoCodigo(paisId, tablaLogicaId,  tablaLogicaDatosId, saveInSession);

            int codigo;
            int.TryParse(strCodigo, out codigo);
            return codigo;
        }

        public string GetTablaLogicaDatoValor(int paisId, short tablaLogicaId, short tablaLogicaDatosId, bool saveInSession = false)
        {
            var datos = GetTablaLogicaDatos(paisId, tablaLogicaId, saveInSession);
            return GetTablaLogicaDatoValor(datos, tablaLogicaDatosId);
        }

        public bool GetTablaLogicaDatoValorBool(int paisId, short tablaLogicaId, short tablaLogicaDatosId, bool saveInSession = false)
        {
            var valor = GetTablaLogicaDatoValor(paisId, tablaLogicaId, tablaLogicaDatosId, saveInSession);

            return valor == "1" ? true : false;
        }
    }
}
