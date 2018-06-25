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

        public void GuardarPerfilOfertaShowRoom(int paisId, int perfilId, int eventoId, int campaniaId, string cadenaCuv)
        {
            var dataAccess = new DAShowRoomEvento(paisId);
            dataAccess.GuardarPerfilOfertaShowRoom(perfilId, eventoId, campaniaId, cadenaCuv);
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
