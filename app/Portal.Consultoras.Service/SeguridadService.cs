﻿using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;

namespace Portal.Consultoras.Service
{
    public class SeguridadService : ISeguridadService
    {
        private BLRol BLRol;
        private BLPermiso BLPermiso;
        private BLMenuMobile BLMenuMobile;//20150903

        public SeguridadService()
        {
            BLRol = new BLRol();
            BLPermiso = new BLPermiso();
            BLMenuMobile = new BLMenuMobile();//20150903
        }

        #region Roles
        public void InsRol(BERol rol)
        {
            BLRol.InsRol(rol);
        }
        public int InsUsuarioRol(BEUsuarioRol BEUsuarioRol)
        {
            return BLRol.InsUsuarioRol(BEUsuarioRol);
        }

        public void UpdRol(BERol rol)
        {
            BLRol.UpdRol(rol);
        }

        public int DelRol(int paisID, int RolID)
        {
            return BLRol.DelRol(paisID, RolID);
        }

        public int VerifyRolByDescripcion(BERol rol)
        {
            return BLRol.VerifyRolByDescripcion(rol);
        }

        public IList<BERol> GetRoles(int paisID)
        {
            return BLRol.GetRoles(paisID);
        }

        public IList<BERol> GetRolesBySistema(int paisID, int sistema)
        {
            return BLRol.GetRolesBySistema(paisID, sistema);
        }
        #endregion

        #region Permiso

        public IList<BEPermiso> GetPermisosByRol(int paisID, int rolID)
        {
            return BLPermiso.GetPermisosByRol(paisID, rolID);
        }

        public IList<BEPermiso> GetPermisosByRolAdministrador(int paisID, int rolID)
        {
            return BLPermiso.GetPermisosByRolAdministrador(paisID, rolID);
        }

        public IList<BEPermiso> GetAllPermisosCheckByRol(int paisID, int rolID)
        {
            return BLPermiso.GetAllPermisosCheckByRol(paisID, rolID);
        }

        public void InsPermisosByRolMasiv(int paisID, int RolID, string Permisos)
        {
            BLPermiso.InsPermisosByRolMasiv(paisID, RolID, Permisos);
        }

        public void InsPermiso(BEPermiso entidad)
        {
            try
            {
                BLPermiso.InsPermiso(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción del Link.");
            }
        }

        public void UpdatePermiso(BEPermiso entidad)
        {
            try
            {
                BLPermiso.UpdatePermiso(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización del Link.");
            }
        }

        public void DeletePermiso(int paisID, int permisoID)
        {
            try
            {
                BLPermiso.DeletePermiso(paisID, permisoID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación del Link.");
            }
        }

        public IList<BEPermiso> GetPermisosByRolConsulta(int paisID, int rolID, string posicion)
        {
            return BLPermiso.GetPermisosByRolConsulta(paisID, rolID, posicion);
        }

        public IList<BEPermiso> GetPermisosPadreBySistema(int paisID, int sistema)
        {
            return BLPermiso.GetPermisosPadreBySistema(paisID, sistema);
        }
        #endregion

        #region Mobile

        public IList<BEMenuMobile> GetItemsMenuMobile(int paisID)
        {
            return BLMenuMobile.GetItemsByPais(paisID);
        }

        #endregion

    }
}
