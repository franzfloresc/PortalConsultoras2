namespace Portal.Consultoras.BizLogic.ArmaTuPack
{
    public interface IArmaTuPackBusinessLogic
    {
        bool CuvEstaEnLimite(int paisID, int campaniaID, string zona, string cuv, int cantidadIngresada, int cantidadActual);
    }
}