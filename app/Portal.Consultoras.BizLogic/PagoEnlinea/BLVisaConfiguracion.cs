using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLVisaConfiguracion
    {
        public IList<BEVisaConfiguracion> GetConfiguracionVisa(int PaisId)
        {
            List<BEVisaConfiguracion> Configuracion = new List<BEVisaConfiguracion>();
            DAVisaConfiguracion VisaConfig = new DAVisaConfiguracion(PaisId);

            using (IDataReader reader = VisaConfig.GetConfiguracionVisa())
            {
                while (reader.Read())
                {
                    Configuracion.Add(new BEVisaConfiguracion(reader));
                }
            }
            return Configuracion;
        }
    }
}