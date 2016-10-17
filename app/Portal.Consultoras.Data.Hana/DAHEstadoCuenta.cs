using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.Hana.HanaService;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHEstadoCuenta
    {
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int paisId, string codigoConsultora)
        {
            var listBE = new List<BEEstadoCuenta>();
            var listaHana = new List<CuentaCorriente>();

            using (var service = new ServiceClient())
            {
                listaHana = service.ObtenerCuentaCorrienteConsultora(Util.GetCodigoIsoHana(paisId), codigoConsultora, "20").ToList();
            }

            listBE = Mapper.Map<IList<CuentaCorriente>, List<BEEstadoCuenta>>(listaHana);

            foreach (var item in listBE)
            {
                if (item.TipoOperacion == 1)
                {
                    item.Cargo = item.MontoOperacion;
                }
                else
                {
                    item.Abono = item.MontoOperacion;
                }
            }

            return listBE;
        }
    }
}
