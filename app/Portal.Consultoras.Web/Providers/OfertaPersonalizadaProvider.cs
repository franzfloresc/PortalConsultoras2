using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaPersonalizadaProvider
    {
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;

        #region Metodos de Estrategia Controller
        
        public string ConsultarOfertasTipoPalanca(BusquedaProductoModel model, int tipo)
        {

            var palanca = string.Empty;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                var revistaDigital = sessionManager.GetRevistaDigital();
                var userData = sessionManager.GetUserData();
                if (revistaDigital.ActivoMdo)
                {
                    palanca = Constantes.TipoEstrategiaCodigo.RevistaDigital;
                }
                else
                {
                    palanca = model.CampaniaID != userData.CampaniaID
                        || (revistaDigital.TieneRDC && revistaDigital.EsActiva)
                        ? Constantes.TipoEstrategiaCodigo.RevistaDigital
                        : Constantes.TipoEstrategiaCodigo.OfertaParaTi;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.HerramientasVenta;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
            {
                palanca = Constantes.TipoEstrategiaCodigo.Lanzamiento;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.OfertaParaTi;
            }

            return palanca;
        }

        public int ConsultarOfertasCampania(BusquedaProductoModel model, int tipo)
        {
            var retorno = 0;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                retorno = model.CampaniaID;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                retorno = 0;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                retorno = model.CampaniaID;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
            {
                retorno = model.CampaniaID;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                retorno = 0;
            }

            return retorno;
        }

        public List<EstrategiaPedidoModel> ConsultarOfertasFiltrar(BusquedaProductoModel model, List<EstrategiaPedidoModel> listaFinal1, int tipo)
        {
            var revistaDigital = sessionManager.GetRevistaDigital();
            var userData = sessionManager.GetUserData();

            var listModel1 = new List<EstrategiaPedidoModel>();
            if (listaFinal1 == null || !listaFinal1.Any())
                return listModel1;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                var mdo0 = revistaDigital.ActivoMdo && !revistaDigital.EsActiva;

                if (mdo0 && model.CampaniaID == userData.CampaniaID)
                {
                    var listaRd = listaFinal1.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi || e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso).ToList();
                    listModel1 = listaFinal1.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.OfertasParaMi && e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.PackAltoDesembolso).ToList();
                    listModel1.AddRange(listaRd.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor0));
                }
                else
                {
                    listModel1 = listaFinal1;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                if (revistaDigital.TieneRDCR)
                {
                    // se puede cambiar a un BaseController.GetConfiguracionManagerContains
                    // cuando exista ConfiguracionManagerContainsProvider
                    var keyvalor = ConfigurationManager.AppSettings.Get(Constantes.ConfiguracionManager.RevistaPiloto_Zonas_RDR_2 + userData.CodigoISO);
                    keyvalor = Util.Trim(keyvalor);
                    if (keyvalor.Contains(userData.CodigoZona))
                    {
                        listaFinal1 = listaFinal1.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1 || e.FlagRevista == Constantes.FlagRevista.Valor3).ToList();
                    }
                    else
                    {
                        listaFinal1 = listaFinal1.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1).ToList();
                    }
                }

                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                listaFinal1 = listaFinal1
                    .OrderByDescending(x => x.MarcaID == Constantes.Marca.Esika)
                    .ThenByDescending(x => x.MarcaID == Constantes.Marca.LBel)
                    .ThenByDescending(x => x.MarcaID == Constantes.Marca.Cyzone)
                    .ToList();

                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
            {
                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                listModel1 = listaFinal1;
            }

            return listModel1;

        }

        public int ConsultarOfertasTipoPerdio(BusquedaProductoModel model, int tipo)
        {
            var retorno = 0;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                retorno = 2;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                retorno = 2;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                retorno = 2;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
            {
                retorno = TieneProductosPerdio(model.CampaniaID) ? 1 : 0;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                retorno = 0;
            }

            return retorno;
        }
        
        public bool TieneProductosPerdio(int campaniaId)
        {
            var revistaDigital = sessionManager.GetRevistaDigital();
            var userData = sessionManager.GetUserData();

            if (revistaDigital.TieneRDC && !revistaDigital.EsActiva &&
                campaniaId == userData.CampaniaID)
                return true;

            return false;
        }

        public bool ConsultarOfertasValidarPermiso(BusquedaProductoModel model, int tipo)
        {
            var revistaDigital = sessionManager.GetRevistaDigital();
            var _guiaNegocioProvider = new GuiaNegocioProvider();

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                if (model == null || !(revistaDigital.TieneRevistaDigital()) || EsCampaniaFalsa(model.CampaniaID))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                var userData = sessionManager.GetUserData();
                var guiaNegocio = sessionManager.GetGuiaNegocio();

                if (!_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                return true;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
            {
                if (!(revistaDigital.TieneRevistaDigital()) || EsCampaniaFalsa(model.CampaniaID))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                return true;
            }

            return true;
        }

        #region Mas Vendidos
        public EstrategiaOutModel BSActualizarPosicion(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                }
            }
            return model;
        }

        public EstrategiaOutModel BSActualizarPrecioFormateado(EstrategiaOutModel model)
        {
            if (model != null)
            {
                var userData = sessionManager.GetUserData();
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                    model.Lista[i].PrecioTachado = Util.DecimalToStringFormat(model.Lista[i].Precio, userData.CodigoISO);
                    model.Lista[i].GananciaString = Util.DecimalToStringFormat(model.Lista[i].Ganancia, userData.CodigoISO);
                }
            }
            return model;
        }
        #endregion

        #endregion

        #region Metodos de Base estrategia Controller

        public bool EsCampaniaFalsa(int campaniaId)
        {
            var userData = sessionManager.GetUserData();
            return (campaniaId < userData.CampaniaID || campaniaId > Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias));
        }

        public string ObtenerConstanteConfPais(string codigoAgrupacion)
        {
            switch (codigoAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    return Constantes.ConfiguracionPais.RevistaDigital;
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                    return Constantes.ConfiguracionPais.Lanzamiento;
                case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                    return Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada;
                default:
                    return Constantes.ConfiguracionPais.OfertasParaTi;
            }
        }
        #endregion

    }

}