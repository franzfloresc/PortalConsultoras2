using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class ChatEmtelcoProvider
    {
        private readonly TablaLogicaProvider _tablaLogicaProvider;

        public ChatEmtelcoProvider() : this(new TablaLogicaProvider())
        {
        }

        public ChatEmtelcoProvider(TablaLogicaProvider tablaLogicaProvider)
        {
            _tablaLogicaProvider = tablaLogicaProvider;
        }

        public ChatActivation HabilitarChats(int paisId, bool esMobile)
        {
            var datos = _tablaLogicaProvider.GetTablaLogicaDatos(paisId, ConsTablaLogica.ChatEmtelco.TablaLogicaId);

            var result = new ChatActivation
            {
                ChatEmtelco = _tablaLogicaProvider.GetValueByCode(datos, esMobile ? "02": "01") == "1",
                ChatBot = _tablaLogicaProvider.GetValueByCode(datos, esMobile ? "05": "04") == "1"
            };

            return result;
        }
    }
}
