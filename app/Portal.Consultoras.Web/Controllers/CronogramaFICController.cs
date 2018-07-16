using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CronogramaFICController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CronogramaFIC/Index"))
                return RedirectToAction("Index", "Bienvenida");
            CronogramaFICModel model = new CronogramaFICModel
            {
                listaPaises = DropDowListPaises(),
                listaZonas = new List<ZonaModel>(),
                DropDownListCampania = CargarCampania()
            };
            model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            return View(model);
        }

        public ActionResult ConfigurarCronogramaFIC()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CronogramaFIC/ConfigurarCronogramaFIC"))
                return RedirectToAction("Index", "Bienvenida");
            CronogramaFICModel model = new CronogramaFICModel
            {
                listaPaises = DropDowListPaises(),
                DropDownListCampania = CargarCampania()
            };
            return View(model);
        }

        public ActionResult DesactivarCronogramaFIC()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CronogramaFIC/DesactivarCronogramaFIC"))
                return RedirectToAction("Index", "Bienvenida");
            CronogramaFICModel model = new CronogramaFICModel
            {
                listaPaises = DropDowListPaises(),
                listaZonas = DropDownListZonas(UserData().PaisID),
                DropDownListCampania = CargarCampania()
            };
            return View(model);
        }

        public ActionResult DescargaModelo()
        {
            string fileName = "PlantillaModelFIC.xlsx";
            string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");

            if (!Directory.Exists(pathfaltante))
                Directory.CreateDirectory(pathfaltante);
            var finalPath = Path.Combine(pathfaltante, fileName);

            HttpContext.Response.Clear();
            HttpContext.Response.Buffer = false;
            HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + fileName);
            HttpContext.Response.Charset = "UTF-8";
            HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Response.ContentType = "application/octet-stream";
            HttpContext.Response.TransmitFile(finalPath);
            HttpContext.Response.Flush();
            HttpContext.Response.End();

            return View();
        }

        public ActionResult ConsultarCronogramaFIC(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID)
        {
            if (ModelState.IsValid)
            {
                List<BECronogramaFIC> lst;
                if (PaisID == "" || CampaniaID == "")
                    lst = new List<BECronogramaFIC>();
                else
                {
                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        lst = sv.GetCronogramaFICByCampania(Convert.ToInt32(PaisID), CampaniaID).ToList();
                    }
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BECronogramaFIC> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Zona":
                            items = lst.OrderBy(x => x.Zona);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderBy(x => x.Campania);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderBy(x => x.FechaFin);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Zona":
                            items = lst.OrderByDescending(x => x.Zona);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderByDescending(x => x.Campania);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderByDescending(x => x.FechaFin);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ZonaID,
                               cell = new string[]
                               {
                                   a.Campania,
                                   a.Zona,
                                   a.FechaFin == null ? "" : Convert.ToDateTime(a.FechaFin.ToString()).Day.ToString() + " de " + NombreMes(Convert.ToDateTime(a.FechaFin.ToString()).Month),
                                   a.ZonaID.ToString(),
                                   a.CampaniaID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ObtenerZonas(int PaisID, int CampaniaID)
        {
            bool issuccess;
            List<ZonaModel> lstZonasActivas;
            List<ZonaModel> lstZonasInactivas;
            try
            {
                lstZonasActivas = ObtenerZonasActivas(PaisID, CampaniaID);
                lstZonasInactivas = ObtenerZonasInactivas(PaisID, CampaniaID);
                issuccess = true;

                sessionManager.SetlstZonasActivas(lstZonasActivas);
                sessionManager.SetlstZonasInactivas(lstZonasInactivas);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }

            return Json(new
            {
                success = issuccess,
                lstZonasActivas = lstZonasActivas,
                lstZonasInactivas = lstZonasInactivas
            }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult InsCronogramaFIC(int PaisID, int CampaniaID, string ZonaCodigo)
        {
            bool issuccess = true;
            List<ZonaModel> lstZonasActivas;
            List<ZonaModel> lstZonasInactivas;
            List<ZonaModel> lstZonasInactivasEliminar = new List<ZonaModel>();

            string[] zonas = ZonaCodigo.Split(',');

            try
            {
                lstZonasActivas = sessionManager.GetlstZonasActivas();
                lstZonasInactivas = sessionManager.GetlstZonasInactivas();

                foreach (var item in lstZonasInactivas)
                {
                    foreach (string zona in zonas)
                    {
                        if (zona.Trim() == item.Codigo.Trim())
                        {
                            lstZonasActivas.Add(item);
                            lstZonasInactivasEliminar.Add(item);
                        }
                    }
                }

                foreach (var item in lstZonasInactivasEliminar)
                {
                    lstZonasInactivas.Remove(item);
                }

                lstZonasActivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));
                lstZonasInactivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));

                sessionManager.SetlstZonasActivas(lstZonasActivas);
                sessionManager.SetlstZonasInactivas(lstZonasInactivas);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                lstZonasActivas = null;
                lstZonasInactivas = null;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                lstZonasActivas = null;
                lstZonasInactivas = null;
            }

            return Json(new
            {
                success = issuccess,
                lstZonasActivas = lstZonasActivas,
                lstZonasInactivas = lstZonasInactivas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DelCronogramaFIC(int PaisID, int CampaniaID, string ZonaCodigo)
        {
            bool issuccess = true;
            List<ZonaModel> lstZonasActivas;
            List<ZonaModel> lstZonasInactivas;
            List<ZonaModel> lstZonasActivasEliminar = new List<ZonaModel>();

            string[] zonas = ZonaCodigo.Split(',');

            try
            {
                lstZonasActivas = sessionManager.GetlstZonasActivas();
                lstZonasInactivas = sessionManager.GetlstZonasInactivas();

                foreach (var item in lstZonasActivas)
                {
                    foreach (string zona in zonas)
                    {
                        if (zona.Trim() == item.Codigo.Trim())
                        {
                            lstZonasInactivas.Add(item);
                            lstZonasActivasEliminar.Add(item);
                        }
                    }
                }

                foreach (var item in lstZonasActivasEliminar)
                {
                    lstZonasActivas.Remove(item);
                }

                lstZonasActivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));
                lstZonasInactivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));

                sessionManager.SetlstZonasActivas(lstZonasActivas);
                sessionManager.SetlstZonasInactivas(lstZonasInactivas);

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }

            return Json(new
            {
                success = issuccess,
                lstZonasActivas = lstZonasActivas,
                lstZonasInactivas = lstZonasInactivas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult MantenerCronogramaFIC(int PaisID, int CampaniaID, string ZonaCodigoEliminar, string ZonaCodigoInsertar)
        {
            bool issuccess = true;
            string mensaje;
            try
            {
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    sv.InsInsCronogramaFIC(PaisID, CampaniaID.ToString(), ZonaCodigoInsertar);
                    sv.DelCronogramaFIC(PaisID, CampaniaID.ToString(), ZonaCodigoEliminar);
                }

                mensaje = "Los cambios han sido guardados correctamente.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                mensaje = "Ocurrió un error al guardar los cambios, por favor inténtelo más tarde.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                mensaje = "Ocurrió un error al guardar los cambios, por favor inténtelo más tarde.";
            }

            return Json(new
            {
                success = issuccess,
                message = mensaje
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EstablecerSesion(string ZonaCodigoEliminar)
        {
            try
            {
                sessionManager.SetZonaCodigoEliminar(ZonaCodigoEliminar);
                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito el Código de Oferta.",
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

        public JsonResult Update(CronogramaFICModel model)
        {
            #region Validar Fechas

            string mensaje = "";

            if (model.FechaFin.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

            if (mensaje != "")
            {
                return Json(new
                {
                    success = false,
                    message = mensaje,
                    extra = ""
                });
            }

            #endregion

            try
            {
                BECronogramaFIC entidad = Mapper.Map<CronogramaFICModel, BECronogramaFIC>(model);

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    sv.UpdCronogramaFIC(model.PaisID, entidad.Campania, entidad.Zona, entidad.FechaFin);
                }
                return Json(new
                {
                    success = true,
                    message = "Cronograma actualizado satisfactoriamente.",
                    extra = ""
                });
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public List<BECampania> CargarCampania()
        {
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                BECampania[] becampania = servicezona.SelectCampanias(11);
                return becampania.ToList();
            }
        }

        private List<ZonaModel> ObtenerZonasActivas(int paisId, int campaniaId)
        {
            IList<BEZona> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectZonasActivasFIC(paisId, campaniaId).ToList();
            }

            return Mapper.Map<IList<BEZona>, List<ZonaModel>>(lst);
        }

        private List<ZonaModel> ObtenerZonasInactivas(int paisId, int campaniaId)
        {
            IList<BEZona> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectZonasInactivasFIC(paisId, campaniaId).ToList();
            }

            return Mapper.Map<IList<BEZona>, List<ZonaModel>>(lst);
        }

        [HttpPost]
        public string ProcesarMasivo(HttpPostedFileBase uplArchivo, CronogramaFICModel model)
        {
            int paisId = model.PaisID;
            int campaniaId = Convert.ToInt32(model.NombreCorto.Trim());
            try
            {
                if (uplArchivo == null)
                {
                    return "El archivo especificado no existe.";
                }

                if (!Util.IsFileExtension(uplArchivo.FileName, Enumeradores.TypeDocExtension.Excel))
                {
                    return "El archivo especificado no es un documento de tipo MS-Excel.";
                }

                string fileextension = Path.GetExtension(uplArchivo.FileName) ?? "";

                if (!fileextension.ToLower().Equals(".xlsx"))
                {
                    return "Sólo se permiten archivos MS-Excel versiones 2007-2012.";
                }

                string fileName = Guid.NewGuid().ToString();
                string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");

                if (!Directory.Exists(pathfaltante))
                    Directory.CreateDirectory(pathfaltante);
                var finalPath = Path.Combine(pathfaltante, fileName + fileextension);
                uplArchivo.SaveAs(finalPath);

                bool isCorrect = false;
                CronogramaFICModel prod = new CronogramaFICModel();
                IList<CronogramaFICModel> lista = Util.ReadXmlFile(finalPath, prod, false, ref isCorrect);

                System.IO.File.Delete(finalPath);

                if (isCorrect && lista != null)
                {
                    var lst = Mapper.Map<IList<CronogramaFICModel>, IEnumerable<BECronogramaFIC>>(lista);

                    using (ZonificacionServiceClient srv = new ZonificacionServiceClient())
                    {
                        srv.InsCronogramaFICMasivo(paisId, campaniaId, lst.ToArray());
                    }
                    return "Se realizó satisfactoriamente la carga de datos.";
                }
                else
                {
                    return "Ocurrió un problema al cargar el documento o tal vez se encuentra vacío.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
        }

        public JsonResult CargarArbolRegionesZonas(string PaisID, string Codigocampaña, string ZonaID)
        {
            if (string.IsNullOrEmpty(PaisID))
                return Json(null, JsonRequestBehavior.AllowGet);

            if (string.IsNullOrEmpty(ZonaID))
                ZonaID = "x";

            List<BECronogramaFIC> lst;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.GetCronogramaFICByZona(Convert.ToInt32(PaisID), Codigocampaña, ZonaID).ToList();
            }

            var zonas = (from item in lst
                         select item.Zona).ToList();

            zonas = (from item in zonas
                     select item).Distinct().ToList();

            JsTreeModel2[] tree = zonas.Select(
                                 r => new JsTreeModel2
                                 {
                                     data = r,
                                     attr = new JsTreeAttribute_
                                     {
                                         tipo = 1,
                                         CodigoZona = r,
                                         selected = false
                                     },
                                     children = lst.Where(i => i.Zona.Trim() == r.Trim()).Select(
                                                         z => new JsTreeModel2
                                                         {
                                                             data = z.CodigoConsultora,
                                                             attr = new JsTreeAttribute_
                                                             {
                                                                 tipo = 2,
                                                                 CodigoZona = z.Zona,
                                                                 CodigoCampania = z.Campania,
                                                                 CodigoConsultora = z.CodigoConsultora,
                                                                 selected = false
                                                             }
                                                         }).ToArray()
                                 }).ToArray();
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DeshabilitarConsultoras(List<BECronogramaFIC> lista)
        {
            try
            {
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    foreach (BECronogramaFIC item in lista)
                    {
                        sv.DelCronogramaFICConsultora(UserData().PaisID, item.Campania, item.Zona, item.CodigoConsultora);
                    }
                }
                return SuccessJson("Modificación de cronograma exitosa.");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return ErrorJson(ex.Message);
            }
        }
    }
}
