using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.AsesoraOnline;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

//Made by Uchida Virtual Coach
namespace Portal.Consultoras.BizLogic
{
    public class BLAsesoraOnline
    {
        public int EnviarFormulario(string paisISO, BEAsesoraOnline entidad)
        {
            int paisId = GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.EnviarFormulario(entidad);
        }

        public BEUsuario GetUsuarioByCodigoConsultora(string paisISO, string codigoConsultora)
        {
            BEUsuario entidad = new BEUsuario();
            int paisId = GetPaisID(paisISO);
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
            int paisId = GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.ExisteConsultoraEnAsesoraOnline(codigoConsultora);
        }

        public int ActualizarEstadoConfiguracionPaisDetalle(string paisISO, string codigoConsultora, int estado)
        {
            int paisId = GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.ActualizarEstadoConfiguracionPaisDetalle(codigoConsultora, estado);
        }

        public int ValidarAsesoraOnlineConfiguracionPais(string paisISO, string codigoConsultora)
        {
            int paisId = GetPaisID(paisISO);
            var daAsesoraOnline = new DAAsesoraOnline(paisId);
            return daAsesoraOnline.ValidarAsesoraOnlineConfiguracionPais(codigoConsultora);
        }

        public void EnviarMailBienvenidaAsesoraOnline(string emailFrom, string emailTo, string titulo, string displayname, string nombreConsultora) {
            MailUtilities.EnviarMailBienvenidaAsesoraOnline(emailFrom,  emailTo,  titulo, displayname, nombreConsultora);
        }

        public int GetPaisID(string ISO)
        {
            List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
            {
                new KeyValuePair<string, string>("1", "AR"),
                new KeyValuePair<string, string>("2", "BO"),
                new KeyValuePair<string, string>("3", "CL"),
                new KeyValuePair<string, string>("4", "CO"),
                new KeyValuePair<string, string>("5", "CR"),
                new KeyValuePair<string, string>("6", "EC"),
                new KeyValuePair<string, string>("7", "SV"),
                new KeyValuePair<string, string>("8", "GT"),
                new KeyValuePair<string, string>("9", "MX"),
                new KeyValuePair<string, string>("10", "PA"),
                new KeyValuePair<string, string>("11", "PE"),
                new KeyValuePair<string, string>("12", "PR"),
                new KeyValuePair<string, string>("13", "DO"),
                new KeyValuePair<string, string>("14", "VE"),
            };
            string paisId;
            try
            {
                paisId = (from c in listaPaises
                          where c.Value == ISO.ToUpper()
                          select c.Key).SingleOrDefault();
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }

            if (paisId != null)
            {
                return int.Parse(paisId);
            }

            return 0;
        }
    }
}
