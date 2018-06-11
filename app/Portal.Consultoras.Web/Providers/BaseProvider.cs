using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class BaseProvider
    {
        protected ISessionManager sessionManager;
        protected ILogManager logManager;
        protected UsuarioModel userData;
        protected RevistaDigitalModel revistaDigital;
        protected ConfiguracionManagerProvider _configuracionManager;

        public BaseProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            logManager = LogManager.LogManager.Instance;
            userData = sessionManager.GetUserData();
            revistaDigital = sessionManager.GetRevistaDigital();
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        public void GetLimitNumberPhone(int paisId, out int limiteMinimoTelef, out int limiteMaximoTelef)
        {
            switch (paisId)
            {
                case Constantes.PaisID.Mexico:
                    limiteMinimoTelef = 5;
                    limiteMaximoTelef = 15;
                    break;
                case Constantes.PaisID.Peru:
                    limiteMinimoTelef = 7;
                    limiteMaximoTelef = 9;
                    break;
                case Constantes.PaisID.Colombia:
                    limiteMinimoTelef = 10;
                    limiteMaximoTelef = 10;
                    break;
                case Constantes.PaisID.Guatemala:
                case Constantes.PaisID.ElSalvador:
                case Constantes.PaisID.Panama:
                case Constantes.PaisID.CostaRica:
                    limiteMinimoTelef = 8;
                    limiteMaximoTelef = 8;
                    break;
                case Constantes.PaisID.Ecuador:
                    limiteMinimoTelef = 9;
                    limiteMaximoTelef = 10;
                    break;
                default:
                    limiteMinimoTelef = 0;
                    limiteMaximoTelef = 15;
                    break;
            }
        }

        public int GetDiasFaltantesFacturacion(DateTime fechaInicioCampania, double zonaHoraria)
        {
            var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;
            return fechaHoy >= fechaInicioCampania.Date ? 0 : (fechaInicioCampania.Subtract(DateTime.Now.AddHours(zonaHoraria)).Days + 1);
        }
    }

}