using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultaAdministrativaController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ConsultaConsultora()
        {
            ConsultaAdministrativaModel model = new ConsultaAdministrativaModel
            {
                listaPaises = DropDowListPaises()
            };

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
            BEConsultoraDatos consultora;
            int segmentoNueva;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                consultora = sv.GetDatosConsultora(PaisID, CodigoConsultora);
            }

            using (SACServiceClient sv = new SACServiceClient())
            {
                var listSegmentos = sv.GetTablaLogicaDatos(userData.PaisID, 20).ToList();
                segmentoNueva = Convert.ToInt32((from item in listSegmentos where item.TablaLogicaDatosID == 2001 select item.Codigo).First());
            }

            if (consultora != null)
            {
                var codConsultora = consultora.CodigoConsultora;
                var nombreCompleto = consultora.NombreCompleto;
                var codigoZona = consultora.CodigoZona;
                var codigorRegion = consultora.CodigorRegion;
                var estadoActividad = consultora.EstadoActividad;
                var segmento = consultora.Segmento;
                var fechaNacimiento = consultora.FechaNacimiento.ToString("dd/MM/yyyy");
                var estadoCivil = consultora.EstadoCivil;
                var ktiNueva = consultora.KtiNueva;
                var autorizaPedido = consultora.AutorizaPedido == "S" ? "SI" : "NO";
                var eMail = consultora.EMail;
                var montoUltimoPedido = consultora.MontoUltimoPedido.ToString("0.00");
                var montoFlexipago = consultora.MontoFlexipago.ToString("0.00");
                var ultimaCampanaFacturada = consultora.UltimaCampanaFacturada.ToString();
                var montoMaximoPedido = consultora.MontoMaximoPedido.ToString("0.00");
                var montoMinimoPedido = consultora.MontoMinimoPedido.ToString("0.00");
                var fechaIngreso = consultora.FechaIngreso.ToString("dd/MM/yyyy");
                var montoSaldoActual = consultora.MontoSaldoActual.ToString("0.00");
                var pasePedidoWeb = consultora.PasePedidoWeb == 1 ? "SI" : "NO";
                var tipoOferta2 = consultora.TipoOferta2 == 1 ? "SI" : "NO";
                var simbolo = consultora.Simbolo;
                var nombrePais = consultora.NombrePais;
                var telefono = consultora.Telefono;
                var celular = consultora.Celular;
                var establecidaDupla = segmentoNueva != consultora.segmentoid ? consultora.IndicadorDupla == 1 ? "SI" : "NO" : "";
                var nuevaComproOfertaEspecial = segmentoNueva == consultora.segmentoid ? consultora.CompraOfertaEspecial == 1 ? "SI" : "NO" : "";
                var enviaCatalogo = ValidarEnviarEmail(PaisID, CodigoConsultora) == 2 ? "VALIDACIÓN NO ACTIVA" : ValidarEnviarEmail(PaisID, CodigoConsultora) == 1 ? "SI" : "NO";

                return Json(new
                {
                    result = true,
                    CodigoConsultora = codConsultora,
                    NombreCompleto = nombreCompleto,
                    CodigoZona = codigoZona,
                    CodigorRegion = codigorRegion,
                    EstadoActividad = estadoActividad,
                    Segmento = segmento,
                    FechaNacimiento = fechaNacimiento,
                    EstadoCivil = estadoCivil,
                    KtiNueva = ktiNueva,
                    AutorizaPedido = autorizaPedido,
                    EMail = eMail,
                    MontoUltimoPedido = montoUltimoPedido,
                    MontoFlexipago = montoFlexipago,
                    UltimaCampanaFacturada = ultimaCampanaFacturada,
                    MontoMaximoPedido = montoMaximoPedido,
                    MontoMinimoPedido = montoMinimoPedido,
                    FechaIngreso = fechaIngreso,
                    MontoSaldoActual = montoSaldoActual,
                    PasePedidoWeb = pasePedidoWeb,
                    TipoOferta2 = tipoOferta2,
                    TieneCorreo = eMail == "" ? "NO" : "SI",
                    Simbolo = simbolo,
                    NombrePais = nombrePais,
                    Telefono = telefono,
                    Celular = celular,
                    NuevaComproOfertaEspecial = nuevaComproOfertaEspecial,
                    EnviaCatalogo = enviaCatalogo,
                    EstablecidaDupla = establecidaDupla

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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private int ValidarEnviarEmail(int paisId, string codigoConsultora)
        {
            int cantidadValidacion;
            using (SACServiceClient sv = new SACServiceClient())
            {
                var listCantidad = sv.GetTablaLogicaDatos(paisId, 21).ToList();
                cantidadValidacion = Convert.ToInt32((from item in listCantidad where item.TablaLogicaDatosID == 2101 select item.Codigo).First());
            }

            if (cantidadValidacion == 0)
                return 2;

            int cantidadEnvios;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                cantidadEnvios = sv.ValidarEnvioCatalogo(paisId, codigoConsultora, userData.CampaniaID, cantidadValidacion);
            }

            return cantidadEnvios >= cantidadValidacion ? 1 : 0;
        }

    }
}
