using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public interface ITuVozOnlineBusinessLogic
    {
        BETvoPanelConfig GetPanelConfig(int paisId);
        string GetUrl(BEUsuario user);
        string GetUrl(BETvoPanelConfig panelConfig, BEUsuario user);
    }
}
