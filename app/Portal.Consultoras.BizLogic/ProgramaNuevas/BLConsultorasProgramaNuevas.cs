using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultorasProgramaNuevas : IConsultorasProgramaNuevasBusinessLogic
    {
        public BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(int paisID, BEConsultorasProgramaNuevas entidad)
        {
            BEConsultorasProgramaNuevas data = null;
            var da = new DAConsultorasProgramaNuevas(paisID);
            using (IDataReader reader = da.GetConsultorasProgramaNuevas(entidad))
                if (reader.Read())
                    data = new BEConsultorasProgramaNuevas(reader);

            return data;
        }
    }
}
