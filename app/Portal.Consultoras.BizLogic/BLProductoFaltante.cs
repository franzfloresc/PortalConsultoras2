using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    public class BLProductoFaltante
    {
        public void InsProductoFaltante(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            var DAproductofaltante = new DAProductoFaltante(paisID);
            DAproductofaltante.InsProductoFaltante(productosFaltantes, FaltanteUltimoMinuto);
        }

        public string InsProductoFaltanteMasivo(int paisID, string paisISO, string CodigoUsuario, int campaniaID, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            List<BEProductoFaltante> lstFinal = new List<BEProductoFaltante>();

            foreach (BEProductoFaltante be in productosFaltantes)
            {
                // recorremos para verificar si especificó que vaya todas las zonas
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

            var DAproductofaltante = new DAProductoFaltante(paisID);
            string result = DAproductofaltante.InsProductoFaltanteMasivo(paisID, lstFinal, FaltanteUltimoMinuto);

            return result;
        }


        public bool DelProductoFaltante(int paisID, string paisISO, string CodigoUsuario, BEProductoFaltante productofaltante)
        {
            bool deleted;
            var DAproductofaltante = new DAProductoFaltante(paisID);
            var DAproductofaltanteDD = new DAProductoFaltanteDD(paisID);

            DAproductofaltante.DelProductoFaltante(productofaltante, out deleted);
            //if (ConfigurationManager.AppSettings["IsProductoFaltanteDD"].Contains(paisISO) && !productofaltante.FaltanteUltimoMinuto)//R1957
            //    DAproductofaltanteDD.DelProductoFaltante(productofaltante, paisISO, CodigoUsuario, out deletedDD);

            return deleted;
        }

        //R1957
        public int DelProductoFaltante2(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productofaltante,int flag,int pais ,int campania,int zona,string cuv,string e_producto,DateTime fecha)
        {
            int deleted;
            var DAproductofaltante = new DAProductoFaltante(paisID);
            var DAproductofaltanteDD = new DAProductoFaltanteDD(paisID);

            DAproductofaltante.DelProductoFaltante2(productofaltante.ToList(), out deleted,flag,pais,campania,zona,cuv,e_producto,fecha);
            //if (ConfigurationManager.AppSettings["IsProductoFaltanteDD"].Contains(paisISO) && !productofaltante.FaltanteUltimoMinuto)
            //    DAproductofaltanteDD.DelProductoFaltante(productofaltante, paisISO, CodigoUsuario, out deletedDD);

            return deleted;
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByEntity(int paisID, BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            var productos = new List<BEProductoFaltante>();
            var DAproductofaltante = new DAProductoFaltante(paisID);

            using (IDataReader reader = DAproductofaltante.GetProductoFaltanteByEntity(productofaltante, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina,paisID))//R1957
                while (reader.Read())
                {
                    var prodfal = new BEProductoFaltante(reader);
                    prodfal.PaisID = paisID;
                    productos.Add(prodfal);
                }

            return productos;
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByCampaniaAndZonaID(int paisID, int CampaniaID, int ZonaID)
        {
            var productos = new List<BEProductoFaltante>();
            var DAproductofaltante = new DAProductoFaltante(paisID);

            using (IDataReader reader = DAproductofaltante.GetProductoFaltanteByCampaniaAndZonaID(CampaniaID,ZonaID))
                while (reader.Read())
                {
                    var prodfal = new BEProductoFaltante(reader);
                    prodfal.PaisID = paisID;
                    productos.Add(prodfal);
                }

            return productos;
        }

        public void InsLogIngresoFAD(int PaisID, int CampaniaId, long ConsultoraId, string CUV, int Cantidad, decimal PrecioUnidad, int ZonaId)
        {
            var DAproductofaltante = new DAProductoFaltante(PaisID);
            DAproductofaltante.InsLogIngresoFAD(CampaniaId, ConsultoraId, CUV, Cantidad, PrecioUnidad, ZonaId);
        }

        /* 1957 - Inicio */
        public int DelProductoFaltanteMasivo(int paisID, int campaniaID, string zona, string cuv, string fecha, string descripcion)
        {
            var productoFaltante = new DAProductoFaltante(paisID);
            return productoFaltante.DelProductoFaltanteMasivo(campaniaID, zona, cuv, fecha, descripcion);
        }
        /* 1957 - Fin */
    }
}
