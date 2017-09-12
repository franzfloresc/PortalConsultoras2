using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using System.ServiceModel.Web;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IZonificacionService
    {
        [OperationContract]
        IList<BEZona> SelectZonaByCodigo(int paisID, string codigo, int rowCount);

        [OperationContract]
        IList<BEZona> SelectZonaById(int paisID, int ZonaID);

        [OperationContract]
        IList<BEPais> SelectPaises();

        [OperationContract]
        int GetPaisNumeroCampaniasByPaisID(int paisID);

        [OperationContract]
        IList<BECampania> SelectCampanias(int paisID);

        [OperationContract]
        IList<BEZona> SelectAllZonas(int paisID);

        [OperationContract]
        IList<BERegion> SelectAllRegiones(int paisID);

        //R20151221 - Parámetro 

        [OperationContract]
        IList<BEGetRegionByPaisParametroCarga> GetRegionByPaisParametroCarga(int paisID);

        [OperationContract]
        IList<BEGetZonaByPaisParametroCarga> GetZonaByPaisParametroCarga(int paisID);

        //R20151221 - Fín Parámetro

        [OperationContract]
        IList<BETerritorio> SelectAllTerritorios(int paisID);

        [OperationContract]
        IList<BETerritorio> SelectTerritorioByCodigo(int paisID, string codigo, int rowCount);

        [OperationContract]
        BEPais SelectPais(int paisID);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, Method = "GET", BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        IList<BEPais> GetAllPaises();

        [OperationContract]
        IList<BEZona> SelectZonasActivasFIC(int paisID, int CampaniaID);

        [OperationContract]
        IList<BEZona> SelectZonasInactivasFIC(int paisID, int CampaniaID);

        [OperationContract]
        void InsInsCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona);

        [OperationContract]
        void DelCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona);

        [OperationContract]
        void InsCronogramaFICMasivo(int paisID, int campaniaID, IList<BECronogramaFIC> cronogramaFIC);

        [OperationContract]
        IList<BECronogramaFIC> GetCronogramaFICByCampania(int paisID, string CodigoCampania);

        [OperationContract]
        void UpdCronogramaFIC(int paisID, string CampaniaCodigo, string CodigoZona, DateTime? Fecha);

        [OperationContract]
        IList<BECronogramaFIC> GetCronogramaFICByZona(int paisID, string CampaniaCodigo, string ZonaCodigo);

        [OperationContract]
        void DelCronogramaFICConsultora(int paisID, string CampaniaCodigo, string CodigoZona, string CodigoConsultora);

        #region ApeZona

        [OperationContract]
        IList<BEZona> SelectApeZonas(int paisID, int regionID, string codigoBusqueda);

        [OperationContract]
        void UpdateApeZona(int paisID, int zonaID, int cantidadDias);

        #endregion

        [OperationContract]
        IList<BEPais> SelectPaisesDD();

        [OperationContract]
        IList<BETerritorio> SearchTerritoriosByZona(int paisID, string codigoZona, string codigoTerritorio);

        //RQ_BS - R2133
        [OperationContract]
        IList<BESegmentoBanner> GetSegmentoBanner(int PaisID);

        //RQ_BS - R2133
        [OperationContract]
        IList<BEZonificacionJerarquia> GetZonificacionJerarquia(int PaisID);

        /*RE2544 - CS(CGI) */     
        [OperationContract]
        IList<BESegmentoBanner> GetSegmentoInternoBanner(int PaisID);

    }
}
