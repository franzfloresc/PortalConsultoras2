using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.AsesoraOnline;
using Portal.Consultoras.BizLogic;

namespace Portal.Consultoras.Service
{
    public class AsesoraOnlineService : IAsesoraOnlineService
    {
        public int EnviarFormulario(string paisISO, BEAsesoraOnline entidad)
        {
            return new BLAsesoraOnline().EnviarFormulario(paisISO, entidad);
        }
    }
}
