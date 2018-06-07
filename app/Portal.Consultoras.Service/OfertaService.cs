﻿using System;
using System.Collections.Generic;
using Portal.Consultoras.BizLogic.OfertaPersonalizada;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
using Portal.Consultoras.ServiceContracts;

namespace Portal.Consultoras.Service
{
    public class OfertaService : IOfertaService
    {
        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            return new BLOfertaPersonalizada().GetShowRoomOfertasConsultora(paisID, campaniaID, codigoConsultora);
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            return new BLOfertaPersonalizada().GetProductosCompraPorCompra(paisId, EventoID, CampaniaID);
        }

        public List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            return new BLOfertaPersonalizada().GetEstrategiaODD(paisID, codCampania, codConsultora, fechaInicioFact);
        }
    }
}
