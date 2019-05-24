namespace Portal.Consultoras.Web.Models.Estrategia
{
    using System;

    [Serializable]
    public class MSPersonalizacionConfiguracionModel
    {

        public MSPersonalizacionConfiguracionModel()
        {
            EstrategiaHabilitado = "";
            PaisHabilitado = "";
            GuardaDataEnLocalStorage = "";
            GuardaDataEnSession = "";
        }

        public string EstrategiaHabilitado { get; set; }
        public string PaisHabilitado { get; set; }

        public string GuardaDataEnLocalStorage { get; set; }
        public string GuardaDataEnSession { get; set; }
        public string EstrategiaDisponibleParaFicha { get; set; }
    }
}