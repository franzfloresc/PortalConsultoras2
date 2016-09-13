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
    public class BLContenidoDato
    {
        public void InsContenidoDato(BEContenidoDato contenidodato)
        {
            var DAContenidoDato = new DAContenidoDato();
            DAContenidoDato.InsContenidoDato(contenidodato);
        }

        public void UpdContenidoDato(BEContenidoDato contenidodato)
        {
            var DAContenidoDato = new DAContenidoDato();
            DAContenidoDato.UpdContenidoDato(contenidodato);
        }

        public IList<BEContenidoDato> SelectContenidoDato(int paisID, int campaniaID)
        {
            var contenidodatos = new List<BEContenidoDato>();
            var DAContenidoDato = new DAContenidoDato();

            using (IDataReader reader = DAContenidoDato.GetContenidoDato(paisID, campaniaID))
                while (reader.Read())
                {
                    var contenidodato = new BEContenidoDato(reader);
                    contenidodato.PaisID = paisID;
                    contenidodatos.Add(contenidodato);
                }

            return contenidodatos;
        }

        public IList<BETipoLink> GetLinksPorPais(int paisID)
        {
            var contenidodatos = new List<BETipoLink>();
            var DAContenidoDato = new DAContenidoDato();

            using (IDataReader reader = DAContenidoDato.GetLinksPorPais(paisID))
                while (reader.Read())
                {
                    var contenidodato = new BETipoLink(reader);
                    contenidodato.PaisID = paisID;
                    contenidodatos.Add(contenidodato);
                }

            return contenidodatos;
        }
    }
}
