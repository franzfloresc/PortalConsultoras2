﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class UpdatePassSACController : BaseAdmController
    {
        public ActionResult Index()
        {
            var model = new UpdatePassSACModel { listaPaises = DropDowListPaises() };
            return View(model);
        }

        public ActionResult CambiarPass()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("Index");

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Dictionary<string, object> data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            var model = new UpdatePassSACModel
            {
                PaisID = Convert.ToInt32(data["paisID"]),
                CodigoConsultora = data["CodigoConsultora"].ToString(),
                listaPaises = DropDowListPaises()
            };


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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                SessionManager.setBEUsuarioModel(items.ToList());

                foreach (var item in items)
                {
                    RegistrarLogDynamoCambioClave("CONSULTA", item.CodigoConsultora, "", "", "SAC/ACTUALIZAR CONTRASEÑA", "Mantenimiento de contraseña");
                }

                BEPager pag = Paginador(grid, lst);

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

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public JsonResult ResetPassConsultora(UpdatePassSACModel model)
        {
            try
            {
                var codigoIso = Util.GetPaisISO(model.PaisID);
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    var resultExiste = sv.ExisteUsuario(model.PaisID, model.CodigoConsultora, "");

                    if (resultExiste == Constantes.ValidacionExisteUsuario.Existe)
                    {
                        var result = sv.CambiarClaveUsuario(model.PaisID, codigoIso, model.CodigoConsultora,
                            model.Clave, "", userData.CodigoUsuario, EAplicacionOrigen.ActualizarClaveSAC);

                        if (string.IsNullOrEmpty(result))
                        {
                            registraDynamo(model);

                            return Json(new
                            {
                                success = true,
                                message = Constantes.MensajesError.CambioSatisfactorioContrasenia
                            });
                        }
                        else
                        {
                            return Json(new
                            {
                                success = false,
                                message = result,
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }

        }

        public ActionResult MantenimientoUsuarioGZ()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "UpdatePassSAC/MantenimientoUsuarioGZ"))
                return RedirectToAction("Index", "Bienvenida");
            string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.GZURL) + "?PAIS=" + userData.CodigoISO + "&USUARIO=" + userData.CodigoUsuario;
            return Redirect(url);
        }

        private void registraDynamo(UpdatePassSACModel model)
        {
            var extraeContraseñaAnterior = "";
            var lstUsuario = SessionManager.getBEUsuarioModel();
            foreach (var item in lstUsuario)
            {
                if (item.CodigoConsultora == model.CodigoConsultora)
                {
                    extraeContraseñaAnterior = item.ClaveSecreta;
                }
            }

            List<BEUsuario> lst;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                lst = sv.SelectByNombre(Convert.ToInt32(model.PaisID), model.CodigoConsultora).ToList();
            }

            var contraseñaCambiada = "";
            foreach (var item in lst)
            {
                contraseñaCambiada = item.ClaveSecreta;
            }

            RegistrarLogDynamoCambioClave("MODIFICACION", model.CodigoConsultora, contraseñaCambiada, extraeContraseñaAnterior, "SAC/ACTUALIZAR CONTRASEÑA", "Mantenimiento de contraseña");
        }
    }
}
