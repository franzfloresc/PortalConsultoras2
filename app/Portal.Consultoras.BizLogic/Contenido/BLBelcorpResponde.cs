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
            List<BEComunicado> listsBEComunicado = new List<BEComunicado>();

            var daBelcorpResponde = new DABelcorpResponde();

            using (IDataReader reader = daBelcorpResponde.GetListaPoput(estado, campania))
            {
                while (reader.Read())
                {
                    listsBEComunicado.Add(new BEComunicado()
                    {
                        Numero = reader[0] == DBNull.Value ? 0 : int.Parse(reader[0].ToString()),
                        ComunicadoId = reader[1] == DBNull.Value ? 0 : int.Parse(reader[1].ToString()),
                        UrlImagen = reader[2] == null ? string.Empty : reader[2].ToString(),
                        FechaInicio = reader[3] == null ? string.Empty : reader[3].ToString(),
                        FechaFin = reader[4] == null ? string.Empty : reader[4].ToString(),
                        Titulo =reader[5] == null ? string.Empty : reader[5].ToString(),
                        DescripcionAccion = reader[6] == null ? string.Empty : reader[6].ToString(),
                        Activo = Convert.ToBoolean( reader[7]),
                    });
                }

            }
            return listsBEComunicado;
        }

        public BEComunicado GetDetallePoput(int comunicadoid)
        {
         BEComunicado objetoBEComunicado = new BEComunicado();

            var daBelcorpResponde = new DABelcorpResponde();

            using (IDataReader reader = daBelcorpResponde.GetDetallePoput(comunicadoid))
            {
                while (reader.Read())
                {
                    objetoBEComunicado.ComunicadoId = reader[0] == DBNull.Value ? 0 : int.Parse(reader[0].ToString());
                    objetoBEComunicado.Descripcion = reader[1] == null ? string.Empty : reader[1].ToString();
                    objetoBEComunicado.Activo = Convert.ToBoolean(reader[2]);
                    objetoBEComunicado.DescripcionAccion = reader[3] == null ? string.Empty : reader[3].ToString();
                    objetoBEComunicado.SegmentacionID = reader[4] == DBNull.Value ? 0 : int.Parse(reader[4].ToString());
                    objetoBEComunicado.UrlImagen = reader[5] == null ? string.Empty : reader[5].ToString();
                    objetoBEComunicado.Orden = reader[6] == DBNull.Value ? 0 : int.Parse(reader[6].ToString());
                    objetoBEComunicado.NombreArchivoCCV = reader[7] == null ? string.Empty : reader[7].ToString();
                    objetoBEComunicado.FechaInicio = reader[8] == null ? string.Empty : reader[8].ToString();
                    objetoBEComunicado.FechaFin = reader[9] == null ? string.Empty : reader[9].ToString();
                    objetoBEComunicado.TipoDispositivo= reader[10] == DBNull.Value ? 0 : int.Parse(reader[10].ToString());
                }

            }
            return objetoBEComunicado;
        }
        #endregion
    }
}
