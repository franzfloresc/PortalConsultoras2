using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IProgramaNuevasBusinessLogic
    {
        Enumeradores.ValidacionProgramaNuevas ValidarBusquedaCuv(int paisID, int campaniaID, string codigoPrograma, int consecutivoNueva, string cuv);
        Dictionary<string, Enumeradores.ValidacionProgramaNuevas> ValidarBusquedaListCuv(int paisID, int campaniaID, string codigoPrograma, int consecutivoNueva, List<string> listCuv);
        int ValidarCantidadMaxima(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada);
        BERespValidarElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, List<string> lstCuvPedido);
        void UpdFlagCupones(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<BEPedidoWebDetalle> listPedidoDetalle);
        bool EsCuvElecMultiple(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, string cuv);
        bool TieneListaEstrategiaElecMultiple(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<string> lstCuv);
        int GetLimElectivos(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma);
    }
}