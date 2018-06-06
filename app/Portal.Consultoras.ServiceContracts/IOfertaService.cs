using System;
using System.Collections.Generic;
using System.ServiceModel;
using Portal.Consultoras.Entities.ShowRoom;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IOfertaService
    {
        [OperationContract]
        IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora);

        [OperationContract]
        List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID);
    }
}
