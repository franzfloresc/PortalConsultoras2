using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLPopupPais
    {
        public List<BEPopupPais> ObtenerOrdenPopUpMostrar(int PaisID)
        {
            List<BEPopupPais> popUps = new List<BEPopupPais>();
            DAPopupPais dataPopupPais = new DAPopupPais(PaisID);

            using (IDataReader reader = dataPopupPais.ObtenerOrdenPopUpMostrar())
            {
                while (reader.Read())
                {
                    popUps.Add(new BEPopupPais(reader));
                }
            }
            return popUps;
        }
    }
}
