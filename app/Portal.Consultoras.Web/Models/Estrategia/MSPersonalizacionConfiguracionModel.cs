namespace Portal.Consultoras.Web.Models.Estrategia
{
    using System;
    using System.Collections.Generic;

    [Serializable]
    public class MSPersonalizacionConfiguracionModel
    {
        public string EstrategiaHabilitado { get; set; }
        public string PaisHabilitado { get; set; }

        public string GuardaDataEnLocalStorage { get; set; }
        public string GuardaDataEnSession { get; set; }

    }
}