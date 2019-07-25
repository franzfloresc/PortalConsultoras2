using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Configuracion
{
    public interface IConfiguracionPaisFFVVDatosBusinessLogic
    {
        List<BEConfiguracionPaisFFVVDatos> GetList(BEConfiguracionPaisFFVVDatos entidad);
    }
}
