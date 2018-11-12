using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.PagoEnLinea;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.PagoEnlinea
{
    public interface IPagoEnLineaBusinessLogic
    {
        int InsertPagoEnLineaResultadoLog(int paisId, BEPagoEnLineaResultadoLog entidad);
        string ObtenerTokenTarjetaGuardadaByConsultora(int paisId, string codigoConsultora);
        void UpdateMontoDeudaConsultora(int paisId, string codigoConsultora, decimal montoDeuda);
        BEPagoEnLineaResultadoLog ObtenerPagoEnLineaById(int paisId, int pagoEnLineaResultadoLogId);
        void UpdateVisualizado(int paisId, int pagoEnLineaResultadoLogId);
        BEPagoEnLineaResultadoLog ObtenerUltimoPagoEnLineaByConsultoraId(int paisId, long consultoraId);
        List<BEPagoEnLineaResultadoLogReporte> ObtenerPagoEnLineaByFiltro(int paisId, BEPagoEnLineaFiltro filtro);
        List<BEPagoEnLineaTipoPago> ObtenerPagoEnLineaTipoPago(int paisId);
        List<BEPagoEnLineaMedioPago> ObtenerPagoEnLineaMedioPago(int paisId);
        List<BEPagoEnLineaMedioPagoDetalle> ObtenerPagoEnLineaMedioPagoDetalle(int paisId);
        List<BEPagoEnLineaTipoPasarela> ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(int paisId, string codigoPlataforma);
        List<BEPagoEnLineaPasarelaCampos> ObtenerPagoEnLineaPasarelaCampos(int paisId);
        int ObtenerNumeroOrden(int paisId);
        string ObtenerPagoEnLineaURLPaginasBancos(int paisId);
        List<BEPagoEnLineaBanco> ObtenerPagoEnLineaBancos(int paisId);
        BEPagoEnLinea ObtenerPagoEnLineaConfiguracion(int paisId, long consultoraId, string codigoUsuario);
        BEPagoEnLineaVisa ObtenerPagoEnLineaVisaConfiguracion(int paisId, string codigoConsutora);
        BERespuestaServicio RegistrarPagoEnLineaVisa(BEUsuario usuario, BEPagoEnLineaVisa pagoEnLineaVisa);
        
    }
}
