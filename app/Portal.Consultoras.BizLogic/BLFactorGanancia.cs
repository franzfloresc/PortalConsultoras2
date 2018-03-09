using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLFactorGanancia
    {
        public IList<BEFactorGanancia> SelectFactorGanancia(int PaisID)
        {
            IList<BEFactorGanancia> lista = (IList<BEFactorGanancia>)CacheManager<BEFactorGanancia>.GetData(PaisID, ECacheItem.FactorGanancia);
            if (lista == null)
            {
                lista = new List<BEFactorGanancia>();
                var daFactorGanancia = new DAFactorGanancia(PaisID);

                using (IDataReader reader = daFactorGanancia.SelectFactorGanancia())
                    while (reader.Read())
                    {
                        var entidad = new BEFactorGanancia(reader);
                        lista.Add(entidad);
                    }
                CacheManager<BEFactorGanancia>.AddData(PaisID, ECacheItem.FactorGanancia, lista);
            }
            return lista;
        }

        public IList<BEFactorGanancia> SelectFactorGananciaAdministrador(int PaisID)
        {
            var lista = new List<BEFactorGanancia>();
            var daFactorGanancia = new DAFactorGanancia(PaisID);

            using (IDataReader reader = daFactorGanancia.SelectFactorGanancia())
                while (reader.Read())
                {
                    var entidad = new BEFactorGanancia(reader);

                    lista.Add(entidad);
                }

            return lista;
        }

        public IList<BEFactorGanancia> GetFactorGananciaById(int paisID)
        {
            var lista = new List<BEFactorGanancia>();
            var daFactorGanancia = new DAFactorGanancia(paisID);

            using (IDataReader reader = daFactorGanancia.GetFactorGananciaById(paisID))
                while (reader.Read())
                {
                    var entidad = new BEFactorGanancia(reader) { PaisID = paisID };
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsertFactorGanancia(BEFactorGanancia entidad)
        {
            var daFactorGanancia = new DAFactorGanancia(entidad.PaisID);
            int rangoValido = daFactorGanancia.GetFactorGananciaValidar(0, entidad.RangoMinimo, entidad.RangoMaximo);

            if (rangoValido == 0)
            {
                daFactorGanancia.Insert(entidad);
                CacheManager<BEFactorGanancia>.RemoveData(entidad.PaisID, ECacheItem.FactorGanancia);
            }

            return rangoValido;
        }

        public int UpdateFactorGanancia(BEFactorGanancia entidad)
        {
            var daFactorGanancia = new DAFactorGanancia(entidad.PaisID);
            int rangoValido = daFactorGanancia.GetFactorGananciaValidar(entidad.FactorGananciaID, entidad.RangoMinimo, entidad.RangoMaximo);

            if (rangoValido == 0)
            {
                daFactorGanancia.Update(entidad);
                CacheManager<BEFactorGanancia>.RemoveData(entidad.PaisID, ECacheItem.FactorGanancia);
            }

            return rangoValido;
        }

        public void DeleteFactorGanancia(int paisID, int factorGananciaID)
        {
            var daFactorGanancia = new DAFactorGanancia(paisID);
            daFactorGanancia.Delete(factorGananciaID);
            CacheManager<BEFactorGanancia>.RemoveData(paisID, ECacheItem.FactorGanancia);
        }

        public BEFactorGanancia GetFactorGananciaSiguienteEscala(decimal monto, int paisID)
        {
            BEFactorGanancia obeFactorGanancia = null;

            IList<BEFactorGanancia> lista = SelectFactorGanancia(paisID);
            if (lista.Count != 0)
            {
                obeFactorGanancia = lista.FirstOrDefault(p => p.RangoMinimo <= monto && p.RangoMaximo >= monto);
                if (obeFactorGanancia != null)
                {
                    int escala = obeFactorGanancia.Escala;
                    obeFactorGanancia = lista.FirstOrDefault(p => p.Escala == escala + 1);
                }
            }
            return obeFactorGanancia;
        }

        public BEFactorGanancia GetFactorGananciaEscalaDescuento(decimal monto, int paisID)
        {
            BEFactorGanancia obeFactorGanancia = null;

            IList<BEFactorGanancia> lista = SelectFactorGanancia(paisID);
            if (lista.Count != 0)
            {
                obeFactorGanancia = lista.FirstOrDefault(p => p.RangoMinimo <= monto && p.RangoMaximo >= monto);
                if (obeFactorGanancia == null)
                {
                    int escala = lista.Max(p => p.Escala);
                    obeFactorGanancia = lista.FirstOrDefault(p => p.Escala == escala);
                }
            }
            return obeFactorGanancia;
        }

        public IList<BEFactorGanancia> GetFactorGananciaByPaisRango(decimal monto, int paisID)
        {
            var lista = new List<BEFactorGanancia>();
            var daFactorGanancia = new DAFactorGanancia(paisID);

            using (IDataReader reader = daFactorGanancia.GetFactorGananciaByPaisRango(monto, paisID))
                while (reader.Read())
                {
                    var entidad = new BEFactorGanancia(reader);
                    lista.Add(entidad);
                }
            return lista;
        }

        public IList<BEPedidoWebDetalleDescuento> GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(int paisID, int campaniaId, int pedidoId)
        {
            var lista = new List<BEPedidoWebDetalleDescuento>();
            var daFactorGanancia = new DAFactorGanancia(paisID);

            using (IDataReader reader = daFactorGanancia.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(campaniaId, pedidoId))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalleDescuento(reader);
                    lista.Add(entidad);
                }
            return lista;
        }

        public void UpdatePedidoWebEstimadoGanancia(int paisID, int campaniaId, int pedidoId, decimal estimadoGanancia)
        {
            var daFactorGanancia = new DAFactorGanancia(paisID);
            daFactorGanancia.UpdatePedidoWebEstimadoGanancia(campaniaId, pedidoId, estimadoGanancia);
        }
    }
}
