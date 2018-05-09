using System;
using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CargaMasiva;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.BizLogic
{
    public interface IEstrategiaBusinessLogic
    {
        int ActivarDesactivarEstrategias(int paisID, string UsuarioModificacion, string EstrategiasActivas, string EstrategiasDesactivas);
        int AprobarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad);
        int DeshabilitarEstrategia(BEEstrategia entidad);
        int EliminarEstrategia(BEEstrategia entidad);
        int EliminarTallaColor(BETallaColor entidad);
        List<BEEstrategia> FiltrarEstrategia(BEEstrategia entidad);
        List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad);
        BEEstrategiaDetalle GetEstrategiaDetalle(int paisID, int estrategiaID);
        List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact);
        List<BEEstrategia> GetEstrategias(BEEstrategia entidad);
        List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad);
        List<BEMatrizComercialImagen> GetImagenesByEstrategiaMatrizComercialImagen(BEEstrategia entidad, int pagina, int registros);
        string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv);
        List<BECargaMasivaImagenes> GetListaImagenesEstrategiasByCampania(int paisId, int campaniaId);
        List<BECargaMasivaImagenes> GetListaImagenesOfertaLiquidacionByCampania(int paisId, int campaniaId);
        List<BECargaMasivaImagenes> GetListaImagenesProductoSugeridoByCampania(int paisId, int campaniaId);
        List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleAprobar(int paisID, BEProductoComentarioFilter filter);
        List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleResumen(int paisID, BEProductoComentarioFilter filter);
        
        List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad);
        BEProductoComentario GetProductoComentarioByCodSap(int paisID, string codigoSap);
        IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID);
        List<BETallaColor> GetTallaColor(BETallaColor entidad);
        BEProductoComentarioDetalle GetUltimoProductoComentarioByCodigoSap(int paisID, string codigoSap);
        List<int> InsertarEstrategiaMasiva(BEEstrategiaMasiva entidad);
        int InsertarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad);
        List<int> InsertarProductoShowroomMasiva(BEEstrategiaMasiva entidad);
        int InsertEstrategia(BEEstrategia entidad);
        int InsertEstrategiaOfertaParaTi(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario, int estrategiaId);
        int InsertEstrategiaTemporal(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario, int nroLore);
        int InsertTallaColorCUV(BETallaColor entidad);
        int ValidarCUVsRecomendados(BEEstrategia entidad);
        string ValidarStockEstrategia(BEEstrategia entidad);
        
    }
}