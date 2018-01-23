using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLBelcorpNoticia
    {
        public IList<BEBelcorpNoticia> SelectBelcorpNoticias(int paisID, int campaniaID)
        {
            var lista = new List<BEBelcorpNoticia>();
            var DABelcorpNoticia = new DABelcorpNoticia(paisID);

            using (IDataReader reader = DABelcorpNoticia.SelectBelcorpNoticia(paisID, campaniaID))
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
            var DABelcorpNoticia = new DABelcorpNoticia(paisID);

            using (IDataReader reader = DABelcorpNoticia.GetBelcorpNoticiaById(BelcorpNoticiaID))
            if (reader.Read())
            {
                entidad = new BEBelcorpNoticia(reader);
            }

            return entidad;
        }

        public void InsertBelcorpNoticia(BEBelcorpNoticia entidad)
        {
            var DABelcorpNoticia = new DABelcorpNoticia(entidad.PaisID);
            DABelcorpNoticia.Insert(entidad);
        }

        public void UpdateBelcorpNoticia(BEBelcorpNoticia entidad)
        {
            var DABelcorpNoticia = new DABelcorpNoticia(entidad.PaisID);
            DABelcorpNoticia.Update(entidad);
        }

        public void DeleteBelcorpNoticia(int paisID, int BEBelcorpNoticiaID)
        {
            var DABelcorpNoticia = new DABelcorpNoticia(paisID);
            DABelcorpNoticia.Delete(BEBelcorpNoticiaID);
        }
    }
}
