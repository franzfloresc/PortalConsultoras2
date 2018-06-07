using Portal.Consultoras.Entities.ShowRoom;
using System.Collections.Generic;
using System.ServiceModel;
<<<<<<< HEAD
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
=======
>>>>>>> 15f168d916e492f522846ed083f6e612282a2c82

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
    }
}
