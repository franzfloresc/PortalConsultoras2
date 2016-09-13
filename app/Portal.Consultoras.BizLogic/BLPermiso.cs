﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLPermiso
    {
        public IList<BEPermiso> GetPermisosByRol(int paisID, int rolID)
        {
            IList<BEPermiso> permisos = (IList<BEPermiso>) CacheManager<BEPermiso>.GetData(paisID, ECacheItem.MenuGeneralSB2, rolID.ToString());
            if (permisos == null || permisos.Count == 0)
            {
                var DAPermiso = new DAPermiso(paisID);
                permisos = new List<BEPermiso>();
                using (IDataReader reader = DAPermiso.GetPermisosByRol(rolID))
                    while (reader.Read())
                    {
                        var entidad = new BEPermiso(reader);
                        permisos.Add(entidad);
                    }
                CacheManager<BEPermiso>.AddData(paisID, ECacheItem.MenuGeneralSB2, rolID.ToString(), permisos);
            }
            return permisos;
        }

        public void RemovePermisosByRol(int paisID, int rolID)
        {
            CacheManager<BEPermiso>.RemoveData(paisID, ECacheItem.MenuGeneralSB2, rolID.ToString());
        }

        public IList<BEPermiso> GetPermisosByRolAdministrador(int paisID, int rolID)
        {

            var DAPermiso = new DAPermiso(paisID);
            var permisos = new List<BEPermiso>();
            using (IDataReader reader = DAPermiso.GetPermisosByRol(rolID))
                while (reader.Read())
                {
                    var entidad = new BEPermiso(reader);
                    permisos.Add(entidad);
                }

            return permisos;
        }

        public IList<BEPermiso> GetAllPermisosCheckByRol(int paisID, int rolID)
        {
            var permisos = new List<BEPermiso>();
            var DAPermiso = new DAPermiso(paisID);

            using (IDataReader reader = DAPermiso.GetAllPermisosCheckByRol(rolID))
                while (reader.Read())
                {
                    var permiso = new BEPermiso(reader);
                    permisos.Add(permiso);
                }
            return permisos;
        }

        public int InsPermisosByRolMasiv(int paisID, int RolID, string Permisos)
        {
            var DAPermiso = new DAPermiso(paisID);
            return DAPermiso.InsPermisosByRolMasiv(RolID, Permisos);
        }

        public void InsPermiso(BEPermiso entidad)
        {
            using (var tran = new TransactionScope())
            {
                var daPermiso = new DAPermiso(entidad.PaisID);
                var permisoId = daPermiso.Insert(entidad);
                if (permisoId > 0)
                {
                    using (var blRolPermiso = new BLRolPermiso(entidad.PaisID))
                    {
                        blRolPermiso.Insertar(entidad.RolId, permisoId, true, entidad.Mostrar);
                    }
                }
                tran.Complete();
            }
        }
        public void UpdatePermiso(BEPermiso entidad)
        {
            var daPermiso = new DAPermiso(entidad.PaisID);
            daPermiso.Update(entidad);
        }
        public void DeletePermiso(int paisID, int permisoID)
        {
            var daPermiso = new DAPermiso(paisID);
            daPermiso.Delete(permisoID);
        }

        public IList<BEPermiso> GetPermisosByRolConsulta(int paisID, int rolID, string posicion)
        {
            var permisos = new List<BEPermiso>();
            var DAPermiso = new DAPermiso(paisID);

            using (IDataReader reader = DAPermiso.GetPermisosByRolConsulta(rolID, posicion))
                while (reader.Read())
                {
                    var permiso = new BEPermiso(reader);
                    permisos.Add(permiso);
                }
            return permisos;
        }

        public IList<BEPermiso> GetPermisosPadreBySistema(int paisID, int sistema)
        {
            var permisos = new List<BEPermiso>();
            var DAPermiso = new DAPermiso(paisID);

            using (IDataReader reader = DAPermiso.GetPermisosPadreBySistema(sistema))
                while (reader.Read())
                {
                    var permiso = new BEPermiso(reader);
                    permisos.Add(permiso);
                }
            return permisos;
        }
    }
}
