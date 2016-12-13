using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLPopupPais
    {
        public List<BEPopupPais> ObtenerOrdenPopUpMostrar(int PaisID)
        {
            List<BEPopupPais> PopUps = new List<BEPopupPais>();
            DAPopupPais DataPopupPais = new DAPopupPais(PaisID);

            using (IDataReader reader = DataPopupPais.ObtenerOrdenPopUpMostrar())
            {
                while (reader.Read())
                {
                    PopUps.Add(new BEPopupPais(reader));
                }
            }
            return PopUps;
        }
    }
}
