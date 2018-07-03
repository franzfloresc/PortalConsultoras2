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
            var obeConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas()
            {
                CampaniaInicio = usuario.CampaniaID.ToString(),
                CodigoConsultora = usuario.CodigoConsultora
            };

            if (usuario.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                usuario.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                usuario.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
            {
                if (WebConfig.PaisesFraccionKitNuevas.Contains(usuario.CodigoISO))
                {
                    obeConfiguracionProgramaNuevas.CodigoNivel = usuario.ConsecutivoNueva == 1 ? "02" : usuario.ConsecutivoNueva == 2 ? "03" : string.Empty;
                    obeConfiguracionProgramaNuevas = GetDespuesPrimerPedido(usuario.PaisID, obeConfiguracionProgramaNuevas);
                }
            }
            else obeConfiguracionProgramaNuevas = GetPrimerPedido(usuario.PaisID, obeConfiguracionProgramaNuevas);

            return obeConfiguracionProgramaNuevas ?? new BEConfiguracionProgramaNuevas();
        }

        private BEConfiguracionProgramaNuevas GetPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            //if (!new BLPais().EsPaisHana(paisID))
            //{
                using (var reader = new DAConfiguracionProgramaNuevas(paisID).GetConfiguracionProgramaNuevas(entidad))
                {
                    return reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
                }
            //}
            //else
            //{
            //    return new DAHConfiguracionProgramaNuevas().GetConfiguracionProgramaNuevas(paisID, entidad);
            //}
        }

        private BEConfiguracionProgramaNuevas GetDespuesPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            using (var reader = new DAConfiguracionProgramaNuevas(paisID).GetConfiguracionProgramaDespuesPrimerPedido(entidad))
            {
                return reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
            }
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