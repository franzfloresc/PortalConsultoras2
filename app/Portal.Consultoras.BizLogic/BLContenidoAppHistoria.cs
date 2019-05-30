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

        public BEContenidoAppHistoria Get(int paisID, string Codigo)
        {
            var contenidoApp = new BEContenidoAppHistoria();

            try
            {
                var da = new DAContenidoApp(paisID);
                    
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

        public void UpdateContenidoApp(int paisID, BEContenidoAppHistoria p)
        {
            var da = new DAContenidoApp(paisID);
            da.UpdContenidoApp(p);
        }


        public List<BEContenidoAppList> GetList(int paisID, BEContenidoAppList entidad)
        {
            List<BEContenidoAppList> lista;

            try
            {
                var da = new DAContenidoApp(paisID);
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

        public void InsertContenidoAppDeta(int paisID, BEContenidoAppDeta p)
        {
            var da = new DAContenidoApp(paisID);
            da.InsertContenidoAppDeta(p);
        }

        public int UpdateContenidoAppDeta(int paisID, BEContenidoAppDeta p)
        {
            var da = new DAContenidoApp(paisID);
            return da.UpdContenidoAppDeta(p);
        }

        public List<BEContenidoAppDetaAct> GetContenidoAppDetaActList(int paisID)
        {
            List<BEContenidoAppDetaAct> lista;

            try
            {
                var da = new DAContenidoApp(paisID);
                using (var reader = da.GetContenidoAppDetaActList())
                {
                    lista = reader.MapToCollection<BEContenidoAppDetaAct>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", "");
                lista = new List<BEContenidoAppDetaAct>();
            }
            return lista;
        }
    }
}