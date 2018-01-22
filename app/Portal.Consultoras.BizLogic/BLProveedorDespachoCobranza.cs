using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLProveedorDespachoCobranza
    {
        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranza(int paisID)
        {
            var lista = new List<BEProveedorDespachoCobranza>();
            var daProveedor = new DAProveedorDespachoCobranza(paisID);

            using (IDataReader reader = daProveedor.GetProveedorDespachoCobranza())
            {
                while (reader.Read())
                {
                    var entidad = new BEProveedorDespachoCobranza(reader);
                    lista.Add(entidad);
                }
            }
            return lista.ToList();
        }

        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranzaMnto(int paisID, BEProveedorDespachoCobranza entidad)
        {
            var lista = new List<BEProveedorDespachoCobranza>();
            var daProveedor = new DAProveedorDespachoCobranza(paisID);

            using (IDataReader reader = daProveedor.GetProveedorDespachoCobranzaMnto(entidad))
            {
                while (reader.Read())
                {
                    var entity = new BEProveedorDespachoCobranza(reader);
                    lista.Add(entity);
                }
            }
            return lista.ToList();
        }

        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranzaBYiD(int paisID, BEProveedorDespachoCobranza entity)
        {
            var lista = new List<BEProveedorDespachoCobranza>();
            var daProveedor = new DAProveedorDespachoCobranza(paisID);

            using (IDataReader reader = daProveedor.GetProveedorDespachoCobranzaBYiD(entity))
            {
                while (reader.Read())
                {
                    var entidad = new BEProveedorDespachoCobranza(reader);
                    lista.Add(entidad);
                }

                CacheManager<BEProveedorDespachoCobranza>.AddData(paisID, ECacheItem.ProveedorDespachoCobranza, lista);
            }

            return lista.ToList();
        }


        public int DelProveedorDespachoCobranza(int paisID, int ProveedorDespachoCobanzaID)
        {
            var daProveedor = new DAProveedorDespachoCobranza(paisID);
            return daProveedor.DelProveedorDespachoCobranza(ProveedorDespachoCobanzaID);
        }


        public void UpdProveedorDespachoCobranzaCabecera(int paisID, BEProveedorDespachoCobranza entidad)
        {
            var daProveedorDespacho = new DAProveedorDespachoCobranza(entidad.PaisID);
            daProveedorDespacho.UpdProveedorDespachoCobranzaCabecera(entidad);
        }

        public int InsDespachoCobranzaCabecera(BEProveedorDespachoCobranza entity)
        {
            var dataAccess = new DAProveedorDespachoCobranza(entity.PaisID);
            return dataAccess.InsDespachoCobranzaCabecera(entity);
        }

        public void MntoCampoProveedorDespachoCobranza(BEProveedorDespachoCobranza entity, int accion, int campoid, string valor, string valorAntiguo)
        {
            var dataAccess = new DAProveedorDespachoCobranza(entity.PaisID);
            dataAccess.MntoCampoProveedorDespachoCobranza(entity, accion, campoid, valor, valorAntiguo);
        }
    }
}
