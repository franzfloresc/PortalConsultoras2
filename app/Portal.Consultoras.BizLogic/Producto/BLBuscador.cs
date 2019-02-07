using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
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
                var listaDescripciones = _tablaLogicaDatosBusinessLogic.GetListCache(paisID, Constantes.TablaLogica.NuevaDescripcionProductos);

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
                    using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(Constantes.TablaLogica.ListaOrdenamientoFiltros))
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
    }
}
