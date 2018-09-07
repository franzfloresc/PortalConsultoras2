using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CUVAutomaticoController : BaseController
    {
        public async Task<ActionResult> Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CUVAutomatico/Index"))
                return RedirectToAction("Index", "Bienvenida");

            await Task.Run(() => LoadConsultorasCache(11));

            var oCuvAutomaticoModel = new CuvAutomaticoModel()
            {
                listaCampanias = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                listaRegiones = new List<RegionModel>(),
                listaZonas = new List<ZonaModel>()
            };
            return View(oCuvAutomaticoModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public void LoadConsultorasCache(int paisId)
        {
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                sv.LoadConsultoraCodigo(paisId);
            }
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            if (PaisID == 0)
            {
                return Json(new
                {
                    lista = (IEnumerable<CampaniaModel>)null
                }, JsonRequestBehavior.AllowGet);
            }

            var lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult FindByCUVs(int campaniaID, int paisID, string codigo, int rowCount)
        {
            List<ServiceODS.BEProductoDescripcion> lista;
            using (ODSServiceClient srv = new ODSServiceClient())
            {
                lista = srv.GetProductoComercialByPaisAndCampania(campaniaID, codigo, paisID, rowCount).ToList();
            }

            var lstModel = Mapper.Map<IList<ServiceODS.BEProductoDescripcion>, IEnumerable<GestionFaltantesModel>>(lista);

            return Json(lstModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Insertar(int paisID, int campaniaID, List<string> codigos)
        {
            try
            {
                object jsonData;
                string paisIso = userData.CodigoISO;
                string codigoUsuario = userData.CodigoUsuario;
                string messageCodigosNoValidos = string.Empty;
                List<BECUVAutomatico> cuvautomaticos = new List<BECUVAutomatico>();

                string[] productosAValidar = codigos[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                productosAValidar = productosAValidar.Select(p => p.Trim()).ToArray<string>();

                List<ServiceODS.BEProductoDescripcion> productosValidos = new List<ServiceODS.BEProductoDescripcion>();

                if (productosAValidar.Length != 0)
                {
                    List<string> productosNoValidos = new List<string>();

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        foreach (string cuv in productosAValidar)
                        {
                            var productoFaltante = srv.GetProductoComercialByPaisAndCampania(campaniaID, cuv, paisID, 1).ToList();

                            if (productoFaltante.Count == 0 || productoFaltante[0].CUV != cuv)
                            {
                                productosNoValidos.Add(cuv);
                            }
                            else
                            {
                                productosValidos.Add(productoFaltante[0]);
                            }
                        }
                    }

                    if (productosNoValidos.Count != 0)
                    {
                        messageCodigosNoValidos = (messageCodigosNoValidos != string.Empty ? messageCodigosNoValidos + "\r\n" : "") +
                                                  "Los siguientes códigos de venta no son válidos: " +
                                                  string.Join(",", productosNoValidos.Select(z => z));
                    }
                }

                if (messageCodigosNoValidos != string.Empty)
                {
                    jsonData = new
                    {
                        success = false,
                        message = messageCodigosNoValidos,
                        extra = ""
                    };
                }
                else
                {
                    foreach (ServiceODS.BEProductoDescripcion producto in productosValidos)
                    {
                        cuvautomaticos.Add(new BECUVAutomatico() { CampaniaID = campaniaID, CUV = producto.CUV, PaisISO = paisIso, UsuarioRegistro = codigoUsuario });
                    }



                    using (SACServiceClient sv = new SACServiceClient())
                    {

                        sv.InsCuvAutomatico(paisID, cuvautomaticos.ToArray());
                    }

                    jsonData = new
                    {
                        success = true,
                        message = "Los registros han sido ingresados satisfactoriamente.",
                        extra = ""
                    };
                }


                return Json(jsonData);



            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar(int CampaniaID, string CUV)
        {
            try
            {
                using (SACServiceClient saCsrv = new SACServiceClient())
                {
                    BECUVAutomatico producto = new BECUVAutomatico()
                    {
                        CampaniaID = CampaniaID,
                        CUV = CUV
                    };

                    saCsrv.DelCUVAutomatico(userData.PaisID, producto);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
                    extra = ""
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, int campaniaID)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<BECUVAutomatico> lst;
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        BECUVAutomatico producto = new BECUVAutomatico()
                        {
                            CampaniaID = campaniaID
                        };

                        lst = srv.GetProductoCuvAutomatico(paisID, producto, sidx, sord, page, 1, rows).ToList();
                    }
                    int records = 0, totalPages = 0;
                    if (lst.Count > 0)
                    {
                        totalPages = lst[0].TotalPages;
                        records = lst[0].RowsCount;
                    }
                    var data = new
                    {
                        total = totalPages,
                        page = page,
                        records = records,
                        rows = from a in lst
                               select new
                               {
                                   cell = new string[]
                                   {
                                       a.CampaniaID.ToString(),
                                       a.CUV,
                                       a.Descripcion
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);


                }
                return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
        }
    }
}
