using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Oferta;

using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionOfertasHome
    {
        public BEConfiguracionOfertasHome Get(int paisId, int configuracionOfertasHomeId)
        {
            var configuracionOfertasHome = new BEConfiguracionOfertasHome();

            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                using (var reader = da.Get(configuracionOfertasHomeId))
                {
                    if (reader.Read()) configuracionOfertasHome = new BEConfiguracionOfertasHome(reader);
                }
                using (var reader = da.GetApp(configuracionOfertasHomeId))
                {
                    configuracionOfertasHome.ConfiguracionOfertasHomeApp = reader.MapToObject<BEConfiguracionOfertasHomeApp>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisId.ToString());
            }

            return configuracionOfertasHome;
        }

        public List<BEConfiguracionOfertasHome> GetList(int paisId, int campaniaId)
        {
            var lista = new List<BEConfiguracionOfertasHome>();
            var blConfiguracionPais = new BLConfiguracionPais();
            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                using (IDataReader reader = da.GetList(campaniaId))
                {
                    while (reader.Read())
                    {
                        var ofertaHome = new BEConfiguracionOfertasHome(reader);
                        ofertaHome.ConfiguracionPais = blConfiguracionPais.Get(paisId, ofertaHome.ConfiguracionPaisID);
                        lista.Add(ofertaHome);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
                lista = new List<BEConfiguracionOfertasHome>();
            }
            return lista;
        }

        public void Update(BEConfiguracionOfertasHome entidad)
        {
            var oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            using (var oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                var dAConfiguracionOfertasHome = new DAConfiguracionOfertasHome(entidad.PaisID);
                var configuracionOfertasHomeID = dAConfiguracionOfertasHome.Update(entidad);
                entidad.ConfiguracionOfertasHomeApp.ConfiguracionOfertasHomeID = configuracionOfertasHomeID;
                dAConfiguracionOfertasHome.InsertApp(entidad.ConfiguracionOfertasHomeApp);
                CacheManager<BEConfiguracionOfertasHome>.RemoveData(entidad.PaisID, ECacheItem.SeccionConfiguracionOfertasHome, entidad.CampaniaID.ToString());
                oTransactionScope.Complete();
            }
        }

        public IList<BEConfiguracionOfertasHome> GetListarSeccion(int paisId, int campaniaId)
        {
            IList<BEConfiguracionOfertasHome> lista;
            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                lista = new List<BEConfiguracionOfertasHome>();
                using (IDataReader reader = da.GetListarSeccion(campaniaId))
                {
                    while (reader.Read())
                    {
                        var ofertaHome = new BEConfiguracionOfertasHome(reader);
                        lista.Add(ofertaHome);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
                lista = new List<BEConfiguracionOfertasHome>();
            }
            
            return lista;
        }

        public IList<BEConfiguracionOfertasApp> GetListarSeccionAPP(int paisId, int campaniaId)
        {
            IList<BEConfiguracionOfertasApp> lista;
            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                lista = new List<BEConfiguracionOfertasApp>();
                using (IDataReader reader = da.GetListarSeccionAPP(campaniaId))
                {
                    while (reader.Read())
                    {
                        var configApp = new BEConfiguracionOfertasApp(reader);
                        lista.Add(configApp);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
                lista = new List<BEConfiguracionOfertasApp>();
            }

            return lista;
        }

    }
}