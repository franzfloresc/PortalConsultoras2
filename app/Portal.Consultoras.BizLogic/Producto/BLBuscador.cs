using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Buscador;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.BuscadorYFiltros;
using Portal.Consultoras.Entities.Producto;

using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.Producto
{
    public class BLBuscador : IBuscadorBusinessLogic
    {
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;

        public BLBuscador() : this(new BLTablaLogicaDatos())
        { }

        public BLBuscador(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
        }

        public List<BEBuscadorResponse> ObtenerBuscadorComplemento(int paisID, string codigoUsuario, bool suscripcionActiva, List<BEBuscadorResponse> lst, bool isApp)
        {
            var listaDescripcionesDic = new Dictionary<string, string>();

            try
            {
                var listaDescripciones = _tablaLogicaDatosBusinessLogic.GetListCache(paisID, ConsTablaLogica.DescripcionProducto.TablaLogicaId);

                foreach (var item in listaDescripciones)
                {
                    listaDescripcionesDic.Add(item.Codigo, item.Descripcion);
                }

                lst.Update(item =>
                {
                    item.DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(listaDescripcionesDic, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, 0, true);
                    item.OrigenPedidoWeb = Util.obtenerCodigoOrigenWeb(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, true, false, false, false, suscripcionActiva);

                    if (isApp)
                    {
                        item.OrigenPedidoWeb = Util.ProcesarOrigenPedidoApp(item.OrigenPedidoWeb);
                        item.OrigenPedidoWebFicha = Util.ProcesarOrigenPedidoAppFicha(item.OrigenPedidoWeb);

                        var OrigenPedidoWebDesplegable = Util.obtenerCodigoOrigenWebApp(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, true, false, false, false, item.MaterialGanancia);
                        var OrigenPedidoWebLanding = Util.obtenerCodigoOrigenWebApp(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, false, true, false, false, item.MaterialGanancia);
                        var OrigenPedidoWebDesplegableFicha = Util.obtenerCodigoOrigenWebApp(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, true, false, true, false, item.MaterialGanancia);
                        var OrigenPedidoWebLandingFicha = Util.obtenerCodigoOrigenWebApp(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, false, true, true, false, item.MaterialGanancia);
                        var OrigenPedidoWebDesplegableFichaCarrusel = Util.obtenerCodigoOrigenWebApp(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, true, false, false, true, item.MaterialGanancia);
                        var OrigenPedidoWebLandingFichaCarrusel = Util.obtenerCodigoOrigenWebApp(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, false, true, false, true, item.MaterialGanancia);

                        if(OrigenPedidoWebDesplegable > 0) item.OrigenesPedidoWeb.Add(new BEBuscadorResponseOrigen() { Codigo = Constantes.OrigenPedidoBuscadorApp.OrigenPedidoWebDesplegable, Valor = OrigenPedidoWebDesplegable });
                        if (OrigenPedidoWebLanding > 0) item.OrigenesPedidoWeb.Add(new BEBuscadorResponseOrigen() { Codigo = Constantes.OrigenPedidoBuscadorApp.OrigenPedidoWebLanding, Valor = OrigenPedidoWebLanding });
                        if (OrigenPedidoWebDesplegableFicha > 0) item.OrigenesPedidoWeb.Add(new BEBuscadorResponseOrigen() { Codigo = Constantes.OrigenPedidoBuscadorApp.OrigenPedidoWebDesplegableFicha, Valor = OrigenPedidoWebDesplegableFicha });
                        if (OrigenPedidoWebLandingFicha > 0) item.OrigenesPedidoWeb.Add(new BEBuscadorResponseOrigen() { Codigo = Constantes.OrigenPedidoBuscadorApp.OrigenPedidoWebLandingFicha, Valor = OrigenPedidoWebLandingFicha });
                        if (OrigenPedidoWebDesplegableFichaCarrusel > 0) item.OrigenesPedidoWeb.Add(new BEBuscadorResponseOrigen() { Codigo = Constantes.OrigenPedidoBuscadorApp.OrigenPedidoWebLandingFichaCarrusel, Valor = OrigenPedidoWebDesplegableFichaCarrusel });
                        if (OrigenPedidoWebLandingFichaCarrusel > 0) item.OrigenesPedidoWeb.Add(new BEBuscadorResponseOrigen() { Codigo = Constantes.OrigenPedidoBuscadorApp.OrigenPedidoWebDesplegableFichaCarrusel, Valor = OrigenPedidoWebLandingFichaCarrusel });
                    }
                });
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return lst;
        }

        public Dictionary<string, string> GetOrdenamientoFiltrosBuscador(int paisID)
        {
            var result = new Dictionary<string, string>();
            try
            {
                List<BETablaLogicaDatos> rst = (List<BETablaLogicaDatos>)CacheManager<BETablaLogicaDatos>.GetData(ECacheItem.OrdenamientoFiltros);

                if (rst == null)
                {
                    using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(ConsTablaLogica.BfOpcionesOrdenamiento.TablaLogicaId))
                    {
                        rst = reader.MapToCollection<BETablaLogicaDatos>();
                    }
                }

                foreach (var item in rst)
                {
                    result.Add(item.Descripcion.ToString(), string.IsNullOrEmpty(item.Valor) ? "" : item.Valor.ToString());
                }

                CacheManager<BETablaLogicaDatos>.AddData(ECacheItem.OrdenamientoFiltros, rst);

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisID);
                return new Dictionary<string, string>();
            }
            return result;
        }

        public List<BEFiltroBuscador> GetFiltroBuscador(int paisID, int tablaLogicaDatosID)
        {
            var result = new List<BEFiltroBuscador>();

            try
            {
                using (var reader = new DAFiltroBuscador(paisID).GetFiltroBuscador(tablaLogicaDatosID))
                {
                    result = reader.MapToCollection<BEFiltroBuscador>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisID);
            }

            return result;
        }
    }
}
