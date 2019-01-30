using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.AsesoraOnline;
using System.Data;

//Made by Uchida Virtual Coach
namespace Portal.Consultoras.BizLogic
{
    public class BLAsesoraOnline
    {
        public int EnviarFormulario(string paisISO, BEAsesoraOnline entidad)
        {
            int paisId = Util.GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.EnviarFormulario(entidad);
        }

        public BEUsuario GetUsuarioByCodigoConsultora(string paisISO, string codigoConsultora)
        {
            BEUsuario entidad = new BEUsuario();
            int paisId = Util.GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);

            using (IDataReader reader = daAsesoraOnline.GetUsuarioByCodigoConsultora(codigoConsultora))
                while (reader.Read())
                {
                    entidad = new BEUsuario(reader, true);
                }

            return entidad;
        }

        public int ExisteConsultoraEnAsesoraOnline(string paisISO, string codigoConsultora)
        {
            int paisId = Util.GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.ExisteConsultoraEnAsesoraOnline(codigoConsultora);
        }

        public int ActualizarEstadoConfiguracionPaisDetalle(string paisISO, string codigoConsultora, int estado)
        {
            int paisId = Util.GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.ActualizarEstadoConfiguracionPaisDetalle(codigoConsultora, estado);
        }

        public int ValidarAsesoraOnlineConfiguracionPais(string paisISO, string codigoConsultora)
        {
            int paisId = Util.GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.ValidarAsesoraOnlineConfiguracionPais(codigoConsultora);
        }

        public void EnviarMailBienvenidaAsesoraOnline(string emailFrom, string emailTo, string titulo, string displayname, string nombreConsultora)
        {
            MailUtilities.EnviarMailBienvenidaAsesoraOnline(emailFrom, emailTo, titulo, displayname, nombreConsultora);
        }

        public string CancelarSuscripcion(string paisISO, string codigoConsultora)
        {
            int paisId = Util.GetPaisID(paisISO);
            var objDASuscripcionConsultora = new DAAsesoraOnline(paisId);
            return objDASuscripcionConsultora.CancelarSuscripcion(codigoConsultora);
        }

        public int VuelveASuscripcion(string paisISO, string codigoConsultora)
        {
            int paisId = Util.GetPaisID(paisISO);
            var objDASuscripcionConsultora = new DAAsesoraOnline(paisId);
            return objDASuscripcionConsultora.VuelveASuscripcion(codigoConsultora);
        }

    }
}