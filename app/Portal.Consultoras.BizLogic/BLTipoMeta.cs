namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System.Collections.Generic;
    using System.Data;

    public class BLTipoMeta
    {
        public List<BETipoMeta> GetTipoMeta(int paisID)
        {
            List<BETipoMeta> listaTipoMeta = new List<BETipoMeta>();

            var daTipoMeta = new DATipoMeta(paisID);
            using (IDataReader reader = daTipoMeta.GetTipoMeta())
            {
                while (reader.Read())
                {
                    listaTipoMeta.Add(new BETipoMeta(reader));
                }
            }
            return listaTipoMeta;
        }

        public BETipoMeta GetTipoMetaPorCodigo(int paisID, string codigoMeta)
        {
            BETipoMeta beTipoMeta = new BETipoMeta();
            DATipoMeta daTipoMeta = new DATipoMeta(paisID);

            using (IDataReader reader = daTipoMeta.GetTipoMetaPorCodigo(codigoMeta))
            {
                while (reader.Read())
                {
                    beTipoMeta = new BETipoMeta(reader);
                }
            }

            return beTipoMeta;
        }
    }
}