namespace Portal.Consultoras.BizLogic
{
    using Portal.Consultoras.Data;
    using Portal.Consultoras.Entities;
    using System.Collections.Generic;
    using System.Data;

    public class BLConfiguracionPortal
    {

        public BEConfiguracionPortal ObtenerConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            BEConfiguracionPortal beConfiguracionPortal = null;
            var daDaConfiguracionPortal = new DAConfiguracionPortal(beoConfiguracionPortal.PaisID);

            using (IDataReader reader = daDaConfiguracionPortal.ObtenerConfiguracionPortal(beoConfiguracionPortal.PaisID))
                if (reader.Read())
                {
                    beConfiguracionPortal = new BEConfiguracionPortal(reader);
                }

            return beConfiguracionPortal;
        }

        public int ActualizarConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            var daDaConfiguracionPortal = new DAConfiguracionPortal(beoConfiguracionPortal.PaisID);

            return daDaConfiguracionPortal.ActualizarConfiguracionPortal(beoConfiguracionPortal);
        }

        public IList<BEConfiguracionPortal> GetConfiguracionPortal(int paisID)
        {
            var lista = new List<BEConfiguracionPortal>();
            var daConfiguracionPortal = new DAConfiguracionPortal(paisID);

            using (IDataReader reader = daConfiguracionPortal.ObtenerConfiguracionPortal(paisID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionPortal(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public List<BEConfiguracionPackNuevas> ObtenerConfiguracionPackNuevas(int paisID, string CodigoPrograma)
        {
            List<BEConfiguracionPackNuevas> configuracionesPackNuevas = new List<BEConfiguracionPackNuevas>();
            DAConfiguracionPortal da = new DAConfiguracionPortal(paisID);
            using (IDataReader reader = da.ObtenerConfiguracionPackNueva(CodigoPrograma))
            {
                while (reader.Read())
                {
                    BEConfiguracionPackNuevas entidad = new BEConfiguracionPackNuevas(reader);
                    configuracionesPackNuevas.Add(entidad);
                }
            }
            return configuracionesPackNuevas;
        }

    }
}
