using Portal.Consultoras.Entities.LimiteVenta;

namespace Portal.Consultoras.BizLogic.LimiteVenta
{
    public interface ILimiteVentaBusinessLogic
    {
        BERespValidarLimiteVenta CuvTieneLimiteVenta(int paisID, int campaniaID, string region, string zona, string cuv, int cantidadIngresada, int cantidadActual);
    }
}