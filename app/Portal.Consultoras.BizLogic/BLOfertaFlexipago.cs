using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLOfertaFlexipago
    {
        public IList<BEOfertaFlexipago> GetProductosByOfertaFlexipago(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta, string CodigoSAP, string CUV, string CategoriaID)
        {
            var lst = new List<BEOfertaFlexipago>();
            var dataAccess = new DAOfertaFlexipago(paisID);

            using (IDataReader reader = dataAccess.GetProductosByOfertaFlexipago(TipoOfertaSisID, CampaniaID, CodigoOferta, CodigoSAP, CUV, CategoriaID))
                while (reader.Read())
                {
                    var entity = new BEOfertaFlexipago(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public int GuardarLinksOfertaFlexipago(BEOfertaFlexipago entidad)
        {
            var dataAccess = new DAOfertaFlexipago(entidad.PaisID);
            return dataAccess.GuardarLinksOfertaFlexipago(entidad);
        }

        public BEOfertaFlexipago GetLinksOfertaFlexipago(int paisID)
        {
            BEOfertaFlexipago entity = new BEOfertaFlexipago();
            var dataAccess = new DAOfertaFlexipago(paisID);

            using (IDataReader reader = dataAccess.GetLinksOfertaFlexipago())
                while (reader.Read())
                {
                    entity = new BEOfertaFlexipago(reader);
                }
            return entity;
        }

        public int UpdOfertaFlexipagoStockMasivo(int paisID, List<BEOfertaFlexipago> stockProductos)
        {
            var dataAccess = new DAOfertaFlexipago(paisID);
            return dataAccess.UpdOfertaFlexipagoStockMasivo(stockProductos);
        }

        public int UpdCategoriaConsultoraMasivo(int paisID, List<BEOfertaFlexipago> stockProductos)
        {
            var dataAccess = new DAOfertaFlexipago(paisID);
            return dataAccess.UpdCategoriaConsultoraMasivo(stockProductos);
        }

        public string GetCategoriaByConsultora(int paisID, int CampaniaID, string CodigoConsultora)
        {
            var dataAccess = new DAOfertaFlexipago(paisID);
            return dataAccess.GetCategoriaByConsultora(CampaniaID, CodigoConsultora);
        }

        public int InsOfertaFlexipago(BEOfertaFlexipago entity)
        {
            var dataAccess = new DAOfertaFlexipago(entity.PaisID);
            return dataAccess.InsOfertaFlexipago(entity);
        }

        public int UpdOfertaFlexipago(BEOfertaFlexipago entity)
        {
            var dataAccess = new DAOfertaFlexipago(entity.PaisID);
            return dataAccess.UpdOfertaFlexipago(entity);
        }

        public int DelOfertaFlexipago(BEOfertaFlexipago entity)
        {
            var dataAccess = new DAOfertaFlexipago(entity.PaisID);
            return dataAccess.DelOfertaFlexipago(entity);
        }

        public int GetUnidadesPermitidasByCuvFlexipago(int paisID, int CampaniaID, string CUV)
        {
            var dataAccess = new DAOfertaFlexipago(paisID);
            return dataAccess.GetUnidadesPermitidasByCuvFlexipago(CampaniaID, CUV);
        }

        public int ValidarUnidadesPermitidasEnPedidoFlexipago(int PaisID, int CampaniaID, string CUV, long ConsultoraID)
        {
            var dataAccess = new DAOfertaFlexipago(PaisID);
            return dataAccess.ValidarUnidadesPermitidasEnPedidoFlexipago(CampaniaID, CUV, ConsultoraID);
        }

        public int GetStockOfertaProductoFlexipago(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID)
        {
            var dataAccess = new DAOfertaFlexipago(paisID);
            return dataAccess.GetStockOfertaProductoFlexipago(CampaniaID, CUV, TipoOfertaSisID);
        }

        public int ObtenerMaximoItemsaMostrarFlexipago(int PaisID)
        {
            var dataAccess = new DAOfertaFlexipago(PaisID);
            return dataAccess.ObtenerMaximoItemsaMostrarFlexipago();
        }

        public int ActualizarItemsMostrarFlexipago(int PaisID, int Cantidad)
        {
            var dataAccess = new DAOfertaFlexipago(PaisID);
            return dataAccess.ActualizarItemsMostrarFlexipago(Cantidad);
        }

        public IList<BEOfertaFlexipago> GetOfertaProductosPortalFlexipago(int PaisID, int TipoOfertaSisID, string CodigoConsultora, int CodigoCampania)
        {
            var lst = new List<BEOfertaFlexipago>();
            var dataAccess = new DAOfertaFlexipago(PaisID);

            using (IDataReader reader = dataAccess.GetOfertaProductosPortalFlexipago(TipoOfertaSisID, CodigoConsultora, CodigoCampania))
                while (reader.Read())
                {
                    var entity = new BEOfertaFlexipago(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEOfertaFlexipago> GetCuotasAnterioresFlexipago(int PaisID, string CodigoConsultora, int CampaniaID)
        {
            var lst = new List<BEOfertaFlexipago>();
            var dataAccess = new DAOfertaFlexipago(PaisID);

            using (IDataReader reader = dataAccess.GetCuotasAnterioresFlexipago(CodigoConsultora, CampaniaID))
                while (reader.Read())
                {
                    var entity = new BEOfertaFlexipago(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public BEOfertaFlexipago GetLineaCreditoFlexipago(int PaisID, string CodigoConsultora, int CampaniaID)
        {
            BEOfertaFlexipago ofertaFlexipago = new BEOfertaFlexipago();
            var dataAccess = new DAOfertaFlexipago(PaisID);

            using (IDataReader reader = dataAccess.GetLineaCreditoFlexipago(CodigoConsultora, CampaniaID))
                while (reader.Read())
                {
                    ofertaFlexipago = new BEOfertaFlexipago(reader);
                }
            return ofertaFlexipago;
        }

        public bool GetPermisoFlexipago(int PaisID, string CodigoConsultora, int CampaniaID)
        {
            bool result;
            try
            {
                var dataAccess = new DAOfertaFlexipago(PaisID);
                result = dataAccess.GetPermisoFlexipago(CodigoConsultora, CampaniaID);
            }
            catch
            {
                result = false;
            }
            return result;
        }
    }
}