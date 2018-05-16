using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IEscalaDescuentoBusinessLogic
    {
        List<BEEscalaDescuento> GetEscalaDescuento(int paisID);
        List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID, string algoritmo);
    }
}