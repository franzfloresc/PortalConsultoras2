using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers.Interfaces
{
    public interface INotificacionProvider
    {
        Task<int> ObtenerSinLeerAsync(int paisId, long consultoraId, int indicadorBloqueoCDR);
    }
}
