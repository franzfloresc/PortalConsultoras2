using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ProductosDestacadosController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var userData = UserData();
            var productosDestacados = new ProductosDestacadosMobilModel();
            try
            {
                var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                productosDestacados.PaisId = userData.PaisID;
                productosDestacados.Simbolo = userData.Simbolo;
                productosDestacados.ListaEstrategias = ListarEstrategias("");
                productosDestacados.Total = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                productosDestacados.DescripcionTotal = DarFormatoANumero(userData.CodigoISO, productosDestacados.Total);
                productosDestacados.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
                productosDestacados.DescripcionTotalMinimo = DarFormatoANumero(userData.CodigoISO, productosDestacados.TotalMinimo);
                productosDestacados.ListaProductos = lstPedidoWebDetalle.ToList();
                productosDestacados.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);
                productosDestacados.CampaniaActual = ViewBag.Campania;
                productosDestacados.CodigoIso = userData.CodigoISO;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(productosDestacados);
        }

        #endregion

        #region Metodos

        private List<BEEstrategia> ListarEstrategias(string cuv)
        {
            List<BEEstrategia> lst;

            var userData = UserData();

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.ConsultoraID.ToString();
            entidad.CUV2 = cuv ?? "";
            entidad.Zona = userData.ZonaID.ToString();

            var listaTipoEstrategias = ListarTipoEstrategia();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetEstrategiasPedido(entidad).ToList();
            }

            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (lst.Count > 0)
            {
                lst.Update(x => x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais));
                lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));
                lst.Update(x => x.Simbolo = userData.Simbolo);
                lst.Update(x =>
                {
                    var beTipoEstrategia = listaTipoEstrategias.FirstOrDefault(p => p.TipoEstrategiaID == x.TipoEstrategiaID);
                    x.DescripcionEstrategia = beTipoEstrategia != null ? beTipoEstrategia.DescripcionEstrategia : "Estándar";
                });
            }

            Session["ListadoEstrategiaPedido"] = lst;

            int posicion = 1;
            foreach (var estrategia in lst)
            {
                estrategia.ID = estrategia.ColorFondo != "" ? 0 : posicion++;
                var beTipoEstrategia = listaTipoEstrategias.FirstOrDefault(p => p.TipoEstrategiaID == estrategia.TipoEstrategiaID);
                estrategia.DescripcionEstrategia = beTipoEstrategia != null ? beTipoEstrategia.DescripcionEstrategia : "Estándar";
            }

            return lst;
        }

        private List<BETipoEstrategia> ListarTipoEstrategia()
        {
            List<BETipoEstrategia> lst;
            if (Session["ListaTipoEstrategia"] == null)
            {
                var entidad = new BETipoEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.TipoEstrategiaID = 0;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetTipoEstrategias(entidad).ToList();
                }
                Session["ListaTipoEstrategia"] = lst;
            }
            else
            {
                lst = (List<BETipoEstrategia>)Session["ListaTipoEstrategia"];
            }
            return lst;
        }

        private string DarFormatoANumero(string codigoIso, decimal monto)
        {
            return codigoIso == Constantes.CodigosISOPais.Colombia ? string.Format("{0:#,##0}", monto).Replace(',', '.') : string.Format("{0:#,##0.00}", monto);
        }

        #endregion
    }
}