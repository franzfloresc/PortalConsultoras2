using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLProductoFaltante
    {
        public void InsProductoFaltante(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            var daProductofaltante = new DAProductoFaltante(paisID);
            daProductofaltante.InsProductoFaltante(productosFaltantes, FaltanteUltimoMinuto);
        }

        public string InsProductoFaltanteMasivo(int paisID, string paisISO, string CodigoUsuario, int campaniaID, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            List<BEProductoFaltante> lstFinal = new List<BEProductoFaltante>();

            foreach (BEProductoFaltante be in productosFaltantes)
            {
                if (be.Zona.ToLower() == "todos" || be.Zona.ToLower() == "todas")
                {
                    BLZonificacion srv = new BLZonificacion();
                    List<BEZona> zonas = srv.SelectAllZonas(paisID).ToList();
                    foreach (BEZona zona in zonas)
                    {
                        lstFinal.Add(new BEProductoFaltante()
                        {
                            CUV = be.CUV,
                            Zona = zona.Codigo,
                            CampaniaID = campaniaID
                        });
                    }
                }
                else
                {
                    be.CampaniaID = campaniaID;
                    lstFinal.Add(be);
                }
            }

            var daProductofaltante = new DAProductoFaltante(paisID);
            string result = daProductofaltante.InsProductoFaltanteMasivo(paisID, lstFinal, FaltanteUltimoMinuto);

            return result;
        }

        public bool DelProductoFaltante(int paisID, string paisISO, string CodigoUsuario, BEProductoFaltante productofaltante)
        {
            bool deleted;
            var daProductofaltante = new DAProductoFaltante(paisID);

            daProductofaltante.DelProductoFaltante(productofaltante, out deleted);

            return deleted;
        }

        public int DelProductoFaltante2(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productofaltante, int flag, int pais, int campania, int zona, string cuv, string e_producto, DateTime fecha)
        {
            int deleted;
            var daProductofaltante = new DAProductoFaltante(paisID);

            daProductofaltante.DelProductoFaltante2(productofaltante.ToList(), out deleted, flag, pais, campania, zona, cuv, e_producto, fecha);

            return deleted;
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByEntity(int paisID, BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            var productos = new List<BEProductoFaltante>();
            var daProductofaltante = new DAProductoFaltante(paisID);

            using (IDataReader reader = daProductofaltante.GetProductoFaltanteByEntity(productofaltante, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina, paisID))//R1957
                while (reader.Read())
                {
                    var prodfal = new BEProductoFaltante(reader) { PaisID = paisID };
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByCampaniaAndZonaID(int paisID, int CampaniaID, int ZonaID, string cuv, string descripcion, string codCategoria, string codCatalogoRevista)
        {
            var productos = new List<BEProductoFaltante>();
            var daProductofaltante = new DAProductoFaltante(paisID);
            var blPais = new BLPais();

            if (!blPais.EsPaisHana(paisID)) // Validar si informacion de pais es de origen Normal o Hana
            {
                using (IDataReader reader = daProductofaltante.GetProductoFaltanteByCampaniaAndZonaID(CampaniaID, ZonaID, cuv, descripcion, codCategoria , codCatalogoRevista))
                    while (reader.Read())
                    {
                        var prodfal = new BEProductoFaltante(reader);
                        productos.Add(prodfal);
                    }
            }
            else
            {
                var dahFaltanteAnunciado = new DAHFaltanteAnunciado();
                var productosHana = dahFaltanteAnunciado.GetProductoFaltanteAnunciado(paisID, CampaniaID);

                using (IDataReader reader = daProductofaltante.GetOnlyProductoFaltante(productosHana, CampaniaID, ZonaID, cuv, descripcion))
                    while (reader.Read())
                    {
                        var prodfal = new BEProductoFaltante(reader);
                        productos.Add(prodfal);
                    }
            }
            return productos;
        }

        public void InsLogIngresoFAD(int PaisID, int CampaniaId, long ConsultoraId, string CUV, int Cantidad, decimal PrecioUnidad, int ZonaId)
        {
            var daProductofaltante = new DAProductoFaltante(PaisID);
            daProductofaltante.InsLogIngresoFAD(CampaniaId, ConsultoraId, CUV, Cantidad, PrecioUnidad, ZonaId);
        }

        public int DelProductoFaltanteMasivo(int paisID, int campaniaID, string zona, string cuv, string fecha, string descripcion)
        {
            var productoFaltante = new DAProductoFaltante(paisID);
            return productoFaltante.DelProductoFaltanteMasivo(campaniaID, zona, cuv, fecha, descripcion);
        }
    }
}
