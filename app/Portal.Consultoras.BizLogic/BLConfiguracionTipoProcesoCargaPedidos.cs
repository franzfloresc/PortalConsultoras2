using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionTipoProcesoCargaPedidos
    {
        public IList<BEConfiguracionTipoProcesoCargaPedidos> GetConfiguracionTipoProcesoCargaPedidos(int PaisID, int TipoPROL)
        {
            var lista = new List<BEConfiguracionTipoProcesoCargaPedidos>();
            var DAConfiguracionTipoProcesoCargaPedidos = new DAConfiguracionTipoProcesoCargaPedidos(PaisID);

            using (IDataReader reader = DAConfiguracionTipoProcesoCargaPedidos.GetConfiguracionTipoProcesoCargaPedidos(TipoPROL))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionTipoProcesoCargaPedidos(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsConfiguracionTipoProcesoCargaPedidos(int PaisID, string Usuario, IList<BEConfiguracionTipoProcesoCargaPedidos> ZonasNuevoPROL)
        {
            var DAConfiguracionTipoProcesoCargaPedidos = new DAConfiguracionTipoProcesoCargaPedidos(PaisID);
            return DAConfiguracionTipoProcesoCargaPedidos.InsConfiguracionTipoProcesoCargaPedidos(Usuario, ZonasNuevoPROL);
        }
    }
}
