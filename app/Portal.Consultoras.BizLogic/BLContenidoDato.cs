using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLContenidoDato
    {
        public void InsContenidoDato(BEContenidoDato contenidodato)
        {
            var daContenidoDato = new DAContenidoDato();
            daContenidoDato.InsContenidoDato(contenidodato);
        }

        public void UpdContenidoDato(BEContenidoDato contenidodato)
        {
            var daContenidoDato = new DAContenidoDato();
            daContenidoDato.UpdContenidoDato(contenidodato);
        }

        public IList<BEContenidoDato> SelectContenidoDato(int paisID, int campaniaID)
        {
            var contenidodatos = new List<BEContenidoDato>();
            var daContenidoDato = new DAContenidoDato();

            using (IDataReader reader = daContenidoDato.GetContenidoDato(paisID, campaniaID))
                while (reader.Read())
                {
                    var contenidodato = new BEContenidoDato(reader) { PaisID = paisID };
                    contenidodatos.Add(contenidodato);
                }

            return contenidodatos;
        }

        public IList<BETipoLink> GetLinksPorPais(int paisID)
        {
            var contenidodatos = new List<BETipoLink>();
            var daContenidoDato = new DAContenidoDato();

            using (IDataReader reader = daContenidoDato.GetLinksPorPais(paisID))
                while (reader.Read())
                {
                    var contenidodato = new BETipoLink(reader) { PaisID = paisID };
                    contenidodatos.Add(contenidodato);
                }

            return contenidodatos;
        }
    }
}