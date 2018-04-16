namespace Portal.Consultoras.Service
{
    using System;
    using System.Collections.Generic;
    using Portal.Consultoras.BizLogic.Estrategia;
    using Portal.Consultoras.Common;
    using Portal.Consultoras.Entities.Estrategia;
    using Portal.Consultoras.Entities.Framework;
    using Portal.Consultoras.ServiceContracts;

    public class EstrategiaService : IEstrategiaService
    {
        private readonly EstrategiaBusinessLogic _estrategiaBusinessLogic;

        public EstrategiaService()
        {
            _estrategiaBusinessLogic = new EstrategiaBusinessLogic(); 
        }
        public ResponseType<List<EstrategiaProductoSet>> ObtenerProductoEstrategia(string PaisId, string Campania, string CodigoConsultora, string TipoConsulta, string Texto, string CantidadResultado)
        {
            try
            {
                return _estrategiaBusinessLogic.ObtenerProductoEstrategia(PaisId, Campania, CodigoConsultora, TipoConsulta, Texto, CantidadResultado);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoConsultora, PaisId);
                return ResponseType<List<EstrategiaProductoSet>>.Build(success: false, message: ex.Message);
            }
        }
    }
}