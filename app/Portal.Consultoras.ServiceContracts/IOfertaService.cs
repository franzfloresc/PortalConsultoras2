using System;
using Portal.Consultoras.Entities.ShowRoom;
using System.Collections.Generic;
using System.ServiceModel;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IOfertaService
    {
        [OperationContract]
        IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora);

        [OperationContract]
        List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID);

        [OperationContract]
        List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact);

        [OperationContract]
        BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID);

        [OperationContract]
        BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion);

        [OperationContract]
        IList<BEShowRoomNivel> GetShowRoomNivel(int paisId);

        [OperationContract]
        IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId, int nivelId, int categoriaId);
    }
}
