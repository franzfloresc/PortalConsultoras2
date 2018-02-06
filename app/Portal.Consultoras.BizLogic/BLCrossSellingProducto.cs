using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCrossSellingProducto
    {
        public int InsCrossSellingProducto(BECrossSellingProducto entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.InsCrossSellingProducto(entidad);
        }

        public int UpdCrossSellingProducto(BECrossSellingProducto entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.UpdCrossSellingProducto(entidad);
        }

        public int DelCrossSellingProducto(BECrossSellingProducto entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.DelCrossSellingProducto(entidad);
        }

        public IList<BECrossSellingProducto> GetCrossSellingProductosAdministracion(int PaisID, int CampaniaID)
        {
            var ofertaWeb = new List<BECrossSellingProducto>();
            var daOfertaWeb = new DACrossSellingProducto(PaisID);

            using (IDataReader reader = daOfertaWeb.GetCrossSellingProductosAdministracion(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BECrossSellingProducto(reader) {PaisID = PaisID};
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }

        public IList<BECrossSellingAsociacion> GetCrossSellingAsociacionListado(int PaisID, int CampaniaID, string CUV)
        {
            var ofertaWeb = new List<BECrossSellingAsociacion>();
            var daOfertaWeb = new DACrossSellingProducto(PaisID);

            using (IDataReader reader = daOfertaWeb.GetCrossSellingAsociacionListado(CampaniaID, CUV))
                while (reader.Read())
                {
                    var entidad = new BECrossSellingAsociacion(reader) {PaisID = PaisID};
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }

        public IList<BECrossSellingAsociacion> GetCUVAsociadoByFilter(int PaisID, int CampaniaID, string CUV, string CodigoSegmento )
        {
            var ofertaWeb = new List<BECrossSellingAsociacion>();
            var daOfertaWeb = new DACrossSellingProducto(PaisID);

            using (IDataReader reader = daOfertaWeb.GetCUVAsociadoByFilter(CampaniaID, CUV, CodigoSegmento))
                while (reader.Read())
                {
                    var entidad = new BECrossSellingAsociacion(reader) {PaisID = PaisID};
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }

        public IList<BECrossSellingAsociacion> GetDescripcionProductoByCUV(int PaisID, int CampaniaID, string CUV)
        {
            var ofertaWeb = new List<BECrossSellingAsociacion>();
            var daOfertaWeb = new DACrossSellingProducto(PaisID);

            using (IDataReader reader = daOfertaWeb.GetDescripcionProductoByCUV(CampaniaID, CUV))
                while (reader.Read())
                {
                    var entidad = new BECrossSellingAsociacion(reader) {PaisID = PaisID};
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }

        public IList<BECrossSellingProducto> GetProductosRecomendadosHabilitados(int PaisID, int CampaniaID, int tipo)
        {
            var ofertaWeb = new List<BECrossSellingProducto>();
            var daOfertaWeb = new DACrossSellingProducto(PaisID);

            using (IDataReader reader = daOfertaWeb.GetProductosRecomendadosHabilitados(CampaniaID, tipo))
                while (reader.Read())
                {
                    var entidad = new BECrossSellingProducto(reader) {PaisID = PaisID};
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }

        public int InsCrossSellingAsociacion(BECrossSellingAsociacion entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.InsCrossSellingAsociacion(entidad);
        }

        public int UpdCrossSellingAsociacion(BECrossSellingAsociacion entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.UpdCrossSellingAsociacion(entidad);
        }

        public int DelCrossSellingAsociacion(BECrossSellingAsociacion entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.DelCrossSellingAsociacion(entidad);
        }
		public int DelCrossSellingAsociacion_Perfil(BECrossSellingAsociacion entidad)
        {
            var dataAccess = new DACrossSellingProducto(entidad.PaisID);
            return dataAccess.DelCrossSellingAsociacion_Perfil(entidad);
        }
        public IList<BECrossSellingProducto> GetProductosRecomendadosByCUVCampaniaPortal(int PaisID, long ConsultoraID, int CampaniaID, string CUV)
        {
            var ofertaWeb = new List<BECrossSellingProducto>();
            var daOfertaWeb = new DACrossSellingProducto(PaisID);

            using (IDataReader reader = daOfertaWeb.GetProductosRecomendadosByCUVCampaniaPortal(ConsultoraID, CampaniaID, CUV))
                while (reader.Read())
                {
                    var entidad = new BECrossSellingProducto(reader) {PaisID = PaisID};
                    ofertaWeb.Add(entidad);
                }

            return ofertaWeb;
        }
		public int UpdVisualizacionPopupProRecom(int consultoraid, int campaniaid, int paisid)
        {
            var dataAccess = new DACrossSellingProducto(paisid);
            return dataAccess.UpdVisualizacionPopupProRecom(consultoraid, campaniaid);
        }
    }
}
