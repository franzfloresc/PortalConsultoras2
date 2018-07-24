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
        List<BEEstrategia> GetEstrategiaODD(BEEstrategia entidad, string codConsultora, DateTime fechaInicioFact);

        [OperationContract]
        List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad);
    }
}
