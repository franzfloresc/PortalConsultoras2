using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLShowRoomEvento : IShowRoomEventoBusinessLogic
    {
        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            BEShowRoomEvento entidad = null;
            var daPedidoWeb = new DAShowRoomEvento(paisID);

            using (IDataReader reader = daPedidoWeb.GetShowRoomEventoByCampaniaID(campaniaID))
                if (reader.Read())
                {
                    entidad = new BEShowRoomEvento(reader);
                }
            return entidad;
        }

        public int InsertShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            try
            {
                var daShowRoomEvento = new DAShowRoomEvento(paisID);
                int resultado;
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    resultado = daShowRoomEvento.InsertShowRoomEvento(beShowRoomEvento);

                    string formatoPerfiles = Util.GetPaisISO(paisID) + "_" + beShowRoomEvento.CampaniaID + "_Perfil";
                    daShowRoomEvento.InsertarShowRoomPerfil(beShowRoomEvento.NumeroPerfiles, formatoPerfiles, resultado);

                    oTransactionScope.Complete();
                }

                return resultado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public void UpdateShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            var daShowRoomEvento = new DAShowRoomEvento(paisID);
            daShowRoomEvento.UpdateShowRoomEvento(beShowRoomEvento);
        }

        public int CargarMasivaConsultora(int paisID, List<BEShowRoomEventoConsultora> listaConsultora)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.CargarMasivaConsultora(listaConsultora);
        }

        [Obsolete("Migrado PL50-50")]
        public int ValidadStockOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.ValidadStockOfertaShowRoom(entity);
        }

        [Obsolete("Migrado PL50-50")]
        public int UpdOfertaShowRoomStockMasivo(int paisID, List<BEShowRoomOferta> stockProductos)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdOfertaShowRoomStockMasivo(stockProductos);
        }

        [Obsolete("Migrado PL50-50")]
        public int CargarMasivaDescripcionSets(int paisID, int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle, string nombreArchivoCargado, string nombreArchivoGuardado)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.CargarMasivaDescripcionSets(campaniaID, usuarioCreacion, listaShowRoomOfertaDetalle, nombreArchivoCargado, nombreArchivoGuardado);
        }

        public int CargarProductoCpc(int paisId, int eventoId, string usuarioCreacion, List<BEShowRoomCompraPorCompra> listaShowRoomCompraPorCompra)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            return dataAccess.CargarProductoCpc(eventoId, usuarioCreacion, listaShowRoomCompraPorCompra);
        }

        public BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion)
        {
            BEShowRoomEventoConsultora entidad = null;
            var daPedidoWeb = new DAShowRoomEvento(paisID);

            using (IDataReader reader = daPedidoWeb.GetShowRoomConsultoraPersonalizacion(campaniaID, codigoConsultora))
            {
                if (reader.Read())
                {
                    entidad = new BEShowRoomEventoConsultora(reader);
                }
            }
                
            return entidad;
        }

        public void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup)
        {
            var daShowRoomEvento = new DAShowRoomEvento(paisID);
            daShowRoomEvento.UpdateShowRoomConsultoraMostrarPopup(campaniaID, codigoConsultora, mostrarPopup);
        }

        [Obsolete("Migrado PL50-50")]
        public IList<BEShowRoomOferta> GetProductosShowRoom(int paisID, int campaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var dataAccess = new DAShowRoomEvento(paisID);

            using (IDataReader reader = dataAccess.GetProductosShowRoom(campaniaID))
                while (reader.Read())
                {
                    var entity = new BEShowRoomOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        [Obsolete("Migrado PL50-50")]
        public int GetOrdenPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.GetOrdenPriorizacionShowRoom(ConfiguracionOfertaID, CampaniaID);
        }

        [Obsolete("Migrado PL50-50")]
        public int ValidarPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.ValidarPriorizacionShowRoom(ConfiguracionOfertaID, CampaniaID, Orden);
        }

        [Obsolete("Migrado PL50-50")]
        public int InsOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.InsOfertaShowRoom(entity);
        }

        [Obsolete("Migrado PL50-50")]
        public int UpdOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdOfertaShowRoom(entity);
        }

        [Obsolete("Migrado PL50-50")]
        public int DelOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.DelOfertaShowRoom(entity);
        }

        [Obsolete("Migrado PL50-50")]
        public int InsOrUpdOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.RepeatableRead };
            using (TransactionScope transactionScope = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                var dataAccess = new DAShowRoomEvento(paisID);
                var result = dataAccess.InsOrUpdOfertaShowRoom(entity);

                transactionScope.Complete();
                return result;
            }
        }

        [Obsolete("Migrado PL50-50")]
        public int RemoverOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.RemoverOfertaShowRoom(entity);
        }

        public int GetUnidadesPermitidasByCuvShowRoom(int paisID, int CampaniaID, string CUV)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.GetUnidadesPermitidasByCuvShowRoom(CampaniaID, CUV);
        }

        public int ValidarUnidadesPermitidasEnPedidoShowRoom(int paisID, int CampaniaID, string CUV, long ConsultoraID)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.ValidarUnidadesPermitidasEnPedidoShowRoom(CampaniaID, CUV, ConsultoraID);
        }

        public int CantidadPedidoByConsultoraShowRoom(BEOfertaProducto entidad)
        {
            var dataAccess = new DAShowRoomEvento(entidad.PaisID);
            int result = dataAccess.CantidadPedidoByConsultoraShowRoom(entidad);
            return result;
        }

        public int GetStockOfertaShowRoom(int paisID, int CampaniaID, string CUV)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.GetStockOfertaShowRoom(CampaniaID, CUV);
        }

        public int DeshabilitarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.DeshabilitarShowRoomEvento(beShowRoomEvento);
        }

        public int EliminarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            try
            {
                var dataAccess = new DAShowRoomEvento(paisID);
                int resultado;
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    resultado = dataAccess.EliminarShowRoomEvento(beShowRoomEvento);
                    dataAccess.EliminarShowRoomPerfiles(beShowRoomEvento.EventoID);

                    oTransactionScope.Complete();
                }

                return resultado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public int GuardarImagenShowRoom(int paisID, int eventoId, string nombreImagenFinal, int tipo, string usuarioModificacion)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.GuardarImagenShowRoom(eventoId, nombreImagenFinal, tipo, usuarioModificacion);
        }

        public IList<BEShowRoomOfertaDetalle> GetProductosShowRoomDetalle(int paisID, int campaniaId, string cuv)
        {
            var lst = new List<BEShowRoomOfertaDetalle>();
            var dataAccess = new DAShowRoomEvento(paisID);

            using (IDataReader reader = dataAccess.GetProductosShowRoomDetalle(campaniaId, cuv))
                while (reader.Read())
                {
                    var entity = new BEShowRoomOfertaDetalle(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        [Obsolete("Migrado PL50-50")]
        public int InsOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.InsOfertaShowRoomDetalle(entity);
        }

        [Obsolete("Migrado PL50-50")]
        public int UpdOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdOfertaShowRoomDetalle(entity);
        }

        [Obsolete("Migrado PL50-50")]
        public int EliminarOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle beShowRoomOfertaDetalle)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.EliminarOfertaShowRoomDetalle(beShowRoomOfertaDetalle);
        }

        [Obsolete("Migrado PL50-50")]
        public int EliminarOfertaShowRoomDetalleAll(int paisID, int campaniaID, string cuv)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.EliminarOfertaShowRoomDetalleAll(campaniaID, cuv);
        }

        public int EliminarEstrategiaProductoAll(int paisID, int estrategiaID, string usuario)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.EliminarEstrategiaProductoAll(estrategiaID,  usuario);
        }

        public IList<BEShowRoomPerfil> GetShowRoomPerfiles(int paisId, int eventoId)
        {
            var lst = new List<BEShowRoomPerfil>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomPerfiles(eventoId))
                while (reader.Read())
                {
                    var entity = new BEShowRoomPerfil(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        [Obsolete("Migrado PL50-50")]
        public IList<BEShowRoomPerfilOferta> GetShowRoomPerfilOfertaCuvs(int paisId, BEShowRoomPerfilOferta beShowRoomPerfilOferta)
        {
            var lst = new List<BEShowRoomPerfilOferta>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomPerfilOfertaCuvs(beShowRoomPerfilOferta))
                while (reader.Read())
                {
                    var entity = new BEShowRoomPerfilOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public void GuardarPerfilOfertaShowRoom(int paisId, int perfilId, int eventoId, int campaniaId, string cadenaCuv)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            dataAccess.GuardarPerfilOfertaShowRoom(perfilId, eventoId, campaniaId, cadenaCuv);
        }

        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            List<BEShowRoomOferta> showRoomOfertas;

            using (var reader = new DAShowRoomEvento(paisID).GetShowRoomOfertasConsultoraPersonalizada(campaniaID, codigoConsultora))
                showRoomOfertas = reader.MapToCollection<BEShowRoomOferta>();

            return showRoomOfertas;
        }

        public BEShowRoomOferta GetShowRoomOfertaById(int paisID, int ofertaShowRoomID)
        {
            BEShowRoomOferta entidad = null;
            var daPedidoWeb = new DAShowRoomEvento(paisID);

            using (IDataReader reader = daPedidoWeb.GetShowRoomOfertaById(ofertaShowRoomID))
                if (reader.Read())
                {
                    entidad = new BEShowRoomOferta(reader);
                }
            return entidad;
        }

        public IList<BEShowRoomNivel> GetShowRoomNivel(int paisId)
        {
            var lst = new List<BEShowRoomNivel>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomNivel())
                while (reader.Read())
                {
                    var entity = new BEShowRoomNivel(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEShowRoomPersonalizacion> GetShowRoomPersonalizacion(int paisId)
        {
            var lst = new List<BEShowRoomPersonalizacion>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomPersonalizacion())
                while (reader.Read())
                {
                    var entity = new BEShowRoomPersonalizacion(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId,
            int nivelId, int categoriaId)
        {
            var lst = new List<BEShowRoomPersonalizacionNivel>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomPersonalizacionNivel(eventoId, nivelId, categoriaId))
                while (reader.Read())
                {
                    var entity = new BEShowRoomPersonalizacionNivel(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int InsertShowRoomPersonalizacionNivel(int paisID, BEShowRoomPersonalizacionNivel entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.InsertShowRoomPersonalizacionNivel(entity);
        }

        public int UpdateShowRoomPersonalizacionNivel(int paisID, BEShowRoomPersonalizacionNivel entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdateShowRoomPersonalizacionNivel(entity);
        }

        public List<BEShowRoomCategoria> GetShowRoomCategorias(int paisId, int eventoId)
        {
            var lst = new List<BEShowRoomCategoria>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomCategorias(eventoId))
                while (reader.Read())
                {
                    var entity = new BEShowRoomCategoria(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public BEShowRoomCategoria GetShowRoomCategoriaById(int paisId, int categoriaId)
        {
            BEShowRoomCategoria entidad = null;
            var daPedidoWeb = new DAShowRoomEvento(paisId);

            using (IDataReader reader = daPedidoWeb.GetShowRoomCategoriaById(categoriaId))
                if (reader.Read())
                {
                    entidad = new BEShowRoomCategoria(reader);
                }
            return entidad;
        }

        public void UpdateShowRoomDescripcionCategoria(int paisId, BEShowRoomCategoria categoria)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            dataAccess.UpdateShowRoomDescripcionCategoria(categoria);
        }

        public void DeleteInsertShowRoomCategoriaByEvento(int paisId, int eventoId, List<BEShowRoomCategoria> listaCategoria)
        {
            try
            {
                var dataAccess = new DAShowRoomEvento(paisId);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    dataAccess.DeleteShowRoomCategoriaByEvento(eventoId);

                    foreach (var beCategoria in listaCategoria)
                    {
                        dataAccess.InsertShowRoomCategoria(beCategoria);
                    }

                    oTransactionScope.Complete();
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public int UpdEventoConsultoraPopup(int paisID, BEShowRoomEventoConsultora entity, string tipo)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdUpdEventoConsultoraPopup(entity, tipo);
        }

        public int UpdShowRoomEventoConsultoraEmailRecibido(int paisID, BEShowRoomEventoConsultora entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.ShowRoomEventoConsultoraEmailRecibido(entity);
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var daPedidoWeb = new DAShowRoomEvento(paisId);

            using (IDataReader reader = daPedidoWeb.GetProductosCompraPorCompra(EventoID, CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEShowRoomOferta(reader);
                    lst.Add(entidad);
                }
            return lst;
        }

        public int ShowRoomProgramarAviso(int paisID, BEShowRoomEventoConsultora entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.ShowRoomProgramarAviso(entity);
        }

        public bool GetEventoConsultoraRecibido(int paisID, string CodigoConsultora, int CampaniaID)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.GetEventoConsultoraRecibido(CodigoConsultora, CampaniaID);
        }

        public IList<BEShowRoomTipoOferta> GetShowRoomTipoOferta(int paisId)
        {
            var lst = new List<BEShowRoomTipoOferta>();
            var dataAccess = new DAShowRoomEvento(paisId);

            using (IDataReader reader = dataAccess.GetShowRoomTipoOferta())
                while (reader.Read())
                {
                    var entity = new BEShowRoomTipoOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int ExisteShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            return dataAccess.ExisteShowRoomTipoOferta(entity);
        }

        public int InsertShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            return dataAccess.InsertShowRoomTipoOferta(entity);
        }

        public int UpdateShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            return dataAccess.UpdateShowRoomTipoOferta(entity);
        }

        public void HabilitarShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            dataAccess.HabilitarShowRoomTipoOferta(entity);
        }
    }
}
