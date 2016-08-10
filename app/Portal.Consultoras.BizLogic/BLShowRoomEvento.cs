using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
            var DAShowRoomEvento = new DAShowRoomEvento(paisID);
            return DAShowRoomEvento.InsertShowRoomEvento(beShowRoomEvento);
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
    }
}
