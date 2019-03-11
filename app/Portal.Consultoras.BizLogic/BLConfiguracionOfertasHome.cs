using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Oferta;

using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;
using System.Threading.Tasks;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionOfertasHome
    {
        private readonly IConfiguracionPaisDatosBusinessLogic _configuracionPaisDatosBusinessLogic;

        public BLConfiguracionOfertasHome() : this(new BLConfiguracionPaisDatos())
        { }

        public BLConfiguracionOfertasHome(IConfiguracionPaisDatosBusinessLogic configuracionPaisDatosBusinessLogic)
        {
            _configuracionPaisDatosBusinessLogic = configuracionPaisDatosBusinessLogic;
        }

        public BEConfiguracionOfertasHome Get(int paisId, int configuracionOfertasHomeId)
        {
            var configuracionOfertasHome = new BEConfiguracionOfertasHome();

            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);

                var task1 = Task.Run(() =>
                {
                    var entidad = new BEConfiguracionOfertasHome();
                    using (var reader = da.Get(configuracionOfertasHomeId))
                    {
                        if (reader.Read()) entidad = new BEConfiguracionOfertasHome(reader);
                    }
                    return entidad;
                });

                var task2 = Task.Run(() =>
                {
                    using (var reader = da.GetApp(configuracionOfertasHomeId))
                    {
                        return reader.MapToObject<BEConfiguracionOfertasHomeApp>();
                    }
                });
                
                Task.WaitAll(task1, task2);

                configuracionOfertasHome = task1.Result;
                configuracionOfertasHome.ConfiguracionOfertasHomeApp = task2.Result;
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

        public IList<BEConfiguracionOfertasHomeApp> GetListarSeccionAPP(int paisId, int campaniaId)
        {
           
            try
            {
                var da = new DAConfiguracionOfertasHome(paisId);
                using (IDataReader reader = da.GetListarSeccionAPP(campaniaId))
                {
                    return  reader.MapToCollection<BEConfiguracionOfertasHomeApp>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
                return new List<BEConfiguracionOfertasHomeApp>();
            }

        }

    }
}