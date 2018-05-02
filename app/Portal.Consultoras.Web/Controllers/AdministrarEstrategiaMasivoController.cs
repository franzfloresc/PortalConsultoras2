using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.ServicePedido;
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
        public JsonResult InsertEstrategiaTemporal(AdministrarEstrategiaMasivoModel entidadMasivo)
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
                        continuaPaso = true
                    }, JsonRequestBehavior.AllowGet);
                }
                
                var nroLoteAux = MasivoEstrategiaTemporalInsertar(entidadMasivo);

                if (nroLoteAux <= 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "No existen Estrategias para Insertar"
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    entidadMasivo.NroLote = nroLoteAux;
                }


                return Json(new
                {
                    success = entidadMasivo.NroLote > 0,
                    message = entidadMasivo.NroLote > 0 ? "Se insertaron en la tabla temporal de Estrategia." : "Error al insertar las estrategias",
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

        private List<BEEstrategia> InsertEstrategiaTemporalGetOfertas(int campaniaId, int tipoConfigurado, string estrategiaCodigo, int pagina, int cantidadCuv, out bool rpta)
        {
            var listBeEstrategias = new List<BEEstrategia>();
            rpta = false;
            try
            {
                using (var ps = new PedidoServiceClient())
                {
                    listBeEstrategias = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado, estrategiaCodigo, pagina, cantidadCuv).ToList();
                }
                rpta = true;
                return listBeEstrategias;

            }
            catch (TimeoutException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return listBeEstrategias;
        }

        private string InsertEstrategiaTemporalJoinCuv(List<BEEstrategia> listBeEstrategias)
        {
            try
            {
                if (listBeEstrategias == null || !listBeEstrategias.Any())
                    return "";

                var txtBuild = new StringBuilder();

                foreach (var estra in listBeEstrategias)
                {
                    estra.CUV2 = Util.Trim(estra.CUV2);
                    if (estra.CUV2 == "")
                        continue;

                    txtBuild.Append(estra.CUV2);
                    txtBuild.Append(",");
                }

                return txtBuild.ToString();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "";
            }
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

        private int InsertEstrategiaTemporalService(List<BEEstrategia> listaBeEstrategias, int campaniaId, int nroLote)
        {
            try
            {
                if (listaBeEstrategias.Any())
                {
                    using (var ps = new PedidoServiceClient())
                    {
                        nroLote = ps.InsertEstrategiaTemporal(userData.PaisID, listaBeEstrategias.ToArray(), campaniaId, userData.CodigoUsuario, nroLote);
                    }
                }
                return nroLote;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return 0;
            }
        }
        
        public JsonResult InsertEstrategiaOfertaParaTi(int campaniaId, int nroLote)
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
                    message = lote > 0 ? "Se insertaron las Estrategias." : "Error al insertar las estrategias."
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