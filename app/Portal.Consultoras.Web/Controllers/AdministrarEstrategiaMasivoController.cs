using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaMasivoController : BaseController
    {
        protected OfertaBaseProvider _ofertaBaseProvider;

        public AdministrarEstrategiaMasivoController()
        {
            _ofertaBaseProvider = new OfertaBaseProvider();
        }

        public ActionResult ConsultarOfertasParaTi(string sidx, string sord, int page, int rows, int campaniaId, string codigoEstrategia)
        {
            if (ModelState.IsValid)
            {
                int cantidadEstrategiasConfiguradas;
                int cantidadEstrategiasSinConfigurar;
                var txtBuildOddIdsEstrategia = new StringBuilder();
                try
                {
                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoEstrategia))
                    {
                        Dictionary<string, int> cantidades = administrarEstrategiaProvider.ObtenerCantidadOfertasParaTi(codigoEstrategia, campaniaId, userData.CodigoISO);
                        cantidadEstrategiasConfiguradas = cantidades["CUV_ZE"];
                        cantidadEstrategiasSinConfigurar = cantidades["CUV_OP"];

                        List<string> estrategiasWA = administrarEstrategiaProvider.PreCargar(campaniaId.ToString(), codigoEstrategia, userData.CodigoISO);
                        foreach (var item in estrategiasWA)
                        {
                            if (txtBuildOddIdsEstrategia.ToString() != "")
                                txtBuildOddIdsEstrategia.Append(",");
                            txtBuildOddIdsEstrategia.Append(item);
                        }
                    }
                    else
                    {
                        using (var svc = new SACServiceClient())
                        {
                            cantidadEstrategiasConfiguradas = svc.GetCantidadOfertasPersonalizadas(userData.PaisID, campaniaId, 1, codigoEstrategia);
                            cantidadEstrategiasSinConfigurar = svc.GetCantidadOfertasPersonalizadas(userData.PaisID, campaniaId, 2, codigoEstrategia);
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    cantidadEstrategiasConfiguradas = 0;
                    cantidadEstrategiasSinConfigurar = 0;
                }

                var lst = new List<ComunModel>
                {
                    new ComunModel
                    {
                        Id = 1,
                        Descripcion = codigoEstrategia == Constantes.TipoEstrategiaCodigo.HerramientasVenta ? "CUVS encontrados en Producto Comercial" : "CUVS encontrados en ofertas personalizadas.",
                        Valor = (cantidadEstrategiasConfiguradas + cantidadEstrategiasSinConfigurar).ToString(),
                        ValorOpcional = "0",
                        mongoIds = ""
                    },
                    new ComunModel
                    {
                        Id = 2,
                        Descripcion = "CUVS configurados en Zonas de Estrategias",
                        Valor = cantidadEstrategiasConfiguradas.ToString(),
                        ValorOpcional = "1",
                        mongoIds = ""
                    },
                    new ComunModel
                    {
                        Id = 3,
                        Descripcion = "CUVS por configurar en Zonas de Estrategias",
                        Valor = cantidadEstrategiasSinConfigurar.ToString(),
                        ValorOpcional = "2",
                        mongoIds = txtBuildOddIdsEstrategia.ToString()
                    }
                };

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ComunModel> items = lst;

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.Id,
                               cell = new string[]
                               {
                                    a.Id.ToString(),
                                    a.Descripcion,
                                    a.Valor,
                                    a.ValorOpcional,
                                    a.mongoIds
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public ActionResult ConsultarCuvTipoConfigurado(string sidx, string sord, int page, int rows, int campaniaId,
            int tipoConfigurado, string estrategiaCodigo, string estrategiaMIds)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, estrategiaCodigo))
                    {
                        List<EstrategiaMDbAdapterModel> webApiList = new List<EstrategiaMDbAdapterModel>();
                        if (tipoConfigurado == 0 || tipoConfigurado == 1)
                        {
                            webApiList.AddRange(administrarEstrategiaProvider.Listar(campaniaId.ToString(),
                                                                                     estrategiaCodigo,
                                                                                     userData.CodigoISO));
                        }
                        if (tipoConfigurado == 0 || tipoConfigurado == 2)
                        {
                            List<string> estrategiaMidsList = new List<string>();
                            estrategiaMidsList.AddRange(estrategiaMIds.Split(',').ToList());
                            if (estrategiaMidsList.Any())
                            {
                                var estado = administrarEstrategiaProvider.Listar(estrategiaMidsList, userData.CodigoISO);
                                webApiList.AddRange(estado);
                            }
                        }
                        lst.AddRange(webApiList.Select(d => d.BEEstrategia).Select(item => new BEEstrategia
                        {
                            CUV2 = item.CUV2,
                            DescripcionCUV2 = item.DescripcionCUV2
                        }));
                    }
                    else
                    {
                        using (var ps = new SACServiceClient())
                        {
                            lst =
                                ps.GetOfertasPersonalizadasByTipoConfigurado(userData.PaisID, campaniaId,
                                                                             tipoConfigurado, estrategiaCodigo, 1, -1)
                                  .ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    lst = new List<BEEstrategia>();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEEstrategia> items = lst;

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CUV2,
                               cell = new string[]
                               {
                                    a.CUV2,
                                    a.DescripcionCUV2
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public ActionResult ConsultarOfertasParaTiTemporal(string sidx, string sord, int page, int rows, int nroLote, int campaniaId, string codigoEstrategia)
        {
            if (ModelState.IsValid)
            {
                int cantidadEstrategiasConfiguradas;
                int cantidadEstrategiasSinConfigurar;
                const string oddIdsEstrategia = "";
                try
                {
                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoEstrategia))
                    {
                        Dictionary<string, int> cantidades = administrarEstrategiaProvider.ObtenerCantidadOfertasParaTi(codigoEstrategia, campaniaId, userData.CodigoISO);
                        cantidadEstrategiasConfiguradas = cantidades["CUV_OP"];
                        cantidadEstrategiasSinConfigurar = 0;
                    }
                    else
                    {
                        using (var ser = new SACServiceClient())
                        {
                            cantidadEstrategiasConfiguradas = ser.GetCantidadOfertasPersonalizadasTemporal(userData.PaisID, nroLote, 1);
                            cantidadEstrategiasSinConfigurar = ser.GetCantidadOfertasPersonalizadasTemporal(userData.PaisID, nroLote, 2);
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    cantidadEstrategiasConfiguradas = 0;
                    cantidadEstrategiasSinConfigurar = 0;
                }

                var lst = new List<ComunModel>
                {
                    new ComunModel
                    {
                        Id = 1,
                        Descripcion = "CUVS pre cargados correctamente",
                        Valor = cantidadEstrategiasConfiguradas.ToString(),
                        ValorOpcional = "1",
                        mongoIds = oddIdsEstrategia
                    },
                    new ComunModel
                    {
                        Id = 2,
                        Descripcion = "CUVS no pre cargados",
                        Valor = cantidadEstrategiasSinConfigurar.ToString(),
                        ValorOpcional = "2",
                        mongoIds = ""
                    }
                };

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<ComunModel> items = lst;

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.Id,
                               cell = new string[]
                               {
                                    a.Id.ToString(),
                                    a.Descripcion,
                                    a.Valor,
                                    a.ValorOpcional,
                                    a.mongoIds
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public JsonResult CancelarInsertEstrategiaTemporal(int nroLote)
        {
            try
            {
                using (var ser = new SACServiceClient())
                {
                    ser.EstrategiaTemporalDelete(userData.PaisID, nroLote);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = "",
                    nroLote
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                success = true,
                message = "Se eliminaron las estrategias de la tabla temporal",
                extra = "",
                nroLote
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ConsultarCuvTipoConfiguradoTemporal(string sidx, string sord, int page, int rows, int tipoConfigurado, int nroLote, int campaniaId, string codigoEstrategia, string estrategiaMIds)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoEstrategia))
                    {
                        if (tipoConfigurado == 1)
                        {
                            List<EstrategiaMDbAdapterModel> webApiList = new List<EstrategiaMDbAdapterModel>();

                            List<string> estrategiaMidsList = new List<string>();
                            estrategiaMidsList.AddRange(estrategiaMIds.Split(',').ToList());
                            if (estrategiaMidsList.Any())
                            {
                                var estado = administrarEstrategiaProvider.Listar(estrategiaMidsList, userData.CodigoISO);
                                webApiList.AddRange(estado);
                            }

                            lst.AddRange(webApiList.Select(d => d.BEEstrategia).Select(item => new BEEstrategia
                            {
                                CUV2 = item.CUV2,
                                DescripcionCUV2 = item.DescripcionCUV2
                            }));
                        }
                    }
                    else
                    {
                        using (var ser = new SACServiceClient())
                        {
                            lst = ser.GetOfertasPersonalizadasByTipoConfiguradoTemporal(userData.PaisID, tipoConfigurado, nroLote).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    lst = new List<BEEstrategia>();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEEstrategia> items = lst;

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CUV2,
                               cell = new string[]
                               {
                            a.CUV2,
                            a.DescripcionCUV2
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        #region EstrategiaTemporal Insert
        public JsonResult EstrategiaTemporalInsert(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            try
            {
                entidadMasivo.CantidadCuv = TablaLogicaObtenerCantidadCuvPagina(entidadMasivo);
                if (entidadMasivo.CantidadCuv <= 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "falta configurar una cantidad de Estrategias para Insertar"
                    }, JsonRequestBehavior.AllowGet);
                }

                entidadMasivo.Pagina = Math.Max(entidadMasivo.Pagina, 1);
                var cantTotalPagina = (entidadMasivo.CantTotal / entidadMasivo.CantidadCuv) + (entidadMasivo.CantTotal % entidadMasivo.CantidadCuv == 0 ? 0 : 1);
                if (cantTotalPagina < entidadMasivo.Pagina)
                {
                    return Json(new
                    {
                        success = true,
                        message = "Termino paso 2",
                        continuaPaso = true,
                        entidadMasivo.Pagina,
                        entidadMasivo.NroLote,
                        entidadMasivo.CantidadCuv
                    }, JsonRequestBehavior.AllowGet);
                }

                var nroLoteAux = MasivoEstrategiaTemporalInsertar(entidadMasivo);

                if (nroLoteAux <= 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "No existen Estrategias para Insertar",
                        entidadMasivo.Pagina,
                        entidadMasivo.NroLote,
                        entidadMasivo.CantidadCuv
                    }, JsonRequestBehavior.AllowGet);
                }

                entidadMasivo.NroLote = nroLoteAux;

                var mensajeComplemento = MasivoEstrategiaTemporalExecComplemento(entidadMasivo);

                return Json(new
                {
                    success = true,
                    message = "Se insertaron en la tabla temporal de Estrategia.",
                    messageComplemento = mensajeComplemento,
                    entidadMasivo.Pagina,
                    entidadMasivo.NroLote,
                    entidadMasivo.CantidadCuv
                }, JsonRequestBehavior.AllowGet);

            }
            catch (TimeoutException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Tiempo agotado de espera durante la extracion de los productos."
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se encontraron productos en ods.productocomercial."
                }, JsonRequestBehavior.AllowGet);
            }

        }

        private int TablaLogicaObtenerCantidadCuvPagina(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            if (entidadMasivo.CantidadCuv <= 0)
            {
                entidadMasivo.CantidadCuv = _tablaLogicaProvider.ObtenerValorTablaLogicaInt(userData.PaisID, Constantes.TablaLogica.CantidadCuvMasivo, Constantes.TablaLogicaDato.CantidadCuvMasivo_NuevoMasivo, true);
            }
            return entidadMasivo.CantidadCuv;
        }

        private int MasivoEstrategiaTemporalInsertar(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            int lote = 0;
            try
            {
                using (var svc = new SACServiceClient())
                {
                    lote = svc.EstrategiaTemporalInsertarMasivo(userData.PaisID, entidadMasivo.CampaniaId, entidadMasivo.EstrategiaCodigo, entidadMasivo.Pagina, entidadMasivo.CantidadCuv, entidadMasivo.NroLote);
                }
            }
            catch (TimeoutException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lote = 0;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lote = 0;
            }
            return lote;
        }

        private string MasivoEstrategiaTemporalExecComplemento(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            // este proceso esta en MasivoEstrategiaTemporalInsertar, puede salir timed out
            // se divide el proceso para evitar timed out
            string rpta = "";
            try
            {
                bool rptaService = MasivoEstrategiaTemporalPrecio(entidadMasivo);
                if (rptaService)
                {
                    rptaService = MasivoEstrategiaTemporalSetDetalle(entidadMasivo);
                    if (!rptaService)
                    {
                        rpta = "Error al cargar tonos.";
                    }
                }
                else
                {
                    rpta = "Error al cargar precios.";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return rpta;
        }

        private bool MasivoEstrategiaTemporalPrecio(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            bool rpta;
            try
            {
                using (var svc = new SACServiceClient())
                {
                    svc.EstrategiaTemporalActualizarPrecioNivel(userData.PaisID, entidadMasivo.NroLote, entidadMasivo.Pagina);
                }
                rpta = true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                rpta = false;
            }

            return rpta;
        }

        private bool MasivoEstrategiaTemporalSetDetalle(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            bool rpta = false;
            try
            {
                var codigo = _tablaLogicaProvider.ObtenerValorTablaLogicaInt(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.Tonos, true);
                if (codigo > entidadMasivo.CampaniaId)
                    return rpta;

                using (var svc = new SACServiceClient())
                {
                    svc.EstrategiaTemporalActualizarSetDetalle(userData.PaisID, entidadMasivo.NroLote, entidadMasivo.Pagina);
                }
                rpta = true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                rpta = false;
            }
            return rpta;
        }
        #endregion

        [HttpPost]
        public JsonResult EstrategiaOfertasPersonalizadasInsert(int campaniaId, int nroLote, string codigoEstrategia, string estrategiaMIds)
        {
            try
            {
                int lote = 0;
                //string idsEstrategiaok = string.Empty;
                //string idsEstrategiaerror = string.Empty;
                var txtBuildIdsEstrategiaOk = new StringBuilder();
                var txtBuildIdsEstrategiaError = new StringBuilder();

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, codigoEstrategia))
                {
                    List<string> estrategiaMidsList = new List<string>();
                    estrategiaMidsList.AddRange(estrategiaMIds.Split(',').ToList());
                    if (estrategiaMidsList.Any())
                    {

                        var estado = administrarEstrategiaProvider.CargarEstrategia(estrategiaMidsList, userData.CodigoISO);
                        lote = estado["CUVOK"].Count;
                        foreach (var item in estado["CUVOK"])
                        {
                            if (txtBuildIdsEstrategiaOk.ToString() != "")
                                txtBuildIdsEstrategiaOk.Append(",");
                            txtBuildIdsEstrategiaOk.Append(item);
                        }
                        foreach (var item in estado["CUVERROR"])
                        {
                            if (txtBuildIdsEstrategiaError.ToString() != "")
                                txtBuildIdsEstrategiaError.Append(",");
                            txtBuildIdsEstrategiaError.Append(item);
                        }
                    }
                }
                else
                {
                    using (var svc = new SACServiceClient())
                    {
                        lote = svc.EstrategiaTemporalInsertarEstrategiaMasivo(userData.PaisID, nroLote);
                    }
                }

                administrarEstrategiaProvider.JobBuscador(campaniaId.ToString(), codigoEstrategia, userData);

                return Json(new
                {
                    success = lote > 0,
                    message = lote > 0 ? "Se insertaron las Estrategias." : "Error al insertar las estrategias.",
                    NroLote = nroLote,
                    NroLoteRetorno = lote,
                    mongoIdsOK = txtBuildIdsEstrategiaOk,
                    mongoIdsERROR = txtBuildIdsEstrategiaError
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}