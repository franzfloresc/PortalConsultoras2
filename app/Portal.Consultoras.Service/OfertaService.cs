using Portal.Consultoras.BizLogic.OfertaPersonalizada;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class OfertaService : IOfertaService
    {
        #region ShowRoom

        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            return new BLOfertaPersonalizada().GetShowRoomOfertasConsultora(paisID, campaniaID, codigoConsultora);
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            return new BLOfertaPersonalizada().GetProductosCompraPorCompra(paisId, EventoID, CampaniaID);
        }

        #endregion

        public List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            return new BLOfertaPersonalizada().GetEstrategiaODD(paisID, codCampania, codConsultora, fechaInicioFact);
        }

        public List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad)
        {
            return new BLOfertaPersonalizada().GetEstrategiasPedido(entidad);
        }

        #region Confi
        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            return new BLOfertaPersonalizada().GetShowRoomEventoByCampaniaID(paisID, campaniaID);
        }

        public BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion)
        {
            return new BLOfertaPersonalizada().GetShowRoomConsultora(paisID, campaniaID, codigoConsultora, tienePersonalizacion);
        }

        public IList<BEShowRoomNivel> GetShowRoomNivel(int paisId)
        {
            return new BLOfertaPersonalizada().GetShowRoomNivel(paisId);
        }

        public IList<BEShowRoomPersonalizacion> GetShowRoomPersonalizacion(int paisId)
        {
            return new BLOfertaPersonalizada().GetShowRoomPersonalizacion(paisId);
        }

        public IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId, int nivelId, int categoriaId)
        {
            return new BLOfertaPersonalizada().GetShowRoomPersonalizacionNivel(paisId, eventoId, nivelId, categoriaId);
        }

        public int ShowRoomProgramarAviso(int paisID, BEShowRoomEventoConsultora entity)
        {
            return new BLOfertaPersonalizada().ShowRoomProgramarAviso(paisID, entity);
        }

        public List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID, string algoritmo)
        {
            return new BLOfertaPersonalizada().GetParametriaOfertaFinal(paisID, algoritmo);
        }

        #endregion
    }
}
