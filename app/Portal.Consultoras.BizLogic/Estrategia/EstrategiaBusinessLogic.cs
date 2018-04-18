namespace Portal.Consultoras.BizLogic.Estrategia
{
    using System.Collections.Generic;
    using System.Linq;
    using Portal.Consultoras.Data.Estrategia;
    using Portal.Consultoras.Entities.Estrategia;
    using Portal.Consultoras.Entities.Framework;

    public class EstrategiaBusinessLogic
    {
        public ResponseType<List<EstrategiaProductoSet>> ObtenerProductoEstrategia(string PaisId, string Campania, string CodigoConsultora, string TipoConsulta, string Texto, string CantidadResultado)
        {
            string[] TipoDeConsulta = { "CUV", "NOMBRE", "MARCA" };
            if (!TipoDeConsulta.Contains(TipoConsulta))
                return ResponseType<List<EstrategiaProductoSet>>.Build(success: false, message: "Tipo de consulta no valido.");

            var _estrategiaDataAccess = new EstrategiaDataAccess(int.Parse(PaisId));
            List<EstrategiaProductoSet> result = _estrategiaDataAccess.ObtenerProductoEstrategia(int.Parse(Campania), CodigoConsultora, TipoConsulta, Texto, int.Parse(CantidadResultado));

            if (result.Count==0)
                return ResponseType<List<EstrategiaProductoSet>>.Build(message: "No se han encontrados resultado con los parámetros especificados.", data: result);


            return ResponseType<List<EstrategiaProductoSet>>.Build(data: result);
        }
    }
}
