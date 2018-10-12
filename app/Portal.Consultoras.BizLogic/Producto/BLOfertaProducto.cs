using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLOfertaProducto : IOfertaProductoBusinessLogic
    {
        public IList<BEConfiguracionOferta> GetTipoOfertasAdministracion(int paisID, int TipoOfertaSisID)
        {
            var lst = new List<BEConfiguracionOferta>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetTipoOfertasAdministracion(TipoOfertaSisID))
                while (reader.Read())
                {
                    var entity = new BEConfiguracionOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEOfertaProducto> GetProductosByTipoOferta(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta)
        {
            var lst = new List<BEOfertaProducto>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetProductosByTipoOferta(TipoOfertaSisID, CampaniaID, CodigoOferta))
                while (reader.Read())
                {
                    var entity = new BEOfertaProducto(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEOfertaProducto> GetProductosOfertaByCUVCampania(int paisID, int TipoOfertaSisID, int CampaniaID, string CUV)
        {
            var lst = new List<BEOfertaProducto>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetProductosOfertaByCUVCampania(TipoOfertaSisID, CampaniaID, CUV))
                while (reader.Read())
                {
                    var entity = new BEOfertaProducto(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int InsOfertaProducto(BEOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.InsOfertaProducto(entity);
        }

        public int UpdOfertaProducto(BEOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdOfertaProducto(entity);
        }

        public int DelOfertaProducto(BEOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.DelOfertaProducto(entity);
        }

        public int InsAdministracionStockMinimo(BEAdministracionOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.InsAdministracionStockMinimo(entity);
        }

        public int UpdAdministracionStockMinimo(BEAdministracionOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdAdministracionStockMinimo(entity);
        }

        public int UpdOfertaProductoStockMasivo(int paisID, List<BEOfertaProducto> stockProductos)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.UpdOfertaProductoStockMasivo(stockProductos);
        }

        public int InsStockCargaLog(BEStockCargaLog entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.InsStockCargaLog(entity);
        }

        public IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreos(int paisID)
        {
            var lst = new List<BEAdministracionOfertaProducto>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetDatosAdmStockMinimoCorreos())
                while (reader.Read())
                {
                    var entity = new BEAdministracionOfertaProducto(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int GetOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.GetOrdenPriorizacion(ConfiguracionOfertaID, CampaniaID);
        }

        public int ValidarPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.ValidarPriorizacion(ConfiguracionOfertaID, CampaniaID, Orden);
        }

        public int InsMatrizComercial(BEMatrizComercial entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.InsMatrizComercial(entity);
        }

        public int InsMatrizComercialImagen(BEMatrizComercialImagen entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.InsMatrizComercialImagen(entity);
        }

        public int UpdMatrizComercial(BEMatrizComercial entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdMatrizComercial(entity);
        }

        public int UpdMatrizComercialImagen(BEMatrizComercialImagen entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdMatrizComercialImagen(entity);
        }

        public int UpdMatrizComercialNemotecnico(BEMatrizComercialImagen entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdMatrizComercialNemotecnico(entity);
        }

        public int UpdMatrizComercialDescripcionComercial(BEMatrizComercialImagen entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdMatrizComercialDescripcionComercial(entity);
        }

        public IList<BEMatrizComercial> GetMatrizComercialByCodigoSAP(int paisID, string codigoSAP)
        {
            var lst = new List<BEMatrizComercial>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetMatrizComercialByCodigoSAP(codigoSAP))
                while (reader.Read())
                {
                    var entity = new BEMatrizComercial(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEMatrizComercialImagen> GetMatrizComercialImagenByIdMatrizImagen(int paisID, int idMatrizComercial, int numeroPagina, int registros)
        {
            var lst = new List<BEMatrizComercialImagen>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetMatrizComercialImagenByIdMatrizImagen(idMatrizComercial, numeroPagina, registros))
                while (reader.Read())
                {
                    var entity = new BEMatrizComercialImagen(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEMatrizComercialImagen> GetImagenesByCodigoSAP(int paisID, string codigoSAP, int numeroPagina, int registros)
        {
            var lst = new List<BEMatrizComercialImagen>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetMatrizComercialImagenByCodigoSap(codigoSAP, numeroPagina, registros))
                while (reader.Read())
                {
                    var entity = new BEMatrizComercialImagen(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEMatrizComercial> GetImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            var lst = new List<BEMatrizComercial>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetImagenesByCodigoSAP(codigoSAP))
                while (reader.Read())
                {
                    var entity = new BEMatrizComercial(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEMatrizComercialImagen> GetImagenByNemotecnico(int paisID, int idMatrizImagen, string cuv2, string codigoSAP, int estrategiaID, int campaniaID, int tipoEstrategiaID, string nemotecnico, int tipoBusqueda, int numeroPagina, int registros)
        {
            var lst = new List<BEMatrizComercialImagen>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetImagenByNemotecnico(idMatrizImagen, cuv2, codigoSAP, estrategiaID, campaniaID, tipoEstrategiaID, nemotecnico, tipoBusqueda, numeroPagina, registros))
                while (reader.Read())
                {
                    var entity = new BEMatrizComercialImagen(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int UpdMatrizComercialDescripcionMasivo(int paisID, List<BEMatrizComercial> lstmatriz, string UsuarioRegistro)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.UpdMatrizComercialDescripcionMasivo(lstmatriz, UsuarioRegistro);
        }

        public IList<BEOfertaProducto> GetOfertaProductosPortal(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania)
        {
            var lst = new List<BEOfertaProducto>();
            var dataAccess = new DAOfertaProducto(PaisID);
            int pos = 0;
            using (IDataReader reader = dataAccess.GetOfertaProductosPortal(TipoOfertaSisID, DuplaConsultora, CodigoCampania))
                while (reader.Read())
                {
                    pos = pos + 1;
                    var entity = new BEOfertaProducto(reader) { Orden = pos };
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEOfertaProducto> GetOfertaProductosPortal2(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania, int Offset, int CantidadRegistros)
        {
            var lst = new List<BEOfertaProducto>();
            var dataAccess = new DAOfertaProducto(PaisID);
            int pos = 0;
            using (IDataReader reader = dataAccess.GetOfertaProductosPortal2(TipoOfertaSisID, DuplaConsultora, CodigoCampania, Offset, CantidadRegistros))
                while (reader.Read())
                {
                    pos = pos + 1;
                    var entity = new BEOfertaProducto(reader) { Orden = pos };
                    lst.Add(entity);
                }
            return lst;
        }

        public void InsPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle)
        {
            var daPedidoWebDetalle = new DAOfertaProducto(pedidowebdetalle.PaisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                daPedidoWebDetalle.InsPedidoWebDetalleOferta(pedidowebdetalle);
                daPedidoWebDetalle.UpdPedidoWebTotalesOferta(pedidowebdetalle.ConsultoraID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CodigoUsuarioModificacion);
                if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                {
                    new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockAgregar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);
                }
                if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.Accesorizate)
                {
                    new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockAgregar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);
                }

                oTransactionScope.Complete();
            }
        }

        public void UpdPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle)
        {
            var daPedidoWebDetalle = new DAOfertaProducto(pedidowebdetalle.PaisID);

            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                daPedidoWebDetalle.UpdPedidoWebOferta(pedidowebdetalle);
                daPedidoWebDetalle.UpdPedidoWebTotalesOferta(pedidowebdetalle.ConsultoraID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CodigoUsuarioModificacion);
                if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                {
                    new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Stock, pedidowebdetalle.Flag);
                }
                if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.Accesorizate)
                {
                    new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Stock, pedidowebdetalle.Flag);
                }
                oTransactionScope.Complete();
            }
        }

        public int GetStockOfertaProductoLiquidacion(int paisID, int CampaniaID, string CUV)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.GetStockOfertaProductoLiquidacion(CampaniaID, CUV);
        }

        public int GetUnidadesPermitidasByCuv(int paisID, int CampaniaID, string CUV)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.GetUnidadesPermitidasByCuv(CampaniaID, CUV);
        }

        #region Configuracion Oferta

        public int InsConfiguracionOferta(BEConfiguracionOferta entidad)
        {
            var dataAccess = new DAOfertaProducto(entidad.PaisID);
            return dataAccess.InsConfiguracionOferta(entidad);
        }

        public int UpdConfiguracionOferta(BEConfiguracionOferta entidad)
        {
            var dataAccess = new DAOfertaProducto(entidad.PaisID);
            return dataAccess.UpdConfiguracionOferta(entidad);
        }

        public int DelConfiguracionOferta(int PaisID, int ConfiguracionOfertaID)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.DelConfiguracionOferta(ConfiguracionOfertaID);
        }

        public IList<BEConfiguracionOferta> GetConfiguracionOfertaAdministracion(int PaisID, int TipoOfertaSisID)
        {
            var lst = new List<BEConfiguracionOferta>();
            var dataAccess = new DAOfertaProducto(PaisID);

            using (IDataReader reader = dataAccess.GetConfiguracionOfertaAdministracion(TipoOfertaSisID))
                while (reader.Read())
                {
                    var entity = new BEConfiguracionOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int ValidarCodigoOfertaAdministracion(int PaisID, string CodigoOferta)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ValidarCodigoOfertaAdministracion(CodigoOferta);
        }

        public int ActualizarItemsMostrarLiquidacion(int PaisID, int Cantidad)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ActualizarItemsMostrarLiquidacion(Cantidad);
        }

        public int ObtenerMaximoItemsaMostrarLiquidacion(int PaisID)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ObtenerMaximoItemsaMostrarLiquidacion();
        }

        public int ValidarUnidadesPermitidasEnPedido(int PaisID, int CampaniaID, string CUV, long ConsultoraID)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ValidarUnidadesPermitidasEnPedido(CampaniaID, CUV, ConsultoraID);
        }

        #endregion

        public int ValidarUnidadesPermitidasEnPedidoZA(int PaisID, int CampaniaID, string CUV, long ConsultoraID, int TipoOfertaSisID)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ValidarUnidadesPermitidasEnPedidoZA(CampaniaID, CUV, ConsultoraID, TipoOfertaSisID);
        }

        public int GetUnidadesPermitidasByCuvZA(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID)
        {
            var dataAccess = new DAOfertaProducto(paisID);
            return dataAccess.GetUnidadesPermitidasByCuvZA(CampaniaID, CUV, TipoOfertaSisID);
        }

        public int ObtenerMaximoItemsaMostrarZA(int PaisID)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ObtenerMaximoItemsaMostrarZA();
        }

        public int ActualizarItemsMostrarZA(int PaisID, int Cantidad)
        {
            var dataAccess = new DAOfertaProducto(PaisID);
            return dataAccess.ActualizarItemsMostrarZA(Cantidad);
        }

        public IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreosZA(int paisID, int TipoOfertaSisID)
        {
            var lst = new List<BEAdministracionOfertaProducto>();
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetDatosAdmStockMinimoCorreosZA(TipoOfertaSisID))
                while (reader.Read())
                {
                    var entity = new BEAdministracionOfertaProducto(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int InsAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.InsAdministracionStockMinimoZA(entity);
        }

        public int UpdAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.UpdAdministracionStockMinimoZA(entity);
        }

        public int EliminarTallaColor(BEOfertaProducto entidad)
        {
            var daOfertaProducto = new DAOfertaProducto(entidad.PaisID);
            int result = daOfertaProducto.EliminarTallaColor(entidad);
            return result;
        }

        public List<BEOfertaProducto> GetTallaColor(BEOfertaProducto entidad)
        {
            var listaTallaColor = new List<BEOfertaProducto>();
            var daOfertaProducto = new DAOfertaProducto(entidad.PaisID);
            using (IDataReader reader = daOfertaProducto.GetTallaColor(entidad))
            {
                while (reader.Read())
                {
                    listaTallaColor.Add(new BEOfertaProducto(reader));
                }
            }
            return listaTallaColor;
        }

        public int InsertTallaColorCUV(BEOfertaProducto entidad)
        {
            var daOfertaProducto = new DAOfertaProducto(entidad.PaisID);
            int result = daOfertaProducto.InsertTallaColorCUV(entidad);
            return result;
        }

        public List<BEOfertaProducto> ConsultarLiquidacionByCUV(BEOfertaProducto entidad)
        {
            var listaTallaColor = new List<BEOfertaProducto>();
            var daOfertaProducto = new DAOfertaProducto(entidad.PaisID);
            using (IDataReader reader = daOfertaProducto.ConsultarLiquidacionByCUV(entidad))
            {
                while (reader.Read())
                {
                    listaTallaColor.Add(new BEOfertaProducto(reader));
                }
            }
            return listaTallaColor;
        }

        public int CantidadPedidoByConsultora(BEOfertaProducto entidad)
        {
            var daOfertaProducto = new DAOfertaProducto(entidad.PaisID);
            int result = daOfertaProducto.CantidadPedidoByConsultora(entidad);
            return result;
        }

        public int RemoverOfertaLiquidacion(BEOfertaProducto entity)
        {
            var dataAccess = new DAOfertaProducto(entity.PaisID);
            return dataAccess.RemoverOfertaLiquidacion(entity);
        }
    }
}
