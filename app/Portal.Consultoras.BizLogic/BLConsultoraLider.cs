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
    public class BLConsultoraLider
    {
        //2397 CampaniaLider - Codigo(i = 0)
        public IList<string> GetLiderCampaniaActual(int paisID, long ConsultoraID, string CodigoPais)
        {
            List<string> Datos = new List<string>();
            var DAConsultora = new DAConsultoraLiderODS(paisID);

            using (IDataReader reader = DAConsultora.GetLiderCampaniaActual(ConsultoraID, CodigoPais))
                while (reader.Read())
                {
                    int i = 0;
                    Datos.Add(reader.GetValue(i).ToString());
                    i++;
                }
            if (Datos.Count < 1) Datos.Add("");
            return Datos;
        }

        //2397 ProyectaNivel  - FlgProyecta(i = 0)
        public IList<string> GetProyectaNivel(int paisID, long ConsultoraID)
        {
            List<string> Datos = new List<string>();
            var DAConsultora = new DAConsultoraLider(paisID);

            using (IDataReader reader = DAConsultora.GetFlgProyecta(ConsultoraID))
                while (reader.Read())
                {
                    int i = 0;
                    Datos.Add(reader.GetValue(i).ToString());
                    i++;
                }
            if (Datos.Count < 1) Datos.Add("");
            return Datos;
        }

        public DataSet ObtenerParametrosSuperateLider(int paisID, long ConsultoraID, int CampaniaVenta)
        {
            var DAConsultoraLider = new DAConsultoraLider(paisID);
            return DAConsultoraLider.ObtenerParametrosSuperateLider(ConsultoraID, CampaniaVenta);
        }
    }
}
