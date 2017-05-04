using System;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Controllers
{
    public partial class BaseController
    {
        /// <summary>
        /// Obtiene la configuracion de usuario simplificado .
        /// No hace calculos adicionales
        /// </summary>
        /// <returns>Retorna informacion simplificada de la configuracion del usuario</returns>
        protected BEUsuarioConfiguracion ObtenerUsuarioConfiguracion()
        {
            BEUsuarioConfiguracion usuario;
            using (var usuarioService = new UsuarioServiceClient())
            {
                usuario = usuarioService.ObtenerUsuarioConfiguracion(userData.PaisID, (int)userData.ConsultoraID,
                    userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA);
            }

            if (usuario == null)
                throw new NullReferenceException("No se encontro configuracion del usuario");

            return usuario;
        }
    }
}
