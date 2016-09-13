using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.Threading.Tasks;
using Portal.Consultoras.Web.ServiceODS;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class CUVAutomaticoController : BaseController
    {
        //
        // GET: /CUVAutomatico/

        public async Task<ActionResult> Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CUVAutomatico/Index"))
                return RedirectToAction("Index", "Bienvenida");


            await Task.Run(() => LoadConsultorasCache(11));
            var listaCampanias = DropDowListCampanias(11);

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
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }
        public void LoadConsultorasCache(int PaisID)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                sv.LoadConsultoraCodigo(PaisID);
            }
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            //PaisID = 11;
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            IEnumerable<CampaniaModel> lst;

            if (PaisID == 0)
            {
                lst = null;

                return Json(new
                {
                    lista = lst
                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                lst = DropDowListCampanias(PaisID);

                return Json(new
                {
                    lista = lst
                }, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult FindByCUVs(int campaniaID, int paisID, string codigo, int rowCount)
        {
            Mapper.CreateMap<ServiceODS.BEProductoDescripcion, GestionFaltantesModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

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
                object jsonData = null;
                string paisISO = UserData().CodigoISO;
                string CodigoUsuario = UserData().CodigoUsuario;
                string messageCodigosNoValidos = string.Empty;
                List<BECUVAutomatico> cuvautomaticos = new List<BECUVAutomatico>();

                string[] productosAValidar = codigos[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                productosAValidar = productosAValidar.Select(p => p.Trim()).ToArray<string>();

                List<ServiceODS.BEProductoDescripcion> productosValidos = new List<ServiceODS.BEProductoDescripcion>();

                //Productos a validar
                if (productosAValidar.Length != 0)
                {
                    List<string> productosNoValidos = new List<string>();
                    List<ServiceODS.BEProductoDescripcion> productoFaltante;

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        foreach (string cuv in productosAValidar)
                        {
                            productoFaltante = srv.GetProductoComercialByPaisAndCampania(campaniaID, cuv, paisID, 1).ToList();

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
                    //Registro de productos faltantes

                    foreach (ServiceODS.BEProductoDescripcion producto in productosValidos)
                    {
                        cuvautomaticos.Add(new BECUVAutomatico() { CampaniaID = campaniaID, CUV = producto.CUV, PaisISO = paisISO, UsuarioRegistro = CodigoUsuario });
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                bool rslt = false;
                using (SACServiceClient SACsrv = new SACServiceClient())
                {
                    BECUVAutomatico producto = new BECUVAutomatico()
                    {
                        CampaniaID = CampaniaID,
                        CUV = CUV
                    };

                    rslt = SACsrv.DelCUVAutomatico(UserData().PaisID, producto);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    int Records = 0, TotalPages = 0;
                    if (lst.Count > 0)
                    {
                        TotalPages = lst[0].TotalPages;
                        Records = lst[0].RowsCount;
                    }
                    var data = new
                    {
                        total = TotalPages,
                        page = page,
                        records = Records,
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
            catch (System.ServiceModel.FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
