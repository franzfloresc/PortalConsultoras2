using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLUsuario
    {
        public BEUsuarioConfiguracion ObtenerUsuarioConfiguracion(int paisID, int consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA)
        {
            BEUsuario usuario = null;
            using (var reader = (new DAConfiguracionCampania(paisID)).GetConfiguracionByUsuarioAndCampania(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
            {
                if (reader.Read()) usuario = new BEUsuario(reader, true);
            }

            if (usuario == null)
                return null;

            var usuarioConfiguracion = new BEUsuarioConfiguracion()
            {
                PaisID = usuario.PaisID,
                CodigoISO = usuario.CodigoISO,
                TieneHana = usuario.TieneHana,
                Simbolo = usuario.Simbolo,
                EstadoSimplificacionCUV = usuario.EstadoSimplificacionCUV,
                ZonaHoraria = usuario.ZonaHoraria,
                PROLSinStock = usuario.PROLSinStock,
                NuevoPROL = usuario.NuevoPROL,
                ZonaNuevoPROL = usuario.ZonaNuevoPROL,
                ZonaValida = usuario.ZonaValida,
                DiasAntes = usuario.DiasAntes,
                HoraInicio = usuario.HoraInicio,
                HoraFin = usuario.HoraFin,
                HoraInicioNoFacturable = usuario.HoraInicioNoFacturable,
                HoraCierreNoFacturable = usuario.HoraCierreNoFacturable,
                ValidacionInteractiva = usuario.ValidacionInteractiva,
                HabilitarRestriccionHoraria = usuario.HabilitarRestriccionHoraria,
                HorasDuracionRestriccion = usuario.HorasDuracionRestriccion,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                PrimerNombre = usuario.PrimerNombre,
                MontoMinimoPedido = usuario.MontoMinimoPedido,
                MontoMaximoPedido = usuario.MontoMaximoPedido,
                ConsultoraNueva = usuario.ConsultoraNueva,
                CodigoConsultora = usuario.CodigoConsultora,
                CodigoUsuario = usuario.CodigoUsuario,
                NombreCompleto = usuario.Nombre,
                Email = usuario.EMail,
                UsuarioPrueba = usuario.UsuarioPrueba,
                RegionID = usuario.RegionID,
                CodigorRegion = usuario.CodigorRegion,
                ZonaID = usuario.ZonaID,
                CodigoZona = usuario.CodigoZona,
                ConsultoraAsociadoID = usuario.ConsultoraAsociadaID,
                ConsultoraAsociada = usuario.ConsultoraAsociada,
                FechaInicioFacturacion = usuario.FechaInicioFacturacion,
                FechaFinFacturacion = usuario.FechaFinFacturacion,
                HoraCierreZonaNormal = usuario.HoraCierreZonaNormal,
                HoraCierreZonaDemAnti = usuario.HoraCierreZonaDemAnti,
                EsZonaDemAnti = usuario.EsZonaDemAnti,
                TipoUsuario = usuario.TipoUsuario
            };

            return usuarioConfiguracion;
        }
    }
}
