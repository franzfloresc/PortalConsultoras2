using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.ProgramaNuevas
{
    public interface IActivarPremioNuevasBusinessLogic
    {
        BEActivarPremioNuevas GetActivarPremioNuevas(int paisID, string codigoPrograma, int anioCampana, string codigoNivel);
    }
}
