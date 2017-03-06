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
    public class BLConsultoraFicticia
    {
        public int InsConsultoraFicticia(BEConsultoraFicticia BEConsultoraFicticia)
        {
            var DAConsultoraFicticia = new DAConsultoraFicticia(BEConsultoraFicticia.PaisID);
            return DAConsultoraFicticia.InsConsultoraFicticia(BEConsultoraFicticia);
        }

        public IList<BEConsultoraFicticia> SelectConsultoraFicticia(int paisID, string CodigoUsuario, string NombreCompleto)
        {
            List<BEConsultoraFicticia> consultorasFicticias = new List<BEConsultoraFicticia>();

            var DAConsultoraFicticia = new DAConsultoraFicticia(paisID);
            using (IDataReader reader = DAConsultoraFicticia.GetConsultoraFicticia(paisID, CodigoUsuario, NombreCompleto))
                while (reader.Read())
                {
                    consultorasFicticias.Add(new BEConsultoraFicticia(reader));
                }
            return consultorasFicticias;
        }

        public int DelConsultoraFicticia(int paisID, string CodigoConsultora)
        { 
            var DAConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return DAConsultoraFicticia.DelConsultoraFicticia(CodigoConsultora);
        }

        public int UpdConsultoraFicticia(string CodigoUsuario, string CodigoConsultora, int paisID, Int64 ConsultoraID, string Clave)
        { 
            var DAConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return DAConsultoraFicticia.UpdConsultoraFicticia(CodigoUsuario, CodigoConsultora, ConsultoraID, Clave);
        }

        public string GetCodigoConsultoraAsociada(int paisID, string CodigoUsuario)
        {
            var DAConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return DAConsultoraFicticia.GetCodigoConsultoraAsociada(CodigoUsuario);
        }

        public string GetNombreConsultoraAsociada(int paisID, string CodigoUsuario)
        {
            var DAConsultoraFicticia = new DAConsultoraFicticia(paisID);
            return DAConsultoraFicticia.GetNombreConsultoraAsociada(CodigoUsuario);
        }
    }
}
