using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLSegmentoPlaneamiento
    {
        public IList<BESegmentoPlaneamiento> GetSegmentoPlaneamiento(int PaisID,int campaniaId)
        {
            var segmentoPlaneamiento = new List<BESegmentoPlaneamiento>();
            var daSegmentoPlaneamiento = new DASegmentoPlaneamiento(PaisID);

            using (IDataReader reader = daSegmentoPlaneamiento.GetSegmentoPlaneamiento(campaniaId))
                while (reader.Read())
                {
                    var entidad = new BESegmentoPlaneamiento(reader) {PaisID = PaisID};
                    segmentoPlaneamiento.Add(entidad);
                }

            return segmentoPlaneamiento;
        }
    }
}
