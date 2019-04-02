using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Web.Models.ConsultaProl;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Properties;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;



namespace Portal.Consultoras.Web.Providers
{
    public class ConsultoraOnlineProvider
    {

        protected ISessionManager sessionManager;

        public ConsultoraOnlineProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }
         



        public List<EstrategiaPedidoModel> GetRecomendados(RecomendadoRequest recomendado)
        {

            var ac = sessionManager;
            using (var sv = new UsuarioServiceClient())
            {
                var resp =  sv.GetRecomendados(recomendado);
            }

            return new List<EstrategiaPedidoModel>();
        }

    }
}