using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseShowRoomController : BaseController
    {
        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            bool resultado = false;

            var showRoomEvento = new BEShowRoomEvento();
            var showRoomEventoConsultora = new BEShowRoomEventoConsultora();

            if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
            showRoomEventoConsultora = userData.BeShowRoomConsultora;
            showRoomEvento = userData.BeShowRoom;

            if (showRoomEvento != null && showRoomEvento.Estado == 1 && showRoomEventoConsultora != null)
            {
                int diasAntes = showRoomEvento.DiasAntes;
                int diasDespues = showRoomEvento.DiasDespues;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (esIntriga)
                {
                    if (!(fechaHoy >= userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Date
                    && fechaHoy <= userData.FechaInicioCampania.AddDays(showRoomEvento.DiasDespues).Date))
                    {
                        ViewBag.DiasFaltan = userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Day - fechaHoy.Day;
                        if (ViewBag.DiasFaltan > 0)
                        {
                            resultado = true;
                        }
                    }
                }
                else
                {
                    if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date &&
                     fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date))
                    {
                        resultado = true;
                    }
                }
            }

            return resultado;
        }
    }
}