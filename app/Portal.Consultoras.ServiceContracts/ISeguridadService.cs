using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface ISeguridadService
    {
        #region Roles
        [OperationContract]
        void InsRol(BERol rol);

        [OperationContract]
        int InsUsuarioRol(BEUsuarioRol BEUsuarioRol);

        [OperationContract]
        void UpdRol(BERol rol);

        [OperationContract]
        int DelRol(int paisID, int RolID);

        [OperationContract]
        int VerifyRolByDescripcion(BERol rol);

        [OperationContract]
        IList<BERol> GetRoles(int paisID);

        [OperationContract]
        IList<BERol> GetRolesBySistema(int paisID, int sistema);
        #endregion

        #region Permisos
        [OperationContract]
        IList<BEPermiso> GetPermisosByRol(int paisID, int rolID);

        [OperationContract]
        IList<BEPermiso> GetPermisosByRolAdministrador(int paisID, int rolID);

        [OperationContract]
        IList<BEPermiso> GetAllPermisosCheckByRol(int paisID, int rolID);

        [OperationContract]
        void InsPermisosByRolMasiv(int paisID, int RolID, string Permisos);

        [OperationContract]
        void InsPermiso(BEPermiso entidad);

        [OperationContract]
        void UpdatePermiso(BEPermiso entidad);

        [OperationContract]
        void DeletePermiso(int paisID, int permisoID);

        [OperationContract]
        IList<BEPermiso> GetPermisosByRolConsulta(int paisID, int rolID, string posicion);

        [OperationContract]
        IList<BEPermiso> GetPermisosPadreBySistema(int paisID, int sistema);

        #endregion

        #region Mobile

        [OperationContract]
        IList<BEMenuMobile> GetItemsMenuMobile(int paisID);
        #endregion

        #region Menus App
        [OperationContract]
        IList<BEMenuApp> GetMenuApp(BEMenuApp menuApp);
        #endregion
    }
}