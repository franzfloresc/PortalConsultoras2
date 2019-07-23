using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public interface ITuVozOnlineBusinessLogic
    {
        BETvoPanelConfig GetPanelConfig(int paisId);
        string GetUrl(BETvoPanelConfig panelConfig, BEUsuario user);
    }
}
