namespace Portal.Consultoras.BizLogic
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Data;
    using Portal.Consultoras.Entities;
    using Portal.Consultoras.Data;
    using System.Transactions;

    public class BLConfiguracionPortal
    {

        public BEConfiguracionPortal ObtenerConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            BEConfiguracionPortal beConfiguracionPortal = null;
            var daDAConfiguracionPortal = new DAConfiguracionPortal(beoConfiguracionPortal.PaisID);

            using (IDataReader reader = daDAConfiguracionPortal.ObtenerConfiguracionPortal(beoConfiguracionPortal.PaisID))
                if (reader.Read())
                {
                    beConfiguracionPortal = new BEConfiguracionPortal(reader);
                }

            return beConfiguracionPortal;
        }

        public int ActualizarConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            var daDAConfiguracionPortal = new DAConfiguracionPortal(beoConfiguracionPortal.PaisID);

            return daDAConfiguracionPortal.ActualizarConfiguracionPortal(beoConfiguracionPortal);
        }

        public IList<BEConfiguracionPortal> GetConfiguracionPortal(int paisID)
        {
            var lista = new List<BEConfiguracionPortal>();
            var DAConfiguracionPortal = new DAConfiguracionPortal(paisID);

            using (IDataReader reader = DAConfiguracionPortal.ObtenerConfiguracionPortal(paisID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionPortal(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public List<BEConfiguracionPackNuevas> ObtenerConfiguracionPackNuevas(int paisID, string CodigoPrograma)
        {
            List<BEConfiguracionPackNuevas> ConfiguracionesPackNuevas = new List<BEConfiguracionPackNuevas>();
            DAConfiguracionPortal da = new DAConfiguracionPortal(paisID);
            using (IDataReader reader = da.ObtenerConfiguracionPackNueva(CodigoPrograma))
            {
                while (reader.Read())
                {
                    BEConfiguracionPackNuevas entidad = new BEConfiguracionPackNuevas(reader);
                    ConfiguracionesPackNuevas.Add(entidad);
                }
            }
            return ConfiguracionesPackNuevas;
        }

    }
}
