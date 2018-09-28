using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IEscalaDescuentoBusinessLogic
    {
        List<BEEscalaDescuento> GetEscalaDescuento(int paisID, int campaniaID, string region, string zona);
        List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID, string algoritmo);
        List<BEEscalaDescuento> ListarEscalaDescuentoZona(int paisID, int campaniaID, string region, string zona);
    }
}