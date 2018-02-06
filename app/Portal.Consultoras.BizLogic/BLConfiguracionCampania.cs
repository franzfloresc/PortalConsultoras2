namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System.Data;

    public class BLConfiguracionCampania
    {
        public BEConfiguracionCampania GetCampaniaActualByZona(int paisID, string codigoZona)
        {
            BEConfiguracionCampania configuracion = null;

            var daConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = daConfiguracionCampania.GetCampaniaActualByZona(codigoZona))
                if (reader.Read())
                {
                    configuracion = new BEConfiguracionCampania(reader);
                }

            return configuracion;
        }

        public BEConfiguracionCampania GetConfiguracionCampaniaZona(int paisID, int zonaID, int regionID, long consultoraID)
        {
            BEConfiguracionCampania beConfiguracionCampania = null;
            DAConfiguracionCampania daConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampaniaZona(paisID, zonaID, regionID, consultoraID))
                if (reader.Read())
                    beConfiguracionCampania = new BEConfiguracionCampania(reader);

            return beConfiguracionCampania;
        }
    }
}