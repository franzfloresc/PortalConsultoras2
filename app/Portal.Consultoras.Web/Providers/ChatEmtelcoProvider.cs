using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class ChatEmtelcoProvider
    {
        protected readonly TablaLogicaProvider _tablaLogicaProvider;

        public ChatEmtelcoProvider() : this(new TablaLogicaProvider())
        {
        }

        public ChatEmtelcoProvider(TablaLogicaProvider tablaLogicaProvider)
        {
            _tablaLogicaProvider = tablaLogicaProvider;
        }



        public bool HabilitarChatEmtelco(int paisId, bool esMobile)
        {
            bool Mostrar = false;
            List<TablaLogicaDatosModel> DataLogica = _tablaLogicaProvider.ObtenerParametrosTablaLogica(paisId, Constantes.TablaLogica.HabilitarChatEmtelco, false);

            if (esMobile)
            {
                if (DataLogica.FirstOrDefault(x => x.Codigo.Equals("02")).Valor == "1")
                    Mostrar = true;
            }
            else
            {
                if (DataLogica.FirstOrDefault(x => x.Codigo.Equals("01")).Valor == "1")
                    Mostrar = true;
            }

            return Mostrar;
        }
    }
}
