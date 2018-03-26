using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IResumenCampaniaBusinessLogic
    {
        IList<BEResumenCampania> GetDeudaTotal(int paisID, int ConsultoraID);
        List<BEResumenCampania> GetFlexipago(int paisID, int ConsultoraID, int CampaniaID);
        decimal GetMontoDeuda(int paisID, int campaniaID, int consultoraID, string codigoUsuario, bool revisarHana);
        IList<BEResumenCampania> GetPedidoWebAcumulado(int paisID, int CampaniaID, int ConsultoraID);
        IList<BEResumenCampania> GetProductosSolicitados(int paisID, int CampaniaID, int ConsultoraID);
        IList<BEResumenCampania> GetSaldoPendiente(int paisID, int CampaniaID, int ConsultoraID);
        IList<BEResumenCampania> GetValorAPagar(int paisID, int CampaniaID, int ConsultoraID);
    }
}