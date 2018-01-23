﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class RVDigitalController : BaseController
    {
        public ActionResult Index()
        {
            string errorMessage;
            string codigoConsultora = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora;
            var oRVDigitalModel = new RVDigitalModel { listaCampania = GetListCampaniaPaqueteDocumentario(codigoConsultora, out errorMessage) };
            
            ViewBag.ErrorDescripcion = errorMessage;
            if (userData.PaisID == 4)
            {
                ViewBag.PaisID = userData.PaisID;
                using (var sv = new ContenidoServiceClient())
                {
                    ViewBag.InvitacionPaquete = Convert.ToInt32(sv.ValidarInvitacionPaqueteDocumentario(userData.PaisID, userData.CodigoConsultora));
                }
            }

            return View(oRVDigitalModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string Campania)
        {
            List<RVPRFModel> lst = new List<RVPRFModel>();
            if (!string.IsNullOrEmpty(Campania)) lst = GetPDFRVDigital(userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora, Campania, "");
            IEnumerable<RVPRFModel> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderBy(x => x.Nombre);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "Nombre":
                        items = lst.OrderByDescending(x => x.Nombre);
                        break;
                }
            }
            #endregion

            BEGrid grid = SetGrid(sidx, sord, page, rows);

            if (string.IsNullOrEmpty(Campania))
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            else
                items = items.Where(p => p.Nombre.ToUpper().Contains(Campania.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = Paginador(grid, Campania, lst);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.Nombre,
                           cell = new string[]
                               {
                                   "Paquete Documentario",
                                   Campania,
                                   DevolverFecha(a.Nombre),
                                   a.Ruta
                                }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public BEPager Paginador(BEGrid item, string vBusqueda, List<RVPRFModel> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        public string DevolverNombre(string url)
        {
            string[] cadenas = url.Split('/');
            string nombre = string.Empty;

            if (cadenas.Length > 0)
            {
                nombre = cadenas[cadenas.Length - 2] + "_" + cadenas[cadenas.Length - 1];
            }

            return nombre.Replace(".pdf", "");
        }

        public string DevolverFecha(string url)
        {
            string[] cadenas = url.Split('/');
            string fecha = string.Empty;

            if (cadenas.Length > 0)
            {
                string[] rutas = cadenas[cadenas.Length - 2].Split('_');
                if (rutas.Length > 0)
                {
                    string temp = rutas[1].Substring(6, 8);
                    fecha = string.Format("{0}/{1}/{2}", temp.Substring(6, 2), temp.Substring(4, 2), temp.Substring(0, 4));
                }
            }

            return fecha;
        }

        [HttpPost]
        public JsonResult AceptarPaqueteDocumentarioWeb()
        {
            try
            {
                int result;
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    result = sv.ActualizarEstadoPaqueteDocumentario(UserData().PaisID, UserData().CodigoConsultora, UserData().CampaniaID);
                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar el estado. Inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true,
                            message = ""
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
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult EnviarTxt(int paisID)
        {
            try
            {
                string[] file;
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    file = sv.GetPaqueteDocumentario(paisID);
                    if (file == null)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar el estado. Inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true,
                            message = ""
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
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult PaqueteDocumentario()
        {
            RVDigitalPaqueteDocumentarioModel model = new RVDigitalPaqueteDocumentarioModel();
            model.PaisID = UserData().PaisID;
            model.listaPaises = DropDowListPaises();

            return View(model);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            IList<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList().FindAll(x => x.PaisID == UserData().PaisID);
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

    }
}
