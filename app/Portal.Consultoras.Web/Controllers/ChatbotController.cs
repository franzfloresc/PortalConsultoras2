using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ChatbotController : BaseAdmController
    {
        protected TablaLogicaProvider _tablaLogica;
        public ChatbotController()
        {
            _tablaLogica = new TablaLogicaProvider();
        }

        public ActionResult Index()
        {
            var model = new ChatBotModel();

            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Chatbot/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                model.listaPaises = DropDowListPaises();
                model.PaisID = userData.PaisID;
               
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);

        }

        public JsonResult ComponenteListar(FiltroReporteChatBotModel model)
        {
            try
            {
                var list = ComponenteListarService(model);
                var grid = new BEGrid(model.Sidx, model.Sord, model.Page, model.Rows);
                var items = list.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                var pag = Util.PaginadorGenerico(grid, list.ToList());
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ResultadosID,
                               cell = new string[]
                                {
                                    a.ResultadosID.ToString(),
                                    a.CodigoConsultora,
                                    a.Pais,
                                    a.ConversacionID,
                                    a.FechaInicio.ToString(),
                                    a.FechaFin.ToString(),
                                    a.NombreOperador,
                                    a.Resp1.ToString(),
                                    a.Resp2.ToString(),
                                    a.Resp3.ToString(),
                                    a.RespDescrip1,
                                    a.RespDescrip2,
                                    a.RespDescrip3,
                                    a.CanalDescripcion
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false });
            }
        }

        private IEnumerable<ChatBotListResultadosModel> ComponenteListarService(FiltroReporteChatBotModel model)
        {
            List<ChatBotListResultadosModel> listaEntidad = new List<ChatBotListResultadosModel>();

            try
            {

                var entidad = Mapper.Map<BEChatBotListResultados>(model);
                entidad.Pais = Util.GetPaisISO(Convert.ToInt32(model.PaisID));

                List<BEChatBotListResultados> listaDatos;
                using (var sv = new SACServiceClient())
                {
                    listaDatos = sv.ChatBotListResultados(userData.PaisID, entidad).ToList();
                }

                listaEntidad = Mapper.Map<IList<BEChatBotListResultados>, List<ChatBotListResultadosModel>>(listaDatos);

            }
            catch (Exception ex)
            {
                listaEntidad = new List<ChatBotListResultadosModel>();
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.PaisID.ToString(),
                    "ChatbotController.ComponenteListarService");
            }
            return listaEntidad;
        }

    }
}