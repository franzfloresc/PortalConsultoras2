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
    public class BLContenidoAppHistoria
    {

        private readonly DAContenidoApp DAContenidoApp;

        public BLContenidoAppHistoria()
        {
            DAContenidoApp = new DAContenidoApp();
        }

        public BEContenidoAppHistoria Get(string Codigo)
        {
            var contenidoApp = new BEContenidoAppHistoria();

            try
            {
                var da = new DAContenidoApp();
                    
                var task1 = Task.Run(() =>
                {
                    var entidad = new BEContenidoAppHistoria();
                    using (var reader = da.Get(Codigo))
                    {
                        if (reader.Read()) {
                            entidad = new BEContenidoAppHistoria(reader);
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

        public void UpdateContenidoApp(BEContenidoAppHistoria p)
        {
            DAContenidoApp.UpdContenidoApp(p);
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
        }

        public int UpdateContenidoAppDeta(BEContenidoAppDeta p)
        {
           return DAContenidoApp.UpdContenidoAppDeta(p);
        }
    }
}