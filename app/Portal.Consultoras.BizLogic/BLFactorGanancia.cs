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
    public class BLFactorGanancia
    {
        public IList<BEFactorGanancia> SelectFactorGanancia(int PaisID)
        {
            IList<BEFactorGanancia> lista = (IList<BEFactorGanancia>)CacheManager<BEFactorGanancia>.GetData(PaisID, ECacheItem.FactorGanancia);
            if (lista == null)
            {
                lista = new List<BEFactorGanancia>();
                var DAFactorGanancia = new DAFactorGanancia(PaisID);

                using (IDataReader reader = DAFactorGanancia.SelectFactorGanancia())
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
            var DAFactorGanancia = new DAFactorGanancia(PaisID);

            using (IDataReader reader = DAFactorGanancia.SelectFactorGanancia())
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
            var DAFactorGanancia = new DAFactorGanancia(paisID);

            using (IDataReader reader = DAFactorGanancia.GetFactorGananciaById(paisID))
                while (reader.Read())
                {
                    var entidad = new BEFactorGanancia(reader);
                    entidad.PaisID = paisID;
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsertFactorGanancia(BEFactorGanancia entidad)
        {
            var DAFactorGanancia = new DAFactorGanancia(entidad.PaisID);
            int RangoValido = DAFactorGanancia.GetFactorGananciaValidar(0, entidad.RangoMinimo, entidad.RangoMaximo);

            if (RangoValido == 0)
            {
                DAFactorGanancia.Insert(entidad);
                CacheManager<BEFactorGanancia>.RemoveData(entidad.PaisID, ECacheItem.FactorGanancia);
            }

            return RangoValido;  
        }

        public int UpdateFactorGanancia(BEFactorGanancia entidad)
        {
            var DAFactorGanancia = new DAFactorGanancia(entidad.PaisID);
            int RangoValido = DAFactorGanancia.GetFactorGananciaValidar(entidad.FactorGananciaID, entidad.RangoMinimo, entidad.RangoMaximo);

            if (RangoValido == 0)
            {
                DAFactorGanancia.Update(entidad);
                CacheManager<BEFactorGanancia>.RemoveData(entidad.PaisID, ECacheItem.FactorGanancia);
            }

            return RangoValido;  
        }

        public void DeleteFactorGanancia(int paisID, int factorGananciaID)
        {
            var DAFactorGanancia = new DAFactorGanancia(paisID);
            DAFactorGanancia.Delete(factorGananciaID);
            CacheManager<BEFactorGanancia>.RemoveData(paisID, ECacheItem.FactorGanancia);
        }

        public BEFactorGanancia GetFactorGananciaSiguienteEscala(decimal monto, int paisID)
        {
            BEFactorGanancia oBEFactorGanancia = null;

            IList<BEFactorGanancia> lista = SelectFactorGanancia(paisID);
            if (lista.Count != 0)
            {
                oBEFactorGanancia = lista.FirstOrDefault(p => p.RangoMinimo <= monto && p.RangoMaximo >= monto);
                if (oBEFactorGanancia != null)
                {
                    int Escala = oBEFactorGanancia.Escala;
                    oBEFactorGanancia = lista.FirstOrDefault(p => p.Escala == Escala + 1);
                }
            }
            return oBEFactorGanancia;
        }

        public BEFactorGanancia GetFactorGananciaEscalaDescuento(decimal monto, int paisID)
        {
            BEFactorGanancia oBEFactorGanancia = null;

            IList<BEFactorGanancia> lista = SelectFactorGanancia(paisID);
            if (lista.Count != 0)
            {
                oBEFactorGanancia = lista.FirstOrDefault(p => p.RangoMinimo <= monto && p.RangoMaximo >= monto);
                if (oBEFactorGanancia == null)
                {
                    int Escala = lista.Max(p => p.Escala);
                    oBEFactorGanancia = lista.FirstOrDefault(p => p.Escala == Escala);
                }
            }
            return oBEFactorGanancia;
        }

        public IList<BEFactorGanancia> GetFactorGananciaByPaisRango(decimal monto, int paisID)
        {
            var lista = new List<BEFactorGanancia>();
            var DAFactorGanancia = new DAFactorGanancia(paisID);

            using (IDataReader reader = DAFactorGanancia.GetFactorGananciaByPaisRango(monto, paisID))
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
            var DAFactorGanancia = new DAFactorGanancia(paisID);

            using (IDataReader reader = DAFactorGanancia.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(campaniaId, pedidoId))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalleDescuento(reader);
                    lista.Add(entidad);
                }
            return lista;
        }

        public void UpdatePedidoWebEstimadoGanancia(int paisID, int campaniaId, int pedidoId, decimal estimadoGanancia)
        {
            var DAFactorGanancia = new DAFactorGanancia(paisID);
            DAFactorGanancia.UpdatePedidoWebEstimadoGanancia(campaniaId, pedidoId, estimadoGanancia);
        }
    }
}
