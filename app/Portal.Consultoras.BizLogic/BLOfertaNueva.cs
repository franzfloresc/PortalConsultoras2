using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLOfertaNueva
    {
        public IList<BEOfertaNueva> GetOfertasNuevasByCampania(int paisID, int CampaniaID)
        {
            var lst = new List<BEOfertaNueva>();
            var dataAccess = new DAOfertaNueva(paisID);

            using (IDataReader reader = dataAccess.GetOfertasNuevasByCampania(CampaniaID))
                while (reader.Read())
                {
                    var entity = new BEOfertaNueva(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEOfertaNueva> GetPackOfertasNuevasByCampania(int paisID, int CampaniaID)
        {
            var lst = new List<BEOfertaNueva>();
            var dataAccess = new DAOfertaNueva(paisID);

            using (IDataReader reader = dataAccess.GetPackOfertasNuevasByCampania(paisID, CampaniaID))
                while (reader.Read())
                {
                    var entity = new BEOfertaNueva(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public IList<BEOfertaNueva> GetProductosOfertaConsultoraNueva(int paisID, int CampaniaID, int consultoraid)
        {
            var lst = new List<BEOfertaNueva>();
            var dataAccess = new DAOfertaNueva(paisID);

            using (IDataReader reader = dataAccess.GetProductosOfertaConsultoraNueva(CampaniaID, consultoraid))
                while (reader.Read())
                {
                    var entity = new BEOfertaNueva(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public BEOfertaNueva GetDescripcionPackByCUV(int paisID, string CUV, int CampaniaCodigo)
        {
            BEOfertaNueva entity = new BEOfertaNueva();
            var dataAccess = new DAOfertaNueva(paisID);

            using (IDataReader reader = dataAccess.GetDescripcionPackByCUV(CUV, CampaniaCodigo))
                while (reader.Read())
                {
                    entity = new BEOfertaNueva(reader) { PaisID = paisID };
                }
            return entity;
        }

        public int ValidarOfertasNuevas(BEOfertaNueva oBe)
        {
            var dataAccess = new DAOfertaNueva(oBe.PaisID);
            return dataAccess.ValidarOfertasNuevas(oBe);
        }

        public int ValidarUnidadesPermitidas(BEOfertaNueva oBe)
        {
            var dataAccess = new DAOfertaNueva(oBe.PaisID);
            return dataAccess.ValidarUnidadesPermitidas(oBe);
        }

        public int ObtenerEstadoPacksOfertasNuevas(int PaisID, string CodigoConsultora)
        {
            var dataAccess = new DAOfertaNueva(PaisID);
            return dataAccess.ObtenerEstadoPacksOfertasNuevas(CodigoConsultora);
        }

        public int UpdEstadoPacksOfertasNuevas(int PaisID, string CodigoConsultora, int CambioEstado)
        {
            var dataAccess = new DAOfertaNueva(PaisID);
            return dataAccess.UpdEstadoPacksOfertasNuevas(CodigoConsultora, CambioEstado);
        }

        public int InsertOfertasNuevas(BEOfertaNueva oBe)
        {
            var dataAccess = new DAOfertaNueva(oBe.PaisID);
            return dataAccess.InsertOfertasNuevas(oBe);
        }

        public int UpdOfertasNuevas(BEOfertaNueva oBe)
        {
            var dataAccess = new DAOfertaNueva(oBe.PaisID);
            return dataAccess.UpdOfertasNuevas(oBe);
        }

        public int DelOfertasNuevas(BEOfertaNueva oBe, int ConfiguracionOfertaId)
        {
            var dataAccess = new DAOfertaNueva(oBe.PaisID);
            return dataAccess.DelOfertasNuevas(oBe, ConfiguracionOfertaId);
        }

        public int UpdEstadoPacksOfertasNueva(int PaisID, int idconsultora, string CodigoConsultora, int campania)
        {
            var dataAccess = new DAOfertaNueva(PaisID);
            return dataAccess.UpdEstadoPacksOfertasNueva(idconsultora, CodigoConsultora, campania);
        }

        public int ObtenerEstadoPacksOfertasNueva(int PaisID, int idconsultora, int campania)
        {
            var dataAccess = new DAOfertaNueva(PaisID);
            return dataAccess.ObtenerEstadoPacksOfertasNueva(idconsultora, campania);
        }

    }
}