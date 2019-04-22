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
    public class BLContenidoApp
    {

        private readonly DAContenidoApp DAContenidoApp;

        public BLContenidoApp()
        {
            DAContenidoApp = new DAContenidoApp();
        }

        public BEContenidoApp Get(string Codigo)
        {
            var contenidoApp = new BEContenidoApp();

            try
            {
                var da = new DAContenidoApp();
                    
                var task1 = Task.Run(() =>
                {
                    var entidad = new BEContenidoApp();
                    using (var reader = da.Get(Codigo))
                    {
                        if (reader.Read()) {
                            entidad = new BEContenidoApp(reader);
                        } 
                    }
                    return entidad;
                });
                
                contenidoApp = task1.Result;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, Codigo.ToString());
            }

            return contenidoApp;
        }

        public void UpdateContenidoApp(BEContenidoApp p)
        {
            DAContenidoApp.UpdContenidoApp(p);
            //CacheManager<BEFormularioDato>.RemoveData(formularioDato.PaisID, ECacheItem.FormularioDatos);
        }


        public List<BEContenidoAppList> GetList(BEContenidoAppList entidad)
        {
            List<BEContenidoAppList> lista;

            try
            {
                var da = new DAContenidoApp();
                using (var reader = da.GetList(entidad))
                {
                    lista = reader.MapToCollection<BEContenidoAppList>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
                lista = new List<BEContenidoAppList>();
            }
            return lista;
        }

        public void InsertContenidoAppDeta(BEContenidoAppDeta p)
        {
            DAContenidoApp.InsertContenidoAppDeta(p);
            //CacheManager<BEFormularioDato>.RemoveData(formularioDato.PaisID, ECacheItem.FormularioDatos);
        }

        public int UpdateContenidoAppDeta(BEContenidoAppDeta p)
        {
           return DAContenidoApp.UpdContenidoAppDeta(p);
            //CacheManager<BEFormularioDato>.RemoveData(formularioDato.PaisID, ECacheItem.FormularioDatos);
        }
    }
}