using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers.Interfaces
{
    public interface IProgramaNuevasProvider
    {
        Task<ConsultoraRegaloProgramaNuevasModel> ObtenerRegalo(int paisID, int campaniaId, string codigoConsultora,
            string codigoRegion, string codigoZona);

    }
}
