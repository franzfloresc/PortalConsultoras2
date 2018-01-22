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
    public class BLBannerPedido
    {
        public IList<BEBannerPedido> SelectBannerPedido(int paisID, int campaniaID)
        {
            var lista = new List<BEBannerPedido>();
            var DABannerPedido = new DABannerPedido(paisID);

            using (IDataReader reader = DABannerPedido.SelectBannerPedido(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEBannerPedido(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsertBannerPedido(BEBannerPedido entidad)
        {
            var DABannerPedido = new DABannerPedido(entidad.PaisID);
            DABannerPedido.Insert(entidad);
        }

        public void UpdateBannerPedido(BEBannerPedido entidad)
        {
            var DABannerPedido = new DABannerPedido(entidad.PaisID);
            DABannerPedido.Update(entidad);
        }

        public void DeleteBannerPedido(int paisID, int BannerPedidoID)
        {
            var DABannerPedido = new DABannerPedido(paisID);
            DABannerPedido.Delete(BannerPedidoID);
        }
    }
}
