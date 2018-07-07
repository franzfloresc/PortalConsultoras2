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
                CodigoConsultora = usuario.CodigoConsultora
            };

            if (usuario.EsConsultoraNueva) configuracion.CodigoNivel = "01";
            else if (new List<int> { 1, 2 }.Contains(usuario.ConsecutivoNueva) && WebConfig.PaisesFraccionKitNuevas.Contains(usuario.CodigoISO))
            {
                configuracion.CodigoNivel = "0" + (usuario.ConsecutivoNueva + 1);
            }

            if (!string.IsNullOrEmpty(configuracion.CodigoNivel))
            {
                using (var reader = new DAConfiguracionProgramaNuevas(usuario.PaisID).Get(configuracion))
                {
                    configuracion = reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
                }
            }
            return configuracion ?? new BEConfiguracionProgramaNuevas();
        }

        private BEConfiguracionProgramaNuevas GetPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            //if (!new BLPais().EsPaisHana(paisID))
            //{
                using (var reader = new DAConfiguracionProgramaNuevas(paisID).Get(entidad))
                {
                    return reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
                }
            //}
            //else
            //{
            //    return new DAHConfiguracionProgramaNuevas().GetConfiguracionProgramaNuevas(paisID, entidad);
            //}
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