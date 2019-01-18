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

        // se movio a Util.GetPaisID
        //public int GetPaisID(string ISO)
        //{
        //    List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
        //    {
        //        new KeyValuePair<string, string>("1", Constantes.CodigosISOPais.Argentina),
        //        new KeyValuePair<string, string>("2", Constantes.CodigosISOPais.Bolivia),
        //        new KeyValuePair<string, string>("3", Constantes.CodigosISOPais.Chile),
        //        new KeyValuePair<string, string>("4", Constantes.CodigosISOPais.Colombia),
        //        new KeyValuePair<string, string>("5", Constantes.CodigosISOPais.CostaRica),
        //        new KeyValuePair<string, string>("6", Constantes.CodigosISOPais.Ecuador),
        //        new KeyValuePair<string, string>("7", Constantes.CodigosISOPais.Salvador),
        //        new KeyValuePair<string, string>("8", Constantes.CodigosISOPais.Guatemala),
        //        new KeyValuePair<string, string>("9", Constantes.CodigosISOPais.Mexico),
        //        new KeyValuePair<string, string>("10", Constantes.CodigosISOPais.Panama),
        //        new KeyValuePair<string, string>("11", Constantes.CodigosISOPais.Peru),
        //        new KeyValuePair<string, string>("12", Constantes.CodigosISOPais.PuertoRico),
        //        new KeyValuePair<string, string>("13", Constantes.CodigosISOPais.Dominicana),
        //        new KeyValuePair<string, string>("14", Constantes.CodigosISOPais.Venezuela),
        //    };
        //    string paisId;
        //    try
        //    {
        //        paisId = (from c in listaPaises
        //                  where c.Value == ISO.ToUpper()
        //                  select c.Key).SingleOrDefault();
        //    }
        //    catch (Exception)
        //    {
        //        throw new Exception("Hubo un error en obtener el País");
        //    }
        //    if (paisId != null)
        //    {
        //        return int.Parse(paisId);
        //    }
        //    return 0;
        //}

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