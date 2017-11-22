using System.ServiceModel;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Usuario;
using Portal.Consultoras.Web.Providers.Interfaces;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Providers
{
    public class UserProvider : IUserProvider
    {
        public async Task<UsuarioModel> ObtenerInformacionAsync(int paisId, string codigoUsuario)
        {
            using (var client = new UsuarioServiceClient())
            {
                var usuarioSession = await client.GetSesionUsuarioAsync(paisId, codigoUsuario);

                if (usuarioSession == null)
                    throw new FaultException("Usuario no encontrado, pais: " + paisId + " codigo: " + codigoUsuario);

                return Mapper.Map<UsuarioModel>(usuarioSession);
            }
        }

        public async Task RegistrarIngresoAlPortal(int paisId, string codigoConsultora, string ipCliente, byte tipo, string campaniaId, string canal)
        {
            using (var client = new UsuarioServiceClient())
            {
                await client.InsLogIngresoPortalAsync(paisId, codigoConsultora, ipCliente, tipo, campaniaId, canal);
            }
        }

        public async Task<HanaModel> ObtenerDatosConsultoraHanaAsync(int paisId, string codigoUsuario, int campaniaId)
        {
            using (UsuarioServiceClient us = new UsuarioServiceClient())
            {
                var datosConsultoraHana = await us.GetDatosConsultoraHanaAsync(paisId, codigoUsuario, campaniaId);

                if (datosConsultoraHana == null)
                    return null;

                return Mapper.Map<HanaModel>(datosConsultoraHana);
            }
        }

        public async Task ActualizarDatosHana(UsuarioModel model)
        {
            var datosConsultoraHana = await ObtenerDatosConsultoraHanaAsync(model.PaisID, model.CodigoUsuario, model.CampaniaID);

            if (datosConsultoraHana != null)
            {
                model.FechaLimPago = datosConsultoraHana.FechaLimPago;
                model.MontoMinimo = datosConsultoraHana.MontoMinimoPedido;
                model.MontoMaximo = datosConsultoraHana.MontoMaximoPedido;
                model.MontoDeuda = datosConsultoraHana.MontoDeuda;
                model.IndicadorFlexiPago = datosConsultoraHana.IndicadorFlexiPago;
                model.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", (datosConsultoraHana.MontoMinimoFlexipago < 0 ? 0M : datosConsultoraHana.MontoMinimoFlexipago));
            }
        }
    }
}
