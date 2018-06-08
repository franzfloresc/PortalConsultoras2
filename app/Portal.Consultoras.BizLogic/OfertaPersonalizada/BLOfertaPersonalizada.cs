using System;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.OfertaPersonalizada
{
    public class BLOfertaPersonalizada
    {
        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            BEShowRoomEvento entidad = null;
            var da = new DAShowRoomEvento(paisID);

            using (IDataReader reader = da.GetShowRoomEventoByCampaniaID(campaniaID))
            {
                if (reader.Read())
                {
                    entidad = new BEShowRoomEvento(reader);
                }
            }
            return entidad;
        }

        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            List<BEShowRoomOferta> showRoomOfertas;
            var da = new DAShowRoomEvento(paisID);

            using (var reader = da.GetShowRoomOfertasConsultoraPersonalizada(campaniaID, codigoConsultora))
            {
                showRoomOfertas = reader.MapToCollection<BEShowRoomOferta>();
            }
            return showRoomOfertas;
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            var lst = new List<BEShowRoomOferta>();
            var da = new DAShowRoomEvento(paisId);

            using (IDataReader reader = da.GetProductosCompraPorCompra(EventoID, CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEShowRoomOferta(reader);
                    lst.Add(entidad);
                }
            return lst;
        }

        public List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            var listaEstrategias = new List<BEEstrategia>();
            var daEstrategia = new DAEstrategia(paisID);

            using (var reader = daEstrategia.GetEstrategiaODD(codCampania, codConsultora, fechaInicioFact))
            {
                while (reader.Read())
                {
                    listaEstrategias.Add(new BEEstrategia(reader));
                }
            }

            var codigoIso = Util.GetPaisISO(paisID);
            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;

            listaEstrategias.ForEach(item =>
            {
                item.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, item.FotoProducto01, carpetaPais);
            });

            return listaEstrategias;
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

        public IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId, int nivelId, int categoriaId)
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
    }
}
