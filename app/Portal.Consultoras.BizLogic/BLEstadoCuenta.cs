using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstadoCuenta
    {
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, long consultoraId)
        {
            var lista = new List<BEEstadoCuenta>();

            var blPais = new BLPais();

            if (!blPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var daEstadoCuenta = new DAEstadoCuenta(PaisId);

                using (IDataReader reader = daEstadoCuenta.GetEstadoCuentaConsultora(consultoraId))
                {
                    while (reader.Read())
                    {
                        var entidad = new BEEstadoCuenta(reader);

                        lista.Add(entidad);
                    }
                }
            }
            else
            {
                var daEstadoCuenta = new DAHEstadoCuenta();

                lista = daEstadoCuenta.GetEstadoCuentaConsultora(PaisId, consultoraId);
            }

            return lista;
        }

        public string GetDeudaActualConsultora(int PaisId, long consultoraId)
        {
            var daEstadoCuenta = new DAEstadoCuenta(PaisId);
            return daEstadoCuenta.GetDeudaActualConsultora(consultoraId);
        }
    }
}
