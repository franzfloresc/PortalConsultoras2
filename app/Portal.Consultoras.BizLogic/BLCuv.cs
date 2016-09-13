using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuv
    {
        #region CUV_Automatico

        public void InsCuvAutomatico(int paisID, IList<BECUVAutomatico> cuvautomatico)
        {
            try
            {
                var DAproductofaltante = new DACuv(paisID);
                DAproductofaltante.InsCuvAutomatico(cuvautomatico);

            }
            catch (Exception) { throw; }
        }
        public IList<BECUVAutomatico> GetProductoCuvAutomatico(int paisID, BECUVAutomatico cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            var productos = new List<BECUVAutomatico>();
            var DAproductofaltante = new DACuv(paisID);

            using (IDataReader reader = DAproductofaltante.GetProductoCuvAutomatico(cuvautomatico, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina))
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
            var DACUV = new DACuv(paisID);
            DACUV.DelCUVAutomatico(cuvautomatico, out deleted);
            return deleted;
        }
        public int GetProductoCUVsAutomaticosToInsert(BEPedidoWeb pedidoweb)
        {
            var oDACUV = new DACuv(pedidoweb.PaisID);
            try
            {
                return oDACUV.GetProductoCUVsAutomaticosToInsert(pedidoweb);
            }
            catch (Exception) { throw; }
        }

        #endregion

        #region Oferta_FIC
        public int GetOfertaFICToInsert(BEPedidoWeb pedidoweb)
        {
            var oDACUV = new DACuv(pedidoweb.PaisID);
            try
            {
                return oDACUV.GetOfertaFICToInsert(pedidoweb);
            }
            catch (Exception) { throw; }
        }
        public void InsOfertaFIC(int paisID, IList<BEOfertaFIC> ofertaFIC)
        {
            try
            {
                var DAproductofaltante = new DACuv(paisID);
                DAproductofaltante.InsOfertaFIC(ofertaFIC);

            }
            catch (Exception) { throw; }
        }
        public IList<BEOfertaFIC> GetProductoOfertaFIC(int paisID, BEOfertaFIC cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            var productos = new List<BEOfertaFIC>();
            var DAproductofaltante = new DACuv(paisID);

            using (IDataReader reader = DAproductofaltante.GetProductoOfertaFIC(cuvautomatico, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina))
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
            var DACUV = new DACuv(paisID);

            DACUV.DelOfertaFIC(cuvautomatico, out deleted);
            return deleted;
        }
        #endregion
    }
}
