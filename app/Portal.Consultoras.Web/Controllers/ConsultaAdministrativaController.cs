using AutoMapper;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultaAdministrativaController : BaseController
    {
        //
        // GET: /ConsultaAdministrativa/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ConsultaConsultora()
        {
            ConsultaAdministrativaModel model = new ConsultaAdministrativaModel();

            model.listaPaises = DropDowListPaises();

            return View(model);
        }

        [HttpPost]
        public JsonResult RedirectConsultaConsultora()
        {
            return Json(new
            {
                success = true,
                redirectTo = Url.Action("ConsultaConsultora", "ConsultaAdministrativa"),
            }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult ObtenterDatosConsultora(int PaisID, string CodigoConsultora)
        {
            BEConsultoraDatos consultora = null;
            List<BETablaLogicaDatos> list_segmentos = new List<BETablaLogicaDatos>();
            string CodConsultora = "", NombreCompleto = "", CodigoZona = "", CodigorRegion = "", EstadoActividad = "", Segmento = "", FechaNacimiento = "",
                    EstadoCivil = "", KtiNueva = "", AutorizaPedido = "", EMail = "", MontoUltimoPedido = "", MontoFlexipago = "", UltimaCampanaFacturada = "",
                    MontoMaximoPedido = "", MontoMinimoPedido = "", FechaIngreso = "", MontoSaldoActual = "", PasePedidoWeb = "", TipoOferta2 = "", IndicadorDupla = "",
                    CompraOfertaEspecial = "", Simbolo = "", NombrePais = "", Telefono = "", Celular = "", CompraKitDupla = "", CompraOfertaDupla = "",
                    EstablecidaDupla = "", NuevaComproOfertaEspecial = "", EnviaCatalogo = "";
            int segmento_nueva, segmento_top;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                consultora = sv.GetDatosConsultora(PaisID, CodigoConsultora);
            }

            using (SACServiceClient sv = new SACServiceClient())
            {
                list_segmentos = sv.GetTablaLogicaDatos(UserData().PaisID, 20).ToList();
                segmento_nueva = Convert.ToInt32((from item in list_segmentos where item.TablaLogicaDatosID == 2001 select item.Codigo).First());
                segmento_top = Convert.ToInt32((from item in list_segmentos where item.TablaLogicaDatosID == 2002 select item.Codigo).First());
            }

            if (consultora != null)
            {
                CodConsultora = consultora.CodigoConsultora;
                NombreCompleto = consultora.NombreCompleto;
                CodigoZona = consultora.CodigoZona;
                CodigorRegion = consultora.CodigorRegion;
                EstadoActividad = consultora.EstadoActividad;
                Segmento = consultora.Segmento;
                FechaNacimiento = consultora.FechaNacimiento == null ? "" : consultora.FechaNacimiento.ToString("dd/MM/yyyy");
                EstadoCivil = consultora.EstadoCivil;
                KtiNueva = consultora.KtiNueva;
                AutorizaPedido = consultora.AutorizaPedido == "S" ? "SI" : "NO";
                EMail = consultora.EMail;
                MontoUltimoPedido = consultora.MontoUltimoPedido.ToString("0.00");
                MontoFlexipago = consultora.MontoFlexipago.ToString("0.00");
                UltimaCampanaFacturada = consultora.UltimaCampanaFacturada.ToString();
                MontoMaximoPedido = consultora.MontoMaximoPedido.ToString("0.00");
                MontoMinimoPedido = consultora.MontoMinimoPedido.ToString("0.00");
                FechaIngreso = consultora.FechaIngreso == null ? "" : consultora.FechaIngreso.ToString("dd/MM/yyyy");
                MontoSaldoActual = consultora.MontoSaldoActual.ToString("0.00");
                PasePedidoWeb = consultora.PasePedidoWeb == 1 ? "SI" : "NO";
                TipoOferta2 = consultora.TipoOferta2 == 1 ? "SI" : "NO";
                Simbolo = consultora.Simbolo;
                NombrePais = consultora.NombrePais;
                Telefono = consultora.Telefono;
                Celular = consultora.Celular;
                EstablecidaDupla = segmento_nueva != consultora.segmentoid ? consultora.IndicadorDupla == 1 ? "SI" : "NO" : "";
                NuevaComproOfertaEspecial = segmento_nueva == consultora.segmentoid ? consultora.CompraOfertaEspecial == 1 ? "SI" : "NO" : "";
                EnviaCatalogo = ValidarEnviarEmail(PaisID, CodigoConsultora) == 2 ? "VALIDACIÓN NO ACTIVA" : ValidarEnviarEmail(PaisID, CodigoConsultora) == 1 ? "SI" : "NO";

                return Json(new
                {
                    result = true,
                    CodigoConsultora = CodConsultora,
                    NombreCompleto = NombreCompleto,
                    CodigoZona = CodigoZona,
                    CodigorRegion = CodigorRegion,
                    EstadoActividad = EstadoActividad,
                    Segmento = Segmento,
                    FechaNacimiento = FechaNacimiento,
                    EstadoCivil = EstadoCivil,
                    KtiNueva = KtiNueva,
                    AutorizaPedido = AutorizaPedido,
                    EMail = EMail,
                    MontoUltimoPedido = MontoUltimoPedido,
                    MontoFlexipago = MontoFlexipago,
                    UltimaCampanaFacturada = UltimaCampanaFacturada,
                    MontoMaximoPedido = MontoMaximoPedido,
                    MontoMinimoPedido = MontoMinimoPedido,
                    FechaIngreso = FechaIngreso,
                    MontoSaldoActual = MontoSaldoActual,
                    PasePedidoWeb = PasePedidoWeb,
                    TipoOferta2 = TipoOferta2,
                    TieneCorreo = EMail == "" ? "NO" : "SI",
                    Simbolo = Simbolo,
                    NombrePais = NombrePais,
                    Telefono = Telefono,
                    Celular = Celular,
                    NuevaComproOfertaEspecial = NuevaComproOfertaEspecial,
                    EnviaCatalogo = EnviaCatalogo,
                    EstablecidaDupla = EstablecidaDupla

                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new
                {
                    result = false
                }, JsonRequestBehavior.AllowGet);
            }

        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList();
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private int ValidarEnviarEmail(int PaisID, string CodigoConsultora)
        {
            List<BETablaLogicaDatos> list_Cantidad = new List<BETablaLogicaDatos>();
            int cantidad_validacion;
            int cantidad_envios;
            using (SACServiceClient sv = new SACServiceClient())
            {
                list_Cantidad = sv.GetTablaLogicaDatos(PaisID, 21).ToList();
                cantidad_validacion = Convert.ToInt32((from item in list_Cantidad where item.TablaLogicaDatosID == 2101 select item.Codigo).First());
            }

            if (cantidad_validacion == 0)
                return 2;
            else
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    cantidad_envios = sv.ValidarEnvioCatalogo(PaisID, CodigoConsultora, UserData().CampaniaID, cantidad_validacion);
                }
                if (cantidad_envios >= cantidad_validacion)
                    return 1;
                else
                    return 0;
            }
        }

    }
}


