using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.OpcionesVerificacion;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLOpcionesVerificacion
    {
        public BEOpcionesVerificacion GetOpcionesVerificacionCache(int paisID, int origenID)
        {
            return CacheManager<BEOpcionesVerificacion>.ValidateDataElement(paisID, ECacheItem.OpcionesVerificacion, origenID.ToString(), () => GetOpcionesVerificacion(paisID, origenID));
        }

        public BEOpcionesVerificacion GetOpcionesVerificacion(int paisID, int origenID)
        {
            var obj = new DAOpcionesVerificacion(paisID);
            BEOpcionesVerificacion OpcVeri = null;
            using (IDataReader rd = obj.GetOpcionesVerificacion(origenID))
            {
                if (rd.Read())
                    OpcVeri = new BEOpcionesVerificacion(rd);
            }
            if (OpcVeri == null) return null;
            OpcVeri.lstFiltros = new List<BEFiltrosOpcionesVerificacion>();
            if (OpcVeri.IncluyeFiltros) OpcVeri.lstFiltros = GetFiltrosOpcionesVerificacion(paisID, origenID) ?? new List<BEFiltrosOpcionesVerificacion>();
            return OpcVeri;
        }

        public BEZonasOpcionesVerificacion GetZonasOpcionesVerificacion(int paisID, int regionID, int zonaID)
        {
            var obj = new DAOpcionesVerificacion(paisID);
            var oOp = new BEZonasOpcionesVerificacion();
            using (IDataReader rd = obj.GetZonasOpcionesVerificacion(regionID, zonaID))
            {
                while (rd.Read())
                {
                    oOp = new BEZonasOpcionesVerificacion(rd);
                } 
            }
            return oOp;
        }

        private List<BEFiltrosOpcionesVerificacion> GetFiltrosOpcionesVerificacion(int paisID, int origenID)
        {
            var obj = new DAOpcionesVerificacion(paisID);
            var lstOp = new List<BEFiltrosOpcionesVerificacion>();
            using (IDataReader rd = obj.GetFiltrosOpcionesVerificacion(origenID))
            {
                while (rd.Read())
                {
                    lstOp.Add(new BEFiltrosOpcionesVerificacion(rd));
                }
            }
            return lstOp;
        }
    }
}