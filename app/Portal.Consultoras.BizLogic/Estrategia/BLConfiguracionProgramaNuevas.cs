using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionProgramaNuevas : IConfiguracionProgramaNuevasBusinessLogic
    {
        public BEConfiguracionProgramaNuevas Get(BEProgramaNuevas programaNuevas)
        {
            var configuracion = new BEConfiguracionProgramaNuevas()
            {
                Campania = programaNuevas.CampaniaID.ToString(),
                CampaniaIngreso = (programaNuevas.CampaniaID - programaNuevas.ConsecutivoNueva).ToString(),
                CodigoConsultora = programaNuevas.CodigoConsultora
            };

            //if (!new BLPais().EsPaisHana(paisID))
            //{
            using (var reader = new DAConfiguracionProgramaNuevas(programaNuevas.PaisID).Get(configuracion))
            {
                configuracion = reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
            }
            //}
            //else
            //{
            //return new DAHConfiguracionProgramaNuevas().GetConfiguracionProgramaNuevas(paisID, entidad);
            //}
            
            return configuracion ?? new BEConfiguracionProgramaNuevas();
        }

        public string GetCuvKitNuevas(BEProgramaNuevas programaNuevas, BEConfiguracionProgramaNuevas confProgNuevas)
        {
            if (programaNuevas.EsConsultoraNueva) return confProgNuevas.CUVKit;

            var codigoISO = Common.Util.GetPaisISO(programaNuevas.PaisID);
            if (new List<int> { 1, 2 }.Contains(programaNuevas.ConsecutivoNueva) && WebConfig.PaisesFraccionKitNuevas.Contains(codigoISO))
            {
                confProgNuevas.Campania = programaNuevas.CampaniaID.ToString();
                confProgNuevas.CodigoNivel = GetCodigoNivel(programaNuevas);
                return new DAConfiguracionProgramaNuevas(programaNuevas.PaisID).GetCuvPremioKitNuevas(confProgNuevas);
            }

            return "";
        }

        public BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEProgramaNuevas programaNuevas, BEConfiguracionProgramaNuevas confProgNuevas)
        {
            confProgNuevas.Campania = programaNuevas.CampaniaID.ToString();
            confProgNuevas.CodigoNivel = GetCodigoNivel(programaNuevas);

            using (var reader = new DAConfiguracionProgramaNuevas(programaNuevas.PaisID).GetRegaloProgramaNuevas(confProgNuevas))
            {
                return reader.MapToObject<BEConsultoraRegaloProgramaNuevas>(true);
            }
        }

        public BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva)
        {
            var programaNuevas = new BEProgramaNuevas { PaisID = paisID, CampaniaID = campaniaId, CodigoConsultora = codigoConsultora, ConsecutivoNueva = consecutivoNueva };
            var configuracion = Get(programaNuevas);
            if (configuracion.IndExigVent != "1") return null;

            var regalo = GetRegaloProgramaNuevas(programaNuevas, configuracion);
            if (regalo == null) return null;

            regalo.CodigoNivel = GetCodigoNivel(programaNuevas);
            regalo.TippingPoint = configuracion.MontoVentaExigido;
            return regalo;
        }

        public string GetCodigoNivel(BEProgramaNuevas programaNuevas)
        {
            return "0" + (programaNuevas.ConsecutivoNueva + 1);
        }

        #region ConfiguracionApp
        public List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            using (var reader = new DAConfiguracionProgramaNuevas(entidad.PaisID).GetConfiguracionProgramaNuevasApp(entidad))
            {
                return reader.MapToCollection<BEConfiguracionProgramaNuevasApp>();
            }
        }

        public bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            return new DAConfiguracionProgramaNuevas(entidad.PaisID).InsConfiguracionProgramaNuevasApp(entidad);
        }
        #endregion
    }
}