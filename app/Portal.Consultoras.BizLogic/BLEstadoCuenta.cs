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

            var BLPais = new BLPais();

            if (!BLPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var DAEstadoCuenta = new DAEstadoCuenta(PaisId);

                using (IDataReader reader = DAEstadoCuenta.GetEstadoCuentaConsultora(consultoraId))
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
                var DAEstadoCuenta = new DAHEstadoCuenta();

                lista = DAEstadoCuenta.GetEstadoCuentaConsultora(PaisId, consultoraId);
            }

            return lista;
        }
    }
}
