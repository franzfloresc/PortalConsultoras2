using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLRol
    {
        public void InsRol(BERol rol)
        {
            var daRol = new DARol(rol.PaisID);
            daRol.InsRol(rol);
        }

        public int InsUsuarioRol(BEUsuarioRol BEUsuarioRol)
        {
            var daRol = new DARol(BEUsuarioRol.paisID);
            return daRol.InsUsuarioRol(BEUsuarioRol);
        }

        public void UpdRol(BERol rol)
        {
            var daRol = new DARol(rol.PaisID);
            daRol.UpdRol(rol);
        }

        public int DelRol(int paisID, int RolID)
        {
            var daRol = new DARol(paisID);
            return daRol.DelRol(RolID);
        }

        public int VerifyRolByDescripcion(BERol rol)
        {
            var daRol = new DARol(rol.PaisID);
            return daRol.VerifyRolByDescripcion(rol);
        }

        public IList<BERol> GetRoles(int paisID)
        {
            var roles = new List<BERol>();
            var daRol = new DARol(paisID);

            using (IDataReader reader = daRol.GetAllRols())
                while (reader.Read())
                {
                    var rol = new BERol(reader);
                    roles.Add(rol);
                }
            return roles;
        }

        public IList<BERol> GetRolesBySistema(int paisID, int sistema)
        {
            var roles = new List<BERol>();
            var daRol = new DARol(paisID);

            using (IDataReader reader = daRol.GetAllRolsBySistema(sistema))
                while (reader.Read())
                {
                    var rol = new BERol(reader);
                    roles.Add(rol);
                }
            return roles;
        }
    }
}
