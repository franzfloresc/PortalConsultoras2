using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuv
    {
        #region CUV_Automatico

        public void InsCuvAutomatico(int paisID, IList<BECUVAutomatico> cuvautomatico)
        {
            var daProductoFaltante = new DACuv(paisID);
            daProductoFaltante.InsCuvAutomatico(cuvautomatico);
        }

        public IList<BECUVAutomatico> GetProductoCuvAutomatico(int paisID, BECUVAutomatico cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            var productos = new List<BECUVAutomatico>();
            var daProductoFaltante = new DACuv(paisID);

            using (IDataReader reader = daProductoFaltante.GetProductoCuvAutomatico(cuvautomatico, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina))
                while (reader.Read())
                {
                    var prodfal = new BECUVAutomatico(reader);
                    productos.Add(prodfal);
                }

            return productos;
        }

        public bool DelCUVAutomatico(int paisID, BECUVAutomatico cuvautomatico)
        {
            bool deleted;
            var daCuv = new DACuv(paisID);
            daCuv.DelCUVAutomatico(cuvautomatico, out deleted);
            return deleted;
        }

        public int GetProductoCUVsAutomaticosToInsert(BEPedidoWeb pedidoweb)
        {
            var daCuv = new DACuv(pedidoweb.PaisID);
            return daCuv.GetProductoCUVsAutomaticosToInsert(pedidoweb);
        }

        #endregion

        #region Oferta_FIC
        public int GetOfertaFICToInsert(BEPedidoWeb pedidoweb)
        {
            var daCuv = new DACuv(pedidoweb.PaisID);
            return daCuv.GetOfertaFICToInsert(pedidoweb);
        }

        public void InsOfertaFIC(int paisID, IList<BEOfertaFIC> ofertaFIC)
        {
            var daProductoFaltante = new DACuv(paisID);
            daProductoFaltante.InsOfertaFIC(ofertaFIC);
        }

        public IList<BEOfertaFIC> GetProductoOfertaFIC(int paisID, BEOfertaFIC cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            var productos = new List<BEOfertaFIC>();
            var daProductoFaltante = new DACuv(paisID);

            using (IDataReader reader = daProductoFaltante.GetProductoOfertaFIC(cuvautomatico, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina))
                while (reader.Read())
                {
                    var prodfal = new BEOfertaFIC(reader);
                    productos.Add(prodfal);
                }

            return productos;
        }

        public bool DelOfertaFIC(int paisID, BEOfertaFIC cuvautomatico)
        {
            bool deleted;
            var daCuv = new DACuv(paisID);

            daCuv.DelOfertaFIC(cuvautomatico, out deleted);
            return deleted;
        }
        #endregion
    }
}
