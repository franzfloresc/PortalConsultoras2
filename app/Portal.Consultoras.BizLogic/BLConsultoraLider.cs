using Portal.Consultoras.Data;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraLider : IConsultoraLiderBusinessLogic
    {
        public IList<string> GetLiderCampaniaActual(int paisID, long ConsultoraID, string CodigoPais)
        {
            List<string> datos = new List<string>();
            var daConsultora = new DAConsultoraLiderODS(paisID);

            using (IDataReader reader = daConsultora.GetLiderCampaniaActual(ConsultoraID, CodigoPais))
                while (reader.Read())
                {
                    datos.Add(reader.GetValue(0).ToString());
                }
            if (datos.Count < 1) datos.Add("");
            return datos;
        }
         
        public IList<string> GetProyectaNivel(int paisID, long ConsultoraID)
        {
            List<string> datos = new List<string>();
            var daConsultora = new DAConsultoraLider(paisID);

            using (IDataReader reader = daConsultora.GetFlgProyecta(ConsultoraID))
                while (reader.Read())
                {
                    datos.Add(reader.GetValue(0).ToString());
                }
            if (datos.Count < 1) datos.Add("");
            return datos;
        }

        public DataSet ObtenerParametrosSuperateLider(int paisID, long ConsultoraID, int CampaniaVenta)
        {
            var daConsultoraLider = new DAConsultoraLider(paisID);
            return daConsultoraLider.ObtenerParametrosSuperateLider(ConsultoraID, CampaniaVenta);
        }
    }
}
