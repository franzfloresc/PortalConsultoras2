using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPaisDetalle
    {
        public bool Validar(BEConfiguracionPaisDetalle entidad)
        {
            try
            {
                var da = new DAConfiguracionPaisDetalle(entidad.PaisID);
                var retorno = da.Validar(entidad);
                return retorno;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
