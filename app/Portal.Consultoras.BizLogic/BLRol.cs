using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLRol
    {
        public void InsRol(BERol rol)
        {
            var DARol = new DARol(rol.PaisID);
            DARol.InsRol(rol);
        }
        public int InsUsuarioRol(BEUsuarioRol BEUsuarioRol)
        {
            var DARol = new DARol(BEUsuarioRol.paisID);
            return DARol.InsUsuarioRol(BEUsuarioRol);
        }

        public void UpdRol(BERol rol)
        {
            var DARol = new DARol(rol.PaisID);
            DARol.UpdRol(rol);
        }

        public int DelRol(int paisID, int RolID)
        {
            var DARol = new DARol(paisID);
            return DARol.DelRol(RolID);
        }

        public int VerifyRolByDescripcion(BERol rol)
        {
            var DARol = new DARol(rol.PaisID);
            return DARol.VerifyRolByDescripcion(rol);
        }

        public IList<BERol> GetRoles(int paisID)
        {
            var roles = new List<BERol>();
            var DARol = new DARol(paisID);

            using (IDataReader reader = DARol.GetAllRols())
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
            var DARol = new DARol(paisID);

            using (IDataReader reader = DARol.GetAllRolsBySistema(sistema))
                while (reader.Read())
                {
                    var rol = new BERol(reader);
                    roles.Add(rol);
                }
            return roles;
        }
    }
}
