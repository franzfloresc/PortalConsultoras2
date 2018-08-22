using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ParticipantesDemandaAnticipadaController : BaseController
    {
        public ActionResult Index()
        {
            var participantesConsultora = new ParticipantesDemandaAnticipadaModel()
            {
                listaCampania = new List<CampaniaModel>(),

            };

            participantesConsultora.listaCampania = DropDowListCampanias(userData.PaisID);
            participantesConsultora.CodigoUsuario = userData.CodigoUsuario;

            return View(participantesConsultora);
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

        public JsonResult ObtenerConfiguracionConsultora(string sidx, string sord, int page, int rows, string vBusqueda, string CodigoCampania, string CodigoConsultora)
        {

            IList<BEParticipantesDemandaAnticipada> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetParticipantesConfiguracionConsultoraDA(userData.PaisID, CodigoCampania, CodigoConsultora);
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            IEnumerable<BEParticipantesDemandaAnticipada> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "ConfiguracionConsultoraDAID":
                        items = lst.OrderBy(x => x.ConfiguracionConsultoraDAID);
                        break;
                    case "CodigoCampania":
                        items = lst.OrderBy(x => x.CodigoCampania);
                        break;
                    case "CodigoZona":
                        items = lst.OrderBy(x => x.CodigoZona);
                        break;
                    case "CodigoConsultora":
                        items = lst.OrderBy(x => x.CodigoConsultora);
                        break;
                    case "NombreCompleta":
                        items = lst.OrderBy(x => x.NombreCompleto);
                        break;
                    case "TipoConfiguracion":
                        items = lst.OrderBy(x => x.TipoConfiguracion);
                        break;
                    case "ImporteTotal":
                        items = lst.OrderBy(x => x.ImporteTotal);
                        break;
                    case "Fecha":
                        items = lst.OrderBy(x => x.Fecha);
                        break;
                    case "FechaModificada":
                        items = lst.OrderBy(x => x.FechaModificada);
                        break;
                    case "CodigoUsuario":
                        items = lst.OrderBy(x => x.CodigoUsuario);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "ConfiguracionConsultoraDAID":
                        items = lst.OrderByDescending(x => x.ConfiguracionConsultoraDAID);
                        break;
                    case "CodigoCampania":
                        items = lst.OrderByDescending(x => x.CodigoCampania);
                        break;
                    case "CodigoZona":
                        items = lst.OrderByDescending(x => x.CodigoZona);
                        break;
                    case "CodigoConsultora":
                        items = lst.OrderByDescending(x => x.CodigoConsultora);
                        break;
                    case "NombreCompleto":
                        items = lst.OrderByDescending(x => x.NombreCompleto);
                        break;
                    case "TipoConfiguracion":
                        items = lst.OrderByDescending(x => x.TipoConfiguracion);
                        break;
                    case "ImporteTotal":
                        items = lst.OrderByDescending(x => x.ImporteTotal);
                        break;
                    case "Fecha":
                        items = lst.OrderByDescending(x => x.Fecha);
                        break;
                    case "FechaModificada":
                        items = lst.OrderByDescending(x => x.FechaModificada);
                        break;
                    case "CodigoUsuario":
                        items = lst.OrderByDescending(x => x.CodigoUsuario);
                        break;
                }
            }
            #endregion

            items = string.IsNullOrEmpty(vBusqueda)
                ? items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize)
                : items.Where(p => p.Fecha.ToString().ToUpper().Contains(vBusqueda.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = Paginador(grid, vBusqueda);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.ConfiguracionConsultoraDAID.ToString(),
                           cell = new string[]
                               {
                                   a.ConfiguracionConsultoraDAID.ToString(),
                                   a.ZonaID.ToString(),
                                   a.ConsultoraID.ToString(),
                                   a.CodigoCampania,
                                   a.CodigoZona,
                                   a.CodigoConsultora,
                                   a.NombreCompleto,
                                   a.TipoConfiguracion.ToString(),
                                   a.AceptoParticipar,
                                   a.ImporteTotal.ToString(),
                                   a.Fecha.ToString(),
                                   a.FechaModificada.ToString(),
                                   a.CodigoUsuario
                                }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ActionName("GuardarParticipantesDemandaAnticipada")]
        public ActionResult GuardarParticipantesDemandaAnticipada()
        {

            bool saveerror = false;
            string mensaje = "";
            int idgenerado = 0;
            try
            {
                string id = Request.Form["TxtEditId"];
                string zonaId = Request.Form["TxtZonaID"];
                string consultoraId = Request.Form["TxtConsultoraID"];
                string codigoCampania = Request.Form["TxtCodigoCampania"];
                string fecha = Request.Form["TxtFecha"];
                string tipoConfiguracion = Request.Form["TxtTipoConfiguracion"];
                string codigoUsuario = userData.CodigoUsuario;


                var obj = new BEParticipantesDemandaAnticipada();

                if (!string.IsNullOrEmpty(id)) obj.ConfiguracionConsultoraDAID = int.Parse(id);

                obj.ZonaID = Convert.ToInt32(zonaId);
                obj.ConsultoraID = Convert.ToInt32(consultoraId);
                obj.CodigoCampania = codigoCampania;

                if (fecha != "")
                {
                    obj.Fecha = Convert.ToDateTime(fecha);
                }

                obj.TipoConfiguracion = Convert.ToByte(tipoConfiguracion);
                obj.CodigoUsuario = codigoUsuario;
                
                if (id != "")
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        sv.InsParticipantesDemandaAnticipada(userData.PaisID, obj);
                    }
                }
                else
                {
                    BEConfiguracionConsultoraDA configuracionConsultoraDa =
                        new BEConfiguracionConsultoraDA
                        {
                            ZonaID = Convert.ToInt32(zonaId),
                            ConsultoraID = Convert.ToInt32(consultoraId),
                            CampaniaID = Convert.ToString(codigoCampania),
                            TipoConfiguracion = Convert.ToByte(tipoConfiguracion),
                            CodigoUsuario = Convert.ToString(userData.CodigoUsuario)
                        };

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                       sv.InsConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDa);
                    }
                }

            }
            catch (Exception ex)
            {

                mensaje = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                saveerror = true;
            }

            dynamic data = new
            {
                idkey = idgenerado,
                mensaje = mensaje,
                error = saveerror
            };
            JsonResult jsonres = Json(data, JsonRequestBehavior.AllowGet);
            return jsonres;
        }

        public JsonResult GetConsultoraByCodigo(string codigoConsultora = "")
        {
            BEParticipantesDemandaAnticipada lista;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lista = sv.GetConsultoraByCodigo(userData.PaisID, codigoConsultora);
            }

            var vacio = new { };
            if (lista != null)
            {
                var itemNuevo = new
                {
                    ConsultoraID = lista.ConsultoraID,
                    CodigoConsultora = lista.CodigoConsultora,
                    ZonaID = lista.ZonaID,
                    CodigoZona = lista.CodigoZona,
                    NombreZona = lista.NombreZona,
                    NombreCompleto = lista.NombreCompleto,
                    CodigoCampania = lista.CodigoCampania,
                    Fecha = lista.Fecha,
                    TipoConfiguracion = lista.TipoConfiguracion

                };
                JsonResult jsonres = Json(itemNuevo, JsonRequestBehavior.AllowGet);
                return jsonres;
            }
            return Json(vacio, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCampaniaActualByZona(string CodigoZona = "")
        {
            BEConfiguracionCampania lista;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lista = sv.GetCampaniaActualByZona(userData.PaisID, CodigoZona);
            }

            var vacio = new { };
            if (lista != null)
            {
                var itemNuevo = new
                {
                    CampaniaID = lista.CampaniaID
                };
                JsonResult jsonres = Json(itemNuevo, JsonRequestBehavior.AllowGet);
                return jsonres;
            }
            return Json(vacio, JsonRequestBehavior.AllowGet);
        }

        public BEPager Paginador(BEGrid item, string codigoCampania)
        {
            List<BEParticipantesDemandaAnticipada> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetParticipantesConfiguracionConsultoraDA(userData.PaisID, codigoCampania, userData.CodigoConsultora).ToList();
            }

            BEPager pag = new BEPager();

            var recordCount = string.IsNullOrEmpty(codigoCampania) ? lst.Count : lst.Count(p => p.Fecha.ToString().Contains(codigoCampania.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public ActionResult ExportarExcel(string CodigoCampania)
        {
            IList<BEParticipantesDemandaAnticipada> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetParticipantesConfiguracionConsultoraDA(userData.PaisID, CodigoCampania, "").ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Campaña", "CodigoCampania"},
                {"Código Zona", "CodigoZona"},
                {"Código Consultora", "CodigoConsultora"},
                {"Nombre Completo", "NombreCompleto"},
                {"Aceptó Participar?", "AceptoParticipar"},
                {"Monto Pedido Web", "ImporteTotal"},
                {"Fecha Creación", "FechaFormato"},
                {"Fecha Modificación", "FechaModificadaFormato"},
                {"Codigo Usuario", "CodigoUsuario"}
            };
            Util.ExportToExcel<BEParticipantesDemandaAnticipada>("ParticipantesDemandaAnticipadaExcel", lst.ToList(), dic);
            return View();
        }

    }
}
