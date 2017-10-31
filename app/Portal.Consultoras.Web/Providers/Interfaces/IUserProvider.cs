using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Usuario;

namespace Portal.Consultoras.Web.Providers.Interfaces
{
    public interface IUserProvider
    {
        Task<UsuarioModel> ObtenerInformacionAsync(int paisId, string codigoUsuario);

        Task RegistrarIngresoAlPortal(int paisId, string codigoConsultora, string ipCliente, byte tipo, string campaniaId);
        
        Task<HanaModel> ObtenerDatosConsultoraHanaAsync(int paisId, string codigoUsuario, int campaniaId);

        void ActualizarDatosHana(ref UsuarioModel model);
    }
}
