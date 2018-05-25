using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPais : IConfiguracionPaisBusinessLogic
    {
        public List<BEConfiguracionPais> GetList(BEConfiguracionPais entidad)
        {
            var lista = new List<BEConfiguracionPais>();

            try
            {
                using (var reader = new DAConfiguracionPais(entidad.Detalle.PaisID).GetList(entidad))
                {
                    lista = reader.MapToCollection<BEConfiguracionPais>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.Detalle.PaisID.ToString());
            }

            return lista;
        }

        public BEConfiguracionPais Get(int paisId, int configuracionPaisId)
        {
            var configuracionPais = new BEConfiguracionPais();

            try
            {
                var da = new DAConfiguracionPais(paisId);
                using (IDataReader reader = da.Get(configuracionPaisId))
                {
                    configuracionPais = reader.MapToObject<BEConfiguracionPais>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
            }

            return configuracionPais;
        }

        public BEConfiguracionPais Get(int paisId, string codigo)
        {
            var configuracionPais = new BEConfiguracionPais();

            try
            {
                var da = new DAConfiguracionPais(paisId);
                using (IDataReader reader = da.Get(codigo))
                {
                    configuracionPais = reader.MapToObject<BEConfiguracionPais>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
            }

            return configuracionPais;
        }

        public List<BEConfiguracionPais> GetList(int paisId, bool tienePerfil)
        {
            var lista = new List<BEConfiguracionPais>();

            try
            {
                var da = new DAConfiguracionPais(paisId);
                using (IDataReader reader = da.GetList(tienePerfil))
                {
                    lista = reader.MapToCollection<BEConfiguracionPais>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
            }

            return lista;
        }

        public void Update(BEConfiguracionPais entidad)
        {
            var dAConfiguracionPais = new DAConfiguracionPais(entidad.PaisID);
            dAConfiguracionPais.Update(entidad);
        }
    }
}