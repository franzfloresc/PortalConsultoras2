using Portal.Consultoras.Data;
using System;

namespace Portal.Consultoras.BizLogic
{
    public class BLRolPermiso : IDisposable
    {
        private DARolPermiso _daRolPermiso;
        public BLRolPermiso()
        {
            _daRolPermiso = new DARolPermiso();
        }
        public BLRolPermiso(int paisId)
        {
            _daRolPermiso = new DARolPermiso(paisId);
        }
        public int Insertar(int rolId, int permisoId, bool activo, bool mostrar)
        {
            return _daRolPermiso.Insertar(rolId,permisoId,activo,mostrar);
        }
        public int EliminarByPermisoId(int permisoId, int rolId)
        {
            return _daRolPermiso.EliminarByIdPermiso(permisoId,rolId);
        }
        public void Dispose()
        {
            _daRolPermiso = null;
        }
    }
}
