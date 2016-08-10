using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

// R2073 - Toda la clase
namespace Portal.Consultoras.BizLogic
{
    public class BLEstadoCuenta
    {
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, string CodigoConsultora)
        {
            var lista = new List<BEEstadoCuenta>();
            var DAEstadoCuenta = new DAEstadoCuenta(PaisId);

            using (IDataReader reader = DAEstadoCuenta.GetEstadoCuentaConsultora(CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEEstadoCuenta(reader);

                    lista.Add(entidad);
                }

            return lista;
        }
    }
}
