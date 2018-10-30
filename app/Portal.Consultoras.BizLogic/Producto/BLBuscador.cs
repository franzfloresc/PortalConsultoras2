using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Producto;

using System;
using System.Collections.Generic;

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
                var listaDescripciones = _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatosCache(paisID, Constantes.TablaLogica.NuevaDescripcionProductos);

                foreach (var item in listaDescripciones)
                {
                    listaDescripcionesDic.Add(item.Codigo, item.Descripcion);
                }

                lst.Update(item =>
                {
                    item.DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(listaDescripcionesDic, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, 0, true);
                    item.OrigenPedidoWeb = Util.obtenerCodigoOrigenWeb(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, true);

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
    }
}
