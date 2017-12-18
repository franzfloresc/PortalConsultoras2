﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class UpdatePassSACController : BaseController
    {
        public ActionResult Index()
        {
            var model = new UpdatePassSACModel();
            model.listaPaises = DropDowListPaises();
            return View(model);
        }

        public ActionResult CambiarPass()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("Index");

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Dictionary<string, object> data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            var model = new UpdatePassSACModel();

            model.PaisID = Convert.ToInt32(data["paisID"]);
            model.CodigoConsultora = data["CodigoConsultora"].ToString();
            model.listaPaises = DropDowListPaises();

            return View(model);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vPaisID, string vCodigoConsultora)
        {
            if (ModelState.IsValid)
            {
                List<BEUsuario> lst;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    lst = sv.SelectByNombre(Convert.ToInt32(vPaisID), vCodigoConsultora).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
                IEnumerable<BEUsuario> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoUsuario);
                            break;
                        case "Nombre":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoUsuario);
                            break;
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               cell = new string[]
                               {
                                   a.PaisID.ToString(),
                                   a.CodigoUsuario,
                                   a.Nombre
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Consultar");
        }
        public BEPager Paginador(BEGrid item, List<BEUsuario> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        public JsonResult ResetPassConsultora(UpdatePassSACModel model)
        {
            try
            {
                BEPais bepais = new BEPais();

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(model.PaisID));
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    int resultExiste;
                    bool result;

                    resultExiste = sv.ExisteUsuario(model.PaisID, model.CodigoConsultora, "");

                    if (resultExiste == Constantes.ValidacionExisteUsuario.Existe)
                    {
                        result = sv.CambiarClaveUsuario(model.PaisID, bepais.CodigoISO, model.CodigoConsultora,
                            model.Clave, "", userData.CodigoUsuario, EAplicacionOrigen.ActualizarClaveSAC);

                        if (result)
                        {
                            return Json(new
                            {
                                success = true,
                                message = "La contraseña ha sido cambiada de forma correcta."
                            });
                        }
                        else
                        {
                            return Json(new
                            {
                                success = false,
                                message = "error al cambiar clave, inténtelo mas tarde.",
                                extra = ""
                            });
                        }
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "el codigo ingresado no es válido.",
                            extra = ""
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }

        }
        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2)
                    lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult MantenimientoUsuarioGZ()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "UpdatePassSAC/MantenimientoUsuarioGZ"))
                return RedirectToAction("Index", "Bienvenida");
            string Url =GetConfiguracionManager(Constantes.ConfiguracionManager.GZURL) + "?PAIS=" + UserData().CodigoISO + "&USUARIO=" + UserData().CodigoUsuario;
            return Redirect(Url);
        }
    }
}
