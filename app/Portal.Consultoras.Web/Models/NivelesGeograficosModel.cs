namespace Portal.Consultoras.Web.Models
{
    public class NivelesGeograficosModel
    {
        public string CodigoISO { get; set; }
        //TODO: Pendiente definir las propiedades de los niveles geograficos
        public string REG { set; get; }
        public string ZONA { set; get; }
        public string SECC { set; get; }
        public string TERRITO { set; get; }
        public string UBIGEO { set; get; }
        public string PROVINCIA { set; get; }
        public string CANTON { set; get; }
        public string DISTRITO { set; get; }
        public string CORREGIMIENTO { set; get; }
        public string BARRIO_COLONIA_URBANIZACION_REFERENCIAS { set; get; }
        public string BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS { set; get; }
        public string BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS { set; get; }
        public string DEPARTAMENTO { set; get; }
        public string MUNICIPIO { set; get; }
        public string CANTON_CENTRO_POBLADO { set; get; }
        public string CENTRO_POBLADO { get; set; }

        public string ZONA_CIUDAD { get; set; }
        public string sidx { get; set; }
        public string sord { get; set; }
        public int page { get; set; }
        public int rows { get; set; }
    }
}