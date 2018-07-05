using System.Configuration;

namespace Portal.Consultoras.Data
{
    public class DataAccessConfiguration : ConfigurationSection
    {
        [ConfigurationProperty("Countries")]
        public DataAccessElementCollection Countries
        {
            get { return (DataAccessElementCollection)base["Countries"]; }
        }
    }

    [ConfigurationCollection(typeof(DataAccessElement))]
    public class DataAccessElementCollection : ConfigurationElementCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new DataAccessElement();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return (element as DataAccessElement).PaisID;
        }

        public DataAccessElement this[int index]
        {
            get
            {
                return (DataAccessElement)BaseGet((object)index);
            }
        }
    }

    public class DataAccessElement : ConfigurationElement
    {
        [ConfigurationProperty("key", IsKey = true, IsRequired = true)]
        public int PaisID
        {
            get { return (int)this["key"]; }
        }

        [ConfigurationProperty("dbname", IsRequired = true)]
        public string DbName
        {
            get { return (string)this["dbname"]; }
        }

        [ConfigurationProperty("odsname", IsRequired = true)]
        public string OdsName
        {
            get { return (string)this["odsname"]; }
        }

        [ConfigurationProperty("ddname", IsRequired = true)]
        public string DDName
        {
            get { return (string)this["ddname"]; }
        }

        [ConfigurationProperty("opName", IsRequired = true)]
        public string OPName
        {
            get { return (string)this["opName"]; }
        }

        [ConfigurationProperty("cachename", IsRequired = true)]
        public string CacheName
        {
            get { return (string)this["cachename"]; }
        }

        [ConfigurationProperty("ocwpedca", IsRequired = false)]
        public string OrderHeaderTemplate
        {
            get { return (string)this["ocwpedca"]; }
        }

        [ConfigurationProperty("ocwpedde", IsRequired = false)]
        public string OrderDetailTemplate
        {
            get { return (string)this["ocwpedde"]; }
        }

        [ConfigurationProperty("ocwpedcli", IsRequired = false)]
        public string OrderClienteTemplate
        {
            get { return (string)this["ocwpedcli"]; }
        }

        [ConfigurationProperty("actdatos", IsRequired = false)]
        public string ActDatosTemplate
        {
            get { return (string)this["actdatos"]; }
        }

        [ConfigurationProperty("ocwsolcre", IsRequired = false)]
        public string SolCreditoTemplate
        {
            get { return (string)this["ocwsolcre"]; }
        }

        [ConfigurationProperty("ocwsolact", IsRequired = false)]
        public string SolActualizacionTemplate
        {
            get { return (string)this["ocwsolact"]; }
        }

        [ConfigurationProperty("consuflex", IsRequired = false)]
        public string ConsuFlexTemplate
        {
            get { return (string)this["consuflex"]; }
        }

        [ConfigurationProperty("letcurso", IsRequired = false)]
        public string LetCursoTemplate
        {
            get { return (string)this["letcurso"]; }
        }

        [ConfigurationProperty("consdig", IsRequired = false)]
        public string ConsDigTemplate
        {
            get { return (string)this["consdig"]; }
        }
    }
}