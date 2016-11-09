﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLShowRoomEvento
    {
        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            BEShowRoomEvento entidad = null;
            var DAPedidoWeb = new DAShowRoomEvento(paisID);

            using (IDataReader reader = DAPedidoWeb.GetShowRoomEventoByCampaniaID(campaniaID))
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
                var DAShowRoomEvento = new DAShowRoomEvento(paisID);
                int resultado;
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    resultado = DAShowRoomEvento.InsertShowRoomEvento(beShowRoomEvento);

                    string formatoPerfiles = Util.GetPaisISO(paisID) + "_" + beShowRoomEvento.CampaniaID + "_Perfil";
                    DAShowRoomEvento.InsertarShowRoomPerfil(beShowRoomEvento.NumeroPerfiles, formatoPerfiles, resultado);

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
            var DAShowRoomEvento = new DAShowRoomEvento(paisID);
            DAShowRoomEvento.UpdateShowRoomEvento(beShowRoomEvento);
        }

        public int CargarMasivaConsultora(int paisID, List<BEShowRoomEventoConsultora> listaConsultora)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.CargarMasivaConsultora(listaConsultora);
        }

        public int UpdOfertaShowRoomStockMasivo(int paisID, List<BEShowRoomOferta> stockProductos)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdOfertaShowRoomStockMasivo(stockProductos);
        }

        public int CargarMasivaDescripcionSets(int paisID, int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.CargarMasivaDescripcionSets(campaniaID, usuarioCreacion, listaShowRoomOfertaDetalle);
        }

        public BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            BEShowRoomEventoConsultora entidad = null;
            var DAPedidoWeb = new DAShowRoomEvento(paisID);

            using (IDataReader reader = DAPedidoWeb.GetShowRoomConsultora(campaniaID, codigoConsultora))
                if (reader.Read())
                {
                    entidad = new BEShowRoomEventoConsultora(reader);
                }
            return entidad;
        }

        public void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup)
        {
            var DAShowRoomEvento = new DAShowRoomEvento(paisID);
            DAShowRoomEvento.UpdateShowRoomConsultoraMostrarPopup(campaniaID, codigoConsultora, mostrarPopup);
        }

        public IList<BEShowRoomOferta> GetProductosShowRoom(int paisID, int tipoOfertaSisID, int campaniaID, string codigoOferta)
        {
            var lst = new List<BEShowRoomOferta>();
            var dataAccess = new DAShowRoomEvento(paisID);

            using (IDataReader reader = dataAccess.GetProductosShowRoom(tipoOfertaSisID, campaniaID, codigoOferta))
                while (reader.Read())
                {
                    var entity = new BEShowRoomOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int GetOrdenPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.GetOrdenPriorizacionShowRoom(ConfiguracionOfertaID, CampaniaID);
        }

        public int ValidarPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.ValidarPriorizacionShowRoom(ConfiguracionOfertaID, CampaniaID, Orden);
        }

        public int InsOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.InsOfertaShowRoom(entity);
        }

        public int UpdOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdOfertaShowRoom(entity);
        }

        public int DelOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.DelOfertaShowRoom(entity);
        }

        public int RemoverOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.RemoverOfertaShowRoom(entity);
        }

        public IList<BEShowRoomOferta> GetShowRoomOfertas(int paisID, int campaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var dataAccess = new DAShowRoomEvento(paisID);

            using (IDataReader reader = dataAccess.GetShowRoomOfertas(campaniaID))
                while (reader.Read())
                {
                    var entity = new BEShowRoomOferta(reader);
                    lst.Add(entity);
                }
            return lst;
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
            try
            {
                var dataAccess = new DAShowRoomEvento(entidad.PaisID);
                int result = dataAccess.CantidadPedidoByConsultoraShowRoom(entidad);
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
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
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

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

        public int InsOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.InsOfertaShowRoomDetalle(entity);
        }

        public int UpdOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.UpdOfertaShowRoomDetalle(entity);
        }

        public int EliminarOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle beShowRoomOfertaDetalle)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.EliminarOfertaShowRoomDetalle(beShowRoomOfertaDetalle);
        }

        public int EliminarOfertaShowRoomDetalleAll(int paisID, int campaniaID, string cuv)
        {
            var dataAccess = new DAShowRoomEvento(paisID);
            return dataAccess.EliminarOfertaShowRoomDetalleAll(campaniaID, cuv);
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
            var lst = new List<BEShowRoomOferta>();
            var dataAccess = new DAShowRoomEvento(paisID);

            using (IDataReader reader = dataAccess.GetShowRoomOfertasConsultora(campaniaID, codigoConsultora))
                while (reader.Read())
                {
                    var entity = new BEShowRoomOferta(reader);
                    lst.Add(entity);
                }
            return lst;
        }
    }
}
