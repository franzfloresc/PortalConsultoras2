using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class EventoFestivoProvider
    {
        protected ISessionManager sessionManager;
        protected UsuarioModel userData;

        public EventoFestivoProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            userData = sessionManager.GetUserData();
        }

        public string EventoFestivoPersonalizacionSegunNombre(string nombre, string valorBase = "")
        {
            var eventoFestivo = new EventoFestivoModel();
            try
            {
                eventoFestivo = sessionManager.GetEventoFestivoDataModel().ListaGifMenuContenedorOfertas.FirstOrDefault(p => p.Nombre == nombre) ?? new EventoFestivoModel();
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            var valor = Util.Trim(eventoFestivo.Personalizacion);
            valor = valor == "" ? Util.Trim(valorBase) : valor;

            return valor;
        }
        
        public string GetUrlFranjaNegra()
        {
            var oModel = sessionManager.GetEventoFestivoDataModel();
            var urlFranjaNegra = oModel == null ? string.Empty : oModel.EfRutaPedido;

            if (string.IsNullOrEmpty(urlFranjaNegra))
                urlFranjaNegra = "../../../Content/Images/Esika/background_pedido.png";

            return urlFranjaNegra;
        }

    }
}