using Portal.Consultoras.Entities.CDR;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface ICDRService
    {
        [OperationContract]
        int InsCDRWeb(int PaisID, BECDRWeb entity);

        [OperationContract]
        int DelCDRWeb(int PaisID, BECDRWeb entity);

        [OperationContract]
        List<BECDRWeb> GetCDRWeb(int PaisID, BECDRWeb entity);
        
        [OperationContract]
        int InsCDRWebDetalle(int PaisID, BECDRWebDetalle entity);

        [OperationContract]
        int DelCDRWebDetalle(int PaisID, BECDRWebDetalle entity);

        [OperationContract]
        List<BECDRWebDetalle> GetCDRWebDetalle(int PaisID, BECDRWebDetalle entity);
        
        [OperationContract]
        int InsCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity);

        [OperationContract]
        int DelCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity);

        [OperationContract]
        List<BECDRWebMotivoOperacion> GetCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity);

        [OperationContract]
        int InsCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity);

        [OperationContract]
        int DelCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity);

        [OperationContract]
        List<BECDRWebDescripcion> GetCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity);

        [OperationContract]
        BELogCDRWeb GetLogCDRWebByLogCDRWebId(int paisId, long logCDRWebId);

        [OperationContract]
        int UpdateLogCDRWebVisualizado(int paisId, long logCDRWebId);

        [OperationContract]
        List<BELogCDRWebDetalle> GetLogCDRWebDetalleByLogCDRWebId(int paisId, long logCDRWebId);        
    }
}
