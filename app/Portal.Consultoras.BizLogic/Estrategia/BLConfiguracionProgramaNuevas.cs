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
        public BEConfiguracionProgramaNuevas Get(BEConsultoraProgramaNuevas consultoraNuevas)
        {
            var configuracion = new BEConfiguracionProgramaNuevas()
            {
                Campania = consultoraNuevas.CampaniaID.ToString(),
                CampaniaIngreso = (consultoraNuevas.CampaniaID - consultoraNuevas.ConsecutivoNueva).ToString(),
                CodigoConsultora = consultoraNuevas.CodigoConsultora
            };

            //if (!new BLPais().EsPaisHana(paisID))
            //{
            using (var reader = new DAConfiguracionProgramaNuevas(consultoraNuevas.PaisID).Get(configuracion))
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

        public string GetCuvKitNuevas(BEConsultoraProgramaNuevas consultoraNuevas, BEConfiguracionProgramaNuevas confProgNuevas)
        {
            if (consultoraNuevas.EsConsultoraNueva) return confProgNuevas.CUVKit;

            var codigoISO = Common.Util.GetPaisISO(consultoraNuevas.PaisID);
            if (new List<int> { 1, 2 }.Contains(consultoraNuevas.ConsecutivoNueva) && WebConfig.PaisesFraccionKitNuevas.Contains(codigoISO))
            {
                confProgNuevas.Campania = consultoraNuevas.CampaniaID.ToString();
                confProgNuevas.CodigoNivel = GetCodigoNivel(consultoraNuevas);
                return new DAConfiguracionProgramaNuevas(consultoraNuevas.PaisID).GetCuvPremioKitNuevas(confProgNuevas);
            }

            return "";
        }

        public BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEConsultoraProgramaNuevas consultoraNuevas, BEConfiguracionProgramaNuevas confProgNuevas)
        {
            confProgNuevas.Campania = consultoraNuevas.CampaniaID.ToString();
            confProgNuevas.CodigoNivel = GetCodigoNivel(consultoraNuevas);

            using (var reader = new DAConfiguracionProgramaNuevas(consultoraNuevas.PaisID).GetRegaloProgramaNuevas(confProgNuevas))
            {
                return reader.MapToObject<BEConsultoraRegaloProgramaNuevas>(true);
            }
        }

        public BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva)
        {
            var consultoraNuevas = new BEConsultoraProgramaNuevas { PaisID = paisID, CampaniaID = campaniaId, CodigoConsultora = codigoConsultora, ConsecutivoNueva = consecutivoNueva };
            var configuracion = Get(consultoraNuevas);
            if (configuracion.IndExigVent != "1") return null;

            var regalo = GetRegaloProgramaNuevas(consultoraNuevas, configuracion);
            if (regalo == null) return null;

            regalo.CodigoNivel = GetCodigoNivel(consultoraNuevas);
            regalo.TippingPoint = configuracion.MontoVentaExigido;
            return regalo;
        }

        public string GetCodigoNivel(BEConsultoraProgramaNuevas consultoraNuevas)
        {
            return "0" + (consultoraNuevas.ConsecutivoNueva + 1);
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