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

            participantesConsultora.listaCampania = DropDowListCampanias(UserData().PaisID);
            participantesConsultora.CodigoUsuario = UserData().CodigoUsuario;

            return View(participantesConsultora);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenerConfiguracionConsultora(string sidx, string sord, int page, int rows, string vBusqueda, string CodigoCampania, string CodigoConsultora)
        {

            IList<BEParticipantesDemandaAnticipada> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetParticipantesConfiguracionConsultoraDA(UserData().PaisID, CodigoCampania, CodigoConsultora);
            }

            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
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

            if (string.IsNullOrEmpty(vBusqueda))
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            else
                items = items.Where(p => p.Fecha.ToString().ToUpper().Contains(vBusqueda.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

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
                string id_ = Request.Form["TxtEditId"];
                string ZonaID = Request.Form["TxtZonaID"];
                string ConsultoraID = Request.Form["TxtConsultoraID"];
                string CodigoCampania = Request.Form["TxtCodigoCampania"];
                string Fecha = Request.Form["TxtFecha"];
                string TipoConfiguracion = Request.Form["TxtTipoConfiguracion"];
                string CodigoUsuario = UserData().CodigoUsuario;


                BEParticipantesDemandaAnticipada obj = null;
                obj = new BEParticipantesDemandaAnticipada();

                if (!string.IsNullOrEmpty(id_)) obj.ConfiguracionConsultoraDAID = int.Parse(id_);

                obj.ZonaID = Convert.ToInt32(ZonaID);
                obj.ConsultoraID = Convert.ToInt32(ConsultoraID);
                obj.CodigoCampania = CodigoCampania;

                if (Fecha != "")
                {
                    obj.Fecha = Convert.ToDateTime(Fecha);
                }

                obj.TipoConfiguracion = Convert.ToByte(TipoConfiguracion);
                obj.CodigoUsuario = CodigoUsuario;

                int validar = 0;
                if (!(id_ == ""))
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {

                        validar = sv.InsParticipantesDemandaAnticipada(UserData().PaisID, obj);

                    }
                }
                else
                {
                    BEConfiguracionConsultoraDA configuracionConsultoraDA = new BEConfiguracionConsultoraDA();
                    configuracionConsultoraDA.ZonaID = Convert.ToInt32(ZonaID);
                    configuracionConsultoraDA.ConsultoraID = Convert.ToInt32(ConsultoraID);
                    configuracionConsultoraDA.CampaniaID = Convert.ToString(CodigoCampania);
                    configuracionConsultoraDA.TipoConfiguracion = Convert.ToByte(TipoConfiguracion);
                    configuracionConsultoraDA.CodigoUsuario = Convert.ToString(UserData().CodigoUsuario);
                    using (SACServiceClient sv = new SACServiceClient())
                    {

                        validar = sv.InsConfiguracionConsultoraDA(UserData().PaisID, configuracionConsultoraDA);

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
                lista = sv.GetConsultoraByCodigo(UserData().PaisID, codigoConsultora);
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
                lista = sv.GetCampaniaActualByZona(UserData().PaisID, CodigoZona);
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

        public BEPager Paginador(BEGrid item, string CodigoCampania)
        {
            List<BEParticipantesDemandaAnticipada> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetParticipantesConfiguracionConsultoraDA(UserData().PaisID, CodigoCampania, UserData().CodigoConsultora).ToList();
            }

            BEPager pag = new BEPager();

            int RecordCount;

            if (string.IsNullOrEmpty(CodigoCampania))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Count(p => p.Fecha.ToString().Contains(CodigoCampania.ToUpper()));

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        public ActionResult ExportarExcel(string CodigoCampania)
        {
            IList<BEParticipantesDemandaAnticipada> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetParticipantesConfiguracionConsultoraDA(UserData().PaisID, CodigoCampania, "").ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Campaña", "CodigoCampania");
            dic.Add("Código Zona", "CodigoZona");
            dic.Add("Código Consultora", "CodigoConsultora");
            dic.Add("Nombre Completo", "NombreCompleto");
            dic.Add("Aceptó Participar?", "AceptoParticipar");
            dic.Add("Monto Pedido Web", "ImporteTotal");
            dic.Add("Fecha Creación", "FechaFormato");
            dic.Add("Fecha Modificación", "FechaModificadaFormato");
            dic.Add("Codigo Usuario", "CodigoUsuario");
            Util.ExportToExcel<BEParticipantesDemandaAnticipada>("ParticipantesDemandaAnticipadaExcel", lst.ToList(), dic);
            return View();
        }

    }
}
