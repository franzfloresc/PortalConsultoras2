using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLBannerPedido
    {
        public IList<BEBannerPedido> SelectBannerPedido(int paisID, int campaniaID)
        {
            var lista = new List<BEBannerPedido>();
            var daBannerPedido = new DABannerPedido(paisID);

            using (IDataReader reader = daBannerPedido.SelectBannerPedido(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEBannerPedido(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsertBannerPedido(BEBannerPedido entidad)
        {
            var daBannerPedido = new DABannerPedido(entidad.PaisID);
            daBannerPedido.Insert(entidad);
        }

        public void UpdateBannerPedido(BEBannerPedido entidad)
        {
            var daBannerPedido = new DABannerPedido(entidad.PaisID);
            daBannerPedido.Update(entidad);
        }

        public void DeleteBannerPedido(int paisID, int BannerPedidoID)
        {
            var daBannerPedido = new DABannerPedido(paisID);
            daBannerPedido.Delete(BannerPedidoID);
        }
    }
}
