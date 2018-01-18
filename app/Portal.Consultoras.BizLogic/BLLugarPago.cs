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
    public class BLLugarPago
    {
        public IList<BELugarPago> SelectLugarPago(int paisID)
        {
            var lista = new List<BELugarPago>();
            var DALugarPago = new DALugarPago(paisID);

            using (IDataReader reader = DALugarPago.SelectLugarPago(paisID))
                while (reader.Read())
                {
                    var entidad = new BELugarPago(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public BELugarPago GetLugarPagoById(int paisID, int lugarPagoID)
        {
            var entidad = new BELugarPago();
            var DALugarPago = new DALugarPago(paisID);

            using (IDataReader reader = DALugarPago.GetLugarPagoById(lugarPagoID))
            if (reader.Read())
            {
                entidad = new BELugarPago(reader);
            }

            return entidad;
        }

        public int InsertLugarPago(BELugarPago entidad)
        {
            var DALugarPago = new DALugarPago(entidad.PaisID);
           return Convert.ToInt32(DALugarPago.Insert(entidad));
        }

        public int UpdateLugarPago(BELugarPago entidad)
        {
            var DALugarPago = new DALugarPago(entidad.PaisID);
         return DALugarPago.Update(entidad);
        }

        public void DeleteLugarPago(int paisID, int lugarPagoID)
        {
            var DALugarPago = new DALugarPago(paisID);
            DALugarPago.Delete(lugarPagoID);
        }
    }
}
