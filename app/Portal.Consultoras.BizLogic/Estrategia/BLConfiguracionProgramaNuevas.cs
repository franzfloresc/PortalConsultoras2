using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionProgramaNuevas : IConfiguracionProgramaNuevasBusinessLogic
    {
        public BEConfiguracionProgramaNuevas Get(BEUsuario usuario)
        {
            var configuracion = new BEConfiguracionProgramaNuevas()
            {
                Campania = usuario.CampaniaID.ToString(),
                CampaniaIngreso = (usuario.CampaniaID - usuario.ConsecutivoNueva).ToString(),
                CodigoConsultora = usuario.CodigoConsultora
            };

            //if (!new BLPais().EsPaisHana(paisID))
            //{
            using (var reader = new DAConfiguracionProgramaNuevas(usuario.PaisID).Get(configuracion))
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

        public string GetCuvKitNuevas(BEUsuario usuario, BEConfiguracionProgramaNuevas confProgNuevas)
        {
            if (usuario.EsConsultoraNueva) return confProgNuevas.CUVKit;
            if (new List<int> { 1, 2 }.Contains(usuario.ConsecutivoNueva) && WebConfig.PaisesFraccionKitNuevas.Contains(usuario.CodigoISO))
            {
                confProgNuevas.Campania = usuario.CampaniaID.ToString();
                confProgNuevas.CodigoNivel = GetCodigoNivel(usuario);
                return new DAConfiguracionProgramaNuevas(usuario.PaisID).GetCuvPremioKitNuevas(confProgNuevas);
            }
            return "";
        }

        public BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEUsuario usuario, BEConfiguracionProgramaNuevas confProgNuevas)
        {
            confProgNuevas.Campania = usuario.CampaniaID.ToString();
            confProgNuevas.CodigoNivel = GetCodigoNivel(usuario);

            using (var reader = new DAConfiguracionProgramaNuevas(usuario.PaisID).GetRegaloProgramaNuevas(confProgNuevas))
            {
                return reader.MapToObject<BEConsultoraRegaloProgramaNuevas>(true);
            }
        }

        public BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva)
        {
            var usuario = new BEUsuario { PaisID = paisID, CampaniaID = campaniaId, CodigoConsultora = codigoConsultora, ConsecutivoNueva = consecutivoNueva };
            var configuracion = Get(usuario);
            if (configuracion.IndExigVent != "1") return null;

            var regalo = GetRegaloProgramaNuevas(usuario, configuracion);
            if (regalo == null) return null;

            regalo.CodigoNivel = GetCodigoNivel(usuario);
            regalo.TippingPoint = configuracion.MontoVentaExigido;
            return regalo;
        }

        public string GetCodigoNivel(BEUsuario usuario)
        {
            return "0" + (usuario.ConsecutivoNueva + 1);
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