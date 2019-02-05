using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLBelcorpResponde : IBelcorpRespondeBusinessLogic
    {
        public IList<BEBelcorpResponde> GetBelcorpResponde(int paisID)
        {
            IList<BEBelcorpResponde> lista = (IList<BEBelcorpResponde>)CacheManager<BEBelcorpResponde>.GetData(paisID, ECacheItem.BelcorpResponde);
            if (lista == null)
            {
                lista = new List<BEBelcorpResponde>();
                var daBelcorpResponde = new DABelcorpResponde();

                using (IDataReader reader = daBelcorpResponde.GetBelcorpResponde(paisID))
                    while (reader.Read())
                    {
                        var entidad = new BEBelcorpResponde(reader);
                        lista.Add(entidad);
                    }
                CacheManager<BEBelcorpResponde>.AddData(paisID, ECacheItem.BelcorpResponde, lista);
            }
            return lista;
        }

        public IList<BEBelcorpResponde> GetBelcorpRespondeAdministrador(int paisID)
        {
            var lista = new List<BEBelcorpResponde>();
            var daBelcorpResponde = new DABelcorpResponde();

            using (IDataReader reader = daBelcorpResponde.GetBelcorpResponde(paisID))
                while (reader.Read())
                {
                    var entidad = new BEBelcorpResponde(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsBelcorpResponde(BEBelcorpResponde BEBelcorpResponde)
        {
            var daBelcorpResponde = new DABelcorpResponde();
            daBelcorpResponde.InsBelcorpResponde(BEBelcorpResponde);

            CacheManager<BEBelcorpResponde>.RemoveData(BEBelcorpResponde.PaisID, ECacheItem.BelcorpResponde);
        }

        public void DeleteBelcorpRespondeCache(int paisID)
        {
            CacheManager<BEBelcorpResponde>.RemoveData(paisID, ECacheItem.BelcorpResponde);
        }

        #region Gestor de Poputs
        public List<BEComunicado> GetListaPoput(int estado, string campania)
        {
            campania = null;
            List<BEComunicado> listsBEComunicado = new List<BEComunicado>();

            var daBelcorpResponde = new DABelcorpResponde();

            using (IDataReader reader = daBelcorpResponde.GetListaPoput(estado, campania))
            {
                while (reader.Read())
                {
                    listsBEComunicado.Add(new BEComunicado()
                    {
                        Numero = reader[0] == DBNull.Value ? 0 : int.Parse(reader[0].ToString()),
                        UrlImagen = reader[1] == null ? string.Empty : reader[1].ToString(),
                        FechaInicio = reader[2] == null ? string.Empty : reader[2].ToString(),
                        FechaFin = reader[3] == null ? string.Empty : reader[3].ToString(),
                        Titulo =reader[4] == null ? string.Empty : reader[4].ToString(),
                        DescripcionAccion = reader[5] == null ? string.Empty : reader[5].ToString(),
                        Activo = Convert.ToBoolean( reader[6]),
                    });
                }

            }
            return listsBEComunicado;
        }
        #endregion
    }
}
