using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLBelcorpNoticia
    {
        public IList<BEBelcorpNoticia> SelectBelcorpNoticias(int paisID, int campaniaID)
        {
            var lista = new List<BEBelcorpNoticia>();
            var daBelcorpNoticia = new DABelcorpNoticia(paisID);

            using (IDataReader reader = daBelcorpNoticia.SelectBelcorpNoticia(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEBelcorpNoticia(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public BEBelcorpNoticia GetBelcorpNoticiaById(int paisID, int BelcorpNoticiaID)
        {
            var entidad = new BEBelcorpNoticia();
            var daBelcorpNoticia = new DABelcorpNoticia(paisID);

            using (IDataReader reader = daBelcorpNoticia.GetBelcorpNoticiaById(BelcorpNoticiaID))
            if (reader.Read())
            {
                entidad = new BEBelcorpNoticia(reader);
            }

            return entidad;
        }

        public void InsertBelcorpNoticia(BEBelcorpNoticia entidad)
        {
            var daBelcorpNoticia = new DABelcorpNoticia(entidad.PaisID);
            daBelcorpNoticia.Insert(entidad);
        }

        public void UpdateBelcorpNoticia(BEBelcorpNoticia entidad)
        {
            var daBelcorpNoticia = new DABelcorpNoticia(entidad.PaisID);
            daBelcorpNoticia.Update(entidad);
        }

        public void DeleteBelcorpNoticia(int paisID, int BEBelcorpNoticiaID)
        {
            var daBelcorpNoticia = new DABelcorpNoticia(paisID);
            daBelcorpNoticia.Delete(BEBelcorpNoticiaID);
        }
    }
}
