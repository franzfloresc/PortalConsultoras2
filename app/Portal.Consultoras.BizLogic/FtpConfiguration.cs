using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    public class FtpConfigurationSection : ConfigurationSection
    {
        [ConfigurationProperty("ftpConfigurations")]
        public FtpConfigurationElementCollection FtpConfigurations
        {
            get { return (FtpConfigurationElementCollection)base["ftpConfigurations"]; }
        }
    }

    [ConfigurationCollection(typeof(FtpConfigurationElement))]
    public class FtpConfigurationElementCollection : ConfigurationElementCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new FtpConfigurationElement();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return (element as FtpConfigurationElement).Key;
        }

        public FtpConfigurationElement this[string key]
        {
            get
            {
                return (FtpConfigurationElement)BaseGet(key);
            }
        }
    }

    public class FtpConfigurationElement : ConfigurationElement
    {
        [ConfigurationProperty("key", IsKey = true, IsRequired = true)]
        public string Key
        {
            get { return (string)this["key"]; }
        }

        [ConfigurationProperty("address", IsRequired = true)]
        public string Address
        {
            get { return (string)this["address"]; }
        }

        [ConfigurationProperty("user", IsRequired = true)]
        public string UserName
        {
            get { return (string)this["user"]; }
        }

        [ConfigurationProperty("password", IsRequired = true)]
        public string Password
        {
            get { return (string)this["password"]; }
        }

        [ConfigurationProperty("header", IsRequired = true)]
        public string Header
        {
            get { return (string)this["header"]; }
        }

        [ConfigurationProperty("detail", IsRequired = false)]
        public string Detail
        {
            get { return (string)this["detail"]; }
        }

        [ConfigurationProperty("client", IsRequired = false)]
        public string Client
        {
            get { return (string)this["client"]; }
        }

    }
}
