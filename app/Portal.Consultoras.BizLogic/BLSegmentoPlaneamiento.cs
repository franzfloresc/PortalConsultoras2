using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLSegmentoPlaneamiento
    {
        public IList<BESegmentoPlaneamiento> GetSegmentoPlaneamiento(int PaisID,int campaniaId)
        {
            var segmentoPlaneamiento = new List<BESegmentoPlaneamiento>();
            var DASegmentoPlaneamiento = new DASegmentoPlaneamiento(PaisID);

            using (IDataReader reader = DASegmentoPlaneamiento.GetSegmentoPlaneamiento(campaniaId))
                while (reader.Read())
                {
                    var entidad = new BESegmentoPlaneamiento(reader);
                    entidad.PaisID = PaisID;
                    segmentoPlaneamiento.Add(entidad);
                }

            return segmentoPlaneamiento;
        }
    }
}
