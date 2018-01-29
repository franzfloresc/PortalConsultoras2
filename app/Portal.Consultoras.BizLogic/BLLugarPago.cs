using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLLugarPago
    {
        public IList<BELugarPago> SelectLugarPago(int paisID)
        {
            var lista = new List<BELugarPago>();
            var daLugarPago = new DALugarPago(paisID);

            using (IDataReader reader = daLugarPago.SelectLugarPago(paisID))
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
            var daLugarPago = new DALugarPago(paisID);

            using (IDataReader reader = daLugarPago.GetLugarPagoById(lugarPagoID))
            if (reader.Read())
            {
                entidad = new BELugarPago(reader);
            }

            return entidad;
        }

        public int InsertLugarPago(BELugarPago entidad)
        {
            var daLugarPago = new DALugarPago(entidad.PaisID);
           return Convert.ToInt32(daLugarPago.Insert(entidad));
        }

        public int UpdateLugarPago(BELugarPago entidad)
        {
            var daLugarPago = new DALugarPago(entidad.PaisID);
         return daLugarPago.Update(entidad);
        }

        public void DeleteLugarPago(int paisID, int lugarPagoID)
        {
            var daLugarPago = new DALugarPago(paisID);
            daLugarPago.Delete(lugarPagoID);
        }
    }
}
