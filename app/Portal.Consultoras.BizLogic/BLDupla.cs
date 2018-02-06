using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLDupla
    {
        public BEDupla Select(int paisID, string codigoUsuario)
        {
            BEDupla dupla = null;
            var daDupla = new DADupla(paisID);
            using (IDataReader reader = daDupla.GetDupla(codigoUsuario))
                if (reader.Read())
                {
                    dupla = new BEDupla(reader) {PaisID = paisID};
                }
            return dupla;
        }

        public void Insert(BEDupla dupla)
        {
            var daDupla = new DADupla(dupla.PaisID);
            daDupla.InsDupla(dupla);
        }

        public void Update(BEDupla dupla)
        {
            var daDupla = new DADupla(dupla.PaisID);
            daDupla.UpdDupla(dupla);
        }
    }
}