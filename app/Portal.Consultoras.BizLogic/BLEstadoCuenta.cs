using Portal.Consultoras.Data;
//using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstadoCuenta
    {
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, string CodigoConsultora)
        {
            var lista = new List<BEEstadoCuenta>();

            //if (PaisId == 0) // Validar si informacion de pais es de origen Normal o Hana
            //{
                var DAEstadoCuenta = new DAEstadoCuenta(PaisId);

                using (IDataReader reader = DAEstadoCuenta.GetEstadoCuentaConsultora(CodigoConsultora))
                {
                    while (reader.Read())
                    {
                        var entidad = new BEEstadoCuenta(reader);

                        lista.Add(entidad);
                    }
                }
            //}
            //else
            //{
            //    var DAEstadoCuenta = new DAHEstadoCuenta();

            //    lista = DAEstadoCuenta.GetEstadoCuentaConsultora(PaisId, CodigoConsultora);
            //}

            return lista;
        }
    }
}
