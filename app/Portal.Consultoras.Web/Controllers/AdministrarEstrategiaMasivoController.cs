﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaMasivoController : BaseController
    {
        public ActionResult ConsultarOfertasParaTi(string sidx, string sord, int page, int rows, int CampaniaID,
           string CodigoEstrategia)
        {
            if (ModelState.IsValid)
            {
                int cantidadEstrategiasConfiguradas;
                int cantidadEstrategiasSinConfigurar;

                try
                {
                    using (var svc = new SACServiceClient())
                    {
                        cantidadEstrategiasConfiguradas = svc.GetCantidadOfertasPersonalizadas(userData.PaisID, CampaniaID, 1, CodigoEstrategia);
                        cantidadEstrategiasSinConfigurar = svc.GetCantidadOfertasPersonalizadas(userData.PaisID, CampaniaID, 2, CodigoEstrategia);
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
                        Descripcion = CodigoEstrategia == Constantes.TipoEstrategiaCodigo.HerramientasVenta ? "CUVS encontrados en Producto Comercial" : "CUVS encontrados en ofertas personalizadas.",
                        Valor = (cantidadEstrategiasConfiguradas + cantidadEstrategiasSinConfigurar).ToString(),
                        ValorOpcional = "0"
                    },
                    new ComunModel
                    {
                        Id = 2,
                        Descripcion = "CUVS configurados en Zonas de Estrategias",
                        Valor = cantidadEstrategiasConfiguradas.ToString(),
                        ValorOpcional = "1"
                    },
                    new ComunModel
                    {
                        Id = 3,
                        Descripcion = "CUVS por configurar en Zonas de Estrategias",
                        Valor = cantidadEstrategiasSinConfigurar.ToString(),
                        ValorOpcional = "2"
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
                                    a.ValorOpcional
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public ActionResult ConsultarCuvTipoConfigurado(string sidx, string sord, int page, int rows, int campaniaId,
            int tipoConfigurado, string estrategiaCodigo)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst;

                try
                {
                    using (var ps = new SACServiceClient())
                    {
                        lst = ps.GetOfertasPersonalizadasByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado, estrategiaCodigo, 1, -1).ToList();
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

        public ActionResult ConsultarOfertasParaTiTemporal(string sidx, string sord, int page, int rows, int nroLote)
        {
            if (ModelState.IsValid)
            {
                int cantidadEstrategiasConfiguradas;
                int cantidadEstrategiasSinConfigurar;

                try
                {
                    using (var ser = new SACServiceClient())
                    {
                        cantidadEstrategiasConfiguradas = ser.GetCantidadOfertasPersonalizadasTemporal(userData.PaisID, nroLote, 1);
                        cantidadEstrategiasSinConfigurar = ser.GetCantidadOfertasPersonalizadasTemporal(userData.PaisID, nroLote, 2);
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
                        ValorOpcional = "1"
                    },
                    new ComunModel
                    {
                        Id = 2,
                        Descripcion = "CUVS no pre cargados",
                        Valor = cantidadEstrategiasSinConfigurar.ToString(),
                        ValorOpcional = "2"
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
                            a.ValorOpcional
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

        public ActionResult ConsultarCuvTipoConfiguradoTemporal(string sidx, string sord, int page, int rows, int tipoConfigurado, int nroLote)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst;

                try
                {
                    using (var ser = new SACServiceClient())
                    {
                        lst = ser.GetOfertasPersonalizadasByTipoConfiguradoTemporal(userData.PaisID, tipoConfigurado, nroLote)
                            .ToList();
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
                    if (cantTotalPagina > 0)
                    {
                        MasivoEstrategiaTemporalExecComplemento(entidadMasivo);
                    }

                    return Json(new
                    {
                        success = cantTotalPagina > 0,
                        message = cantTotalPagina > 0 ? "" : "No existen Estrategias para Insertar",
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
                else
                {
                    entidadMasivo.NroLote = nroLoteAux;
                }


                return Json(new
                {
                    success = entidadMasivo.NroLote > 0,
                    message = entidadMasivo.NroLote > 0 ? "Se insertaron en la tabla temporal de Estrategia." : "Error al insertar las Estrategias Temporal.",
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
                entidadMasivo.CantidadCuv = ObtenerValorTablaLogicaInt(userData.PaisID, Constantes.TablaLogica.CantidadCuvMasivo, Constantes.TablaLogicaDato.CantidadCuvMasivo_NuevoMasivo, true);
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
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return lote;
        }

        private bool MasivoEstrategiaTemporalExecComplemento(AdministrarEstrategiaMasivoModel entidadMasivo)
        {
            bool rpta = true;
            try
            {
                MasivoEstrategiaTemporalPrecio(entidadMasivo);
                MasivoEstrategiaTemporalSetDetalle(entidadMasivo);
            }
            catch (Exception)
            {
                rpta = false;
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
                    rpta = svc.EstrategiaTemporalActualizarPrecioNivel(userData.PaisID, entidadMasivo.NroLote);
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
                var codigo = ObtenerValorTablaLogicaInt(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.Tonos, true);
                if (codigo > entidadMasivo.CampaniaId)
                    return rpta;

                using (var svc = new SACServiceClient())
                {
                    rpta = svc.EstrategiaTemporalActualizarSetDetalle(userData.PaisID, entidadMasivo.NroLote);
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
        
        public JsonResult EstrategiaOfertasPersonalizadasInsert(int campaniaId, int nroLote)
        {
            try
            {
                int lote = 0;

                using (var svc = new SACServiceClient())
                {
                    lote = svc.EstrategiaTemporalInsertarEstrategiaMasivo(userData.PaisID, nroLote);
                }

                return Json(new
                {
                    success = lote > 0,
                    message = lote > 0 ? "Se insertaron las Estrategias." : "Error al insertar las estrategias.",
                    NroLote = nroLote,
                    NroLoteRetorno = lote
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