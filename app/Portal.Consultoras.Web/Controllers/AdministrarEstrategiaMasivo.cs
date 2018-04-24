using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Web.CustomHelpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Portal.Consultoras.Web.ServiceUsuario;
using BEConfiguracionPaisDatos = Portal.Consultoras.Web.ServiceUsuario.BEConfiguracionPaisDatos;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaMasivoController : BaseController
    {
        public JsonResult InsertEstrategiaTemporal(int campaniaId, int tipoConfigurado, string estrategiaCodigo,
           bool habilitarNemotecnico, int cantGuardadaTemporal, int cantTotal, int nroLote, int pagina, int cantidadOp)
        {

            try
            {
                int cantidadCuv = ObtenerValorTablaLogicaInt(userData.PaisID, Constantes.TablaLogica.CantidadCuvMasivo, Constantes.TablaLogicaDato.CantidadCuvMasivo_NuevoMasivo, true);
                if (cantidadCuv <= 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "falta configurar una cantidad de Estrategias para Insertar"
                    }, JsonRequestBehavior.AllowGet);
                }

                pagina = Math.Max(pagina, 1);
                bool rpta;
                List<BEEstrategia> listBeEstrategias = InsertEstrategiaTemporalGetOfertas(campaniaId, tipoConfigurado, estrategiaCodigo, pagina, cantidadCuv, out rpta);

                if (!rpta)
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se encontraron productos en ods.productocomercial."
                    }, JsonRequestBehavior.AllowGet);
                }

                if (!listBeEstrategias.Any())
                {
                    var cantTotalPagina = (cantidadOp / cantidadCuv) + (cantidadOp % cantidadCuv == 0 ? 0 : 1);
                    if (cantTotalPagina <= pagina)
                    {
                        return Json(new
                        {
                            success = cantGuardadaTemporal > 0,
                            message = cantGuardadaTemporal > 0 ? "" : "No existen Estrategias para Insertar"
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                string joinCuv = InsertEstrategiaTemporalJoinCuv(listBeEstrategias);

                MasivoEstrategiaTemporalPrecio(campaniaId, estrategiaCodigo, joinCuv);
                MasivoEstrategiaTemporalSetDetalle(campaniaId, estrategiaCodigo, joinCuv);
                
                nroLote = InsertEstrategiaTemporalService(listBeEstrategias, campaniaId, nroLote);

                return Json(new
                {
                    success = nroLote > 0,
                    message = nroLote > 0 ? "Se insertaron en la tabla temporal de Estrategia." : "Error al insertar las estrategias",
                    extra = "",
                    pagina,
                    cantGuardadaTemporal = listBeEstrategias.Count,
                    NroLote = nroLote
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

        private bool MasivoEstrategiaTemporalPrecio(int campaniaId, string estrategiaCodigo, string joinCuv)
        {
            bool rpta;
            try
            {
                using (var svc = new SACServiceClient())
                {
                    rpta = svc.EstrategiaTemporalActualizarPrecioNivel(userData.PaisID, campaniaId, estrategiaCodigo, joinCuv);
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

        private bool MasivoEstrategiaTemporalSetDetalle(int campaniaId, string estrategiaCodigo, string joinCuv)
        {
            bool rpta = false;
            try
            {
                var codigo = ObtenerValorTablaLogicaInt(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.Tonos, true);
                if (codigo > campaniaId)
                    return rpta;

                using (var svc = new SACServiceClient())
                {
                    rpta = svc.EstrategiaTemporalActualizarSetDetalle(userData.PaisID, campaniaId, estrategiaCodigo, joinCuv);
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
    }
}