using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionTipoProcesoCargaPedidos
    {
        public IList<BEConfiguracionTipoProcesoCargaPedidos> GetConfiguracionTipoProcesoCargaPedidos(int PaisID, int TipoPROL)
        {
            var lista = new List<BEConfiguracionTipoProcesoCargaPedidos>();
            var daConfiguracionTipoProcesoCargaPedidos = new DAConfiguracionTipoProcesoCargaPedidos(PaisID);

            using (IDataReader reader = daConfiguracionTipoProcesoCargaPedidos.GetConfiguracionTipoProcesoCargaPedidos(TipoPROL))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionTipoProcesoCargaPedidos(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsConfiguracionTipoProcesoCargaPedidos(int PaisID, string Usuario, IList<BEConfiguracionTipoProcesoCargaPedidos> ZonasNuevoPROL)
        {
            var daConfiguracionTipoProcesoCargaPedidos = new DAConfiguracionTipoProcesoCargaPedidos(PaisID);
            return daConfiguracionTipoProcesoCargaPedidos.InsConfiguracionTipoProcesoCargaPedidos(Usuario, ZonasNuevoPROL);
        }
    }
}
