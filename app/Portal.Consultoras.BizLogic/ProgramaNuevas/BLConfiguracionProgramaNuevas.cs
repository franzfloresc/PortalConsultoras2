using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
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
            
            using (var reader = new DAConfiguracionProgramaNuevas(consultoraNuevas.PaisID).Get(configuracion))
            {
                configuracion = reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
            }
            
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

        public string GetMensajeKitNuevas(string codigoISO, bool esConsultoraNueva, int consecutivoNueva)
        {
            if (WebConfig.PaisesFraccionKitNuevas.Contains(codigoISO))
            {
                if (esConsultoraNueva) return Constantes.ProgNuevas.Mensaje.KitNueva_Pedido1;
                if (consecutivoNueva == 1) return Constantes.ProgNuevas.Mensaje.KitNueva_Pedido2;
                if (consecutivoNueva == 2) return Constantes.ProgNuevas.Mensaje.KitNueva_Pedido3;
            }
            else if (esConsultoraNueva) return Constantes.ProgNuevas.Mensaje.KitNueva_Pedido1Unico;

            return "";
        }

        public BEConsultoraRegaloProgramaNuevas GetPremioAutomatico(int paisID, int campaniaId, string codigoPrograma, string codigoNivel)
        {
            var confProgNuevas = new BEConfiguracionProgramaNuevas {
                CodigoPrograma = codigoPrograma,
                Campania = campaniaId.ToString(),
                CodigoNivel = codigoNivel
            };
            
            using (var reader = new DAConfiguracionProgramaNuevas(paisID).GetPremioAutomatico(confProgNuevas))
            {
                return reader.MapToObject<BEConsultoraRegaloProgramaNuevas>(true, true);
            }
        }
        public List<BEConsultoraRegaloProgramaNuevas> GetListPremioElectivo(int paisID, int campaniaId, string codigoPrograma, string codigoNivel)
        {
            var confProgNuevas = new BEConfiguracionProgramaNuevas
            {
                CodigoPrograma = codigoPrograma,
                Campania = campaniaId.ToString(),
                CodigoNivel = codigoNivel
            };
            
            using (var reader = new DAConfiguracionProgramaNuevas(paisID).GetListPremioElectivo(confProgNuevas))
            {
                return reader.MapToCollection<BEConsultoraRegaloProgramaNuevas>(closeReaderFinishing: true);
            }
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