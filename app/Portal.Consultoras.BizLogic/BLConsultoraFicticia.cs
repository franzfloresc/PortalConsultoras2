using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraFicticia
    {
        public int InsConsultoraFicticia(BEConsultoraFicticia BEConsultoraFicticia)
        {
            var daConsultoraFicticia = new DAConsultoraFicticia(BEConsultoraFicticia.PaisID);
            return daConsultoraFicticia.InsConsultoraFicticia(BEConsultoraFicticia);
        }

        public IList<BEConsultoraFicticia> SelectConsultoraFicticia(int paisID, string CodigoUsuario, string NombreCompleto)
        {
            List<BEConsultoraFicticia> consultorasFicticias = new List<BEConsultoraFicticia>();

            var daConsultoraFicticia = new DAConsultoraFicticia(paisID);
            using (IDataReader reader = daConsultoraFicticia.GetConsultoraFicticia(paisID, CodigoUsuario, NombreCompleto))
                while (reader.Read())
                {
                    consultorasFicticias.Add(new BEConsultoraFicticia(reader));
                }
            return consultorasFicticias;
        }

        public int DelConsultoraFicticia(int paisID, string CodigoConsultora)
        {
            var daConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return daConsultoraFicticia.DelConsultoraFicticia(CodigoConsultora);
        }

        public int UpdConsultoraFicticia(string CodigoUsuario, string CodigoConsultora, int paisID, Int64 ConsultoraID, string Clave)
        {
            var daConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return daConsultoraFicticia.UpdConsultoraFicticia(CodigoUsuario, CodigoConsultora, ConsultoraID, Clave);
        }

        public string GetCodigoConsultoraAsociada(int paisID, string CodigoUsuario)
        {
            var daConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return daConsultoraFicticia.GetCodigoConsultoraAsociada(CodigoUsuario);
        }

        public string GetNombreConsultoraAsociada(int paisID, string CodigoUsuario)
        {
            var daConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return daConsultoraFicticia.GetNombreConsultoraAsociada(CodigoUsuario);
        }
    }
}