using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.AsesoraOnline;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLAsesoraOnline
    {
        public int EnviarFormulario(string paisISO, BEAsesoraOnline entidad)
        {
            int paisID = GetPaisID(paisISO);
            var DAAsesoraOnline = new DAAsesoraOnline(paisID);
            return DAAsesoraOnline.EnviarFormulario(entidad);
        }

        public int GetPaisID(string ISO)
        {
            List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
            {
                new KeyValuePair<string, string>("1", "AR"),
                new KeyValuePair<string, string>("2", "BO"),
                new KeyValuePair<string, string>("3", "CL"),
                new KeyValuePair<string, string>("4", "CO"),
                new KeyValuePair<string, string>("5", "CR"),
                new KeyValuePair<string, string>("6", "EC"),
                new KeyValuePair<string, string>("7", "SV"),
                new KeyValuePair<string, string>("8", "GT"),
                new KeyValuePair<string, string>("9", "MX"),
                new KeyValuePair<string, string>("10", "PA"),
                new KeyValuePair<string, string>("11", "PE"),
                new KeyValuePair<string, string>("12", "PR"),
                new KeyValuePair<string, string>("13", "DO"),
                new KeyValuePair<string, string>("14", "VE"),
            };
            string paisID = "0";
            try
            {
                paisID = (from c in listaPaises
                          where c.Value == ISO.ToUpper()
                          select c.Key).SingleOrDefault();
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }
            if (paisID != null)
            {
                return int.Parse(paisID);
            }
            else return 0;
        }
    }
}
