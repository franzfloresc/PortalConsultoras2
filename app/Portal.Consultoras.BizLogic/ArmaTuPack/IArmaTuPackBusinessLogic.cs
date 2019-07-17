namespace Portal.Consultoras.BizLogic.ArmaTuPack
{
    public interface IArmaTuPackBusinessLogic
    {
        bool CuvEstaEnLimite(int paisId, int campaniaId, string zona, string cuv, int cantidadIngresada, int cantidadActual);
    }
}