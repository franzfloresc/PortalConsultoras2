using MaxMind.Db;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.Security.Permissions;

namespace MaxMind.Util
{
    /// <summary>
    ///     Instances of this class provide a reader for the GeoIP2 database format
    /// </summary>
    public class DatabaseReader : IDisposable
    {
        private bool _disposed;
        private readonly IEnumerable<string> _locales;
        private readonly Reader _reader;

        /// <summary>
        ///     Initializes a new instance of the <see cref="DatabaseReader" /> class.
        /// </summary>
        /// <param name="file">The MaxMind DB file.</param>
        /// <param name="mode">The mode by which to access the DB file.</param>
        public DatabaseReader(string file, FileAccessMode mode = FileAccessMode.MemoryMapped)
            : this(file, new List<string> { "en" }, mode)
        {
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="DatabaseReader" /> class.
        /// </summary>
        /// <param name="file">The MaxMind DB file.</param>
        /// <param name="locales">List of locale codes to use in name property from most preferred to least preferred.</param>
        /// <param name="mode">The mode by which to access the DB file.</param>
        public DatabaseReader(string file, IEnumerable<string> locales,
            FileAccessMode mode = FileAccessMode.MemoryMapped)
        {
            _locales = new List<string>(locales);
            _reader = new Reader(file, mode);
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="DatabaseReader" /> class.
        /// </summary>
        /// <param name="stream">A stream of the MaxMind DB file.</param>
        public DatabaseReader(Stream stream)
            : this(stream, new List<string> { "en" })
        {
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="DatabaseReader" /> class.
        /// </summary>
        /// <param name="stream">A stream of the MaxMind DB file.</param>
        /// <param name="locales">List of locale codes to use in name property from most preferred to least preferred.</param>
        public DatabaseReader(Stream stream, IEnumerable<string> locales)
        {
            _locales = new List<string>(locales);
            _reader = new Reader(stream);
        }

        /// <summary>
        ///     The metadata for the open MaxMind DB file.
        /// </summary>
        public Metadata Metadata
        {
            get { return _reader.Metadata; }
        }

        /// <summary>
        ///     Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        ///     Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (_disposed)
                return;

            if (disposing)
            {
                _reader.Dispose();
            }

            _disposed = true;
        }

        /// <summary>
        ///     Returns an <see cref="CountryResponse" /> for the specified IP address.
        /// </summary>
        /// <param name="ipAddress">The IP address.</param>
        /// <returns>An <see cref="CountryResponse" /></returns>
        public CountryResponse Country(IPAddress ipAddress)
        {
            return Execute<CountryResponse>(ipAddress, "Country");
        }

        /// <summary>
        ///     Returns an <see cref="CountryResponse" /> for the specified IP address.
        /// </summary>
        /// <param name="ipAddress">The IP address.</param>
        /// <returns>An <see cref="CountryResponse" /></returns>
        public CountryResponse Country(string ipAddress)
        {
            return Execute<CountryResponse>(ipAddress, "Country");
        }

        /// <summary>
        ///     Tries to lookup a <see cref="CountryResponse" /> for the specified IP address.
        /// </summary>
        /// <param name="ipAddress">The IP address.</param>
        /// <param name="response">The <see cref="CountryResponse" />.</param>
        /// <returns>A <see cref="bool" /> describing whether the IP address was found.</returns>
        public bool TryCountry(IPAddress ipAddress, out CountryResponse response)
        {
            response = Execute<CountryResponse>(ipAddress, "Country", false);
            return response != null;
        }

        /// <summary>
        ///     Tries to lookup a <see cref="CountryResponse" /> for the specified IP address.
        /// </summary>
        /// <param name="ipAddress">The IP address.</param>
        /// <param name="response">The <see cref="CountryResponse" />.</param>
        /// <returns>A <see cref="bool" /> describing whether the IP address was found.</returns>
        public bool TryCountry(string ipAddress, out CountryResponse response)
        {
            response = Execute<CountryResponse>(ipAddress, "Country", false);
            return response != null;
        }

        private T Execute<T>(string ipStr, string type, bool throwOnNullResponse = true) where T : AbstractResponse
        {
            IPAddress ip = null;
            if (ipStr != null && !IPAddress.TryParse(ipStr, out ip))
                throw new GeoIP2Exception(string.Format("The specified IP address was incorrectly formatted: {0}", ipStr));
            return Execute<T>(ipStr, ip, type, throwOnNullResponse);
        }

        private T Execute<T>(IPAddress ipAddress, string type, bool throwOnNullResponse = true)
            where T : AbstractResponse
        {
            return Execute<T>(ipAddress.ToString(), ipAddress, type, throwOnNullResponse);
        }

        private T Execute<T>(string ipStr, IPAddress ipAddress, string type, bool throwOnNullResponse = true)
            where T : AbstractResponse
        {
            if (!Metadata.DatabaseType.Contains(type))
            {
                var frame = new StackFrame(2, true);
                throw new InvalidOperationException(
                    string.Format("A {0} database cannot be opened with the {1} method", Metadata.DatabaseType, frame.GetMethod().Name));
            }

            var injectables = new InjectableValues();
            injectables.AddValue("ip_address", ipStr);
            var response = _reader.Find<T>(ipAddress, injectables);

            if (response == null)
            {
                if (throwOnNullResponse)
                {
                    throw new AddressNotFoundException("The address " + ipStr + " is not in the database.");
                }
                return null;
            }

            response.SetLocales(_locales);

            return response;
        }
    }

    [Serializable]
    public class AddressNotFoundException : GeoIP2Exception
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AddressNotFoundException" /> class.
        /// </summary>
        /// <param name="message">A message explaining the cause of the error.</param>
        public AddressNotFoundException(string message)
            : base(message)
        {
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="AddressNotFoundException" /> class.
        /// </summary>
        /// <param name="message">A message explaining the cause of the error.</param>
        /// <param name="innerException">The inner exception.</param>
        public AddressNotFoundException(string message, Exception innerException)
            : base(message, innerException)
        {
        }

        /// <summary>
        ///     Constructor for deserialization.
        /// </summary>
        /// <param name="info">The SerializationInfo with data.</param>
        /// <param name="context">The source for this deserialization.</param>
        [SecurityPermission(SecurityAction.Demand, SerializationFormatter = true)]
        protected AddressNotFoundException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }
    }

    [Serializable]
    public class GeoIP2Exception : ApplicationException
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="GeoIP2Exception" /> class.
        /// </summary>
        /// <param name="message">A message that describes the error.</param>
        public GeoIP2Exception(string message)
            : base(message)
        {
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="GeoIP2Exception" /> class.
        /// </summary>
        /// <param name="message">A message that describes the error.</param>
        /// <param name="innerException">The inner exception.</param>
        public GeoIP2Exception(string message, Exception innerException)
            : base(message, innerException)
        {
        }

        /// <summary>
        ///     Constructor for deserialization.
        /// </summary>
        /// <param name="info">The SerializationInfo with data.</param>
        /// <param name="context">The source for this deserialization.</param>
        [SecurityPermission(SecurityAction.Demand, SerializationFormatter = true)]
        protected GeoIP2Exception(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }
    }

    public class CountryResponse : AbstractCountryResponse
    {
        /// <summary>
        ///     Constructor
        /// </summary>
        public CountryResponse()
        {
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        public CountryResponse(
            Continent continent = null,
            Country country = null,
            [Parameter("maxmind")] MaxMind maxMind = null,
            Country registeredCountry = null,
            [Parameter("represented_country")] RepresentedCountry representedCountry = null,
            [Parameter("traits", true)] Traits traits = null
            )
            : base(continent, country, maxMind, registeredCountry, representedCountry, traits)
        {
        }
    }

    public abstract class AbstractCountryResponse : AbstractResponse
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AbstractCountryResponse" /> class.
        /// </summary>
        protected AbstractCountryResponse()
        {
            Continent = new Continent();
            Country = new Country();
            MaxMind = new MaxMind();
            RegisteredCountry = new Country();
            RepresentedCountry = new RepresentedCountry();
            Traits = new Traits();
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="AbstractCountryResponse" /> class.
        /// </summary>
        protected AbstractCountryResponse(Continent continent = null, Country country = null,
            MaxMind maxMind = null,
            Country registeredCountry = null, RepresentedCountry representedCountry = null, Traits traits = null)
        {
            Continent = continent ?? new Continent();
            Country = country ?? new Country();
            MaxMind = maxMind ?? new MaxMind();
            RegisteredCountry = registeredCountry ?? new Country();
            RepresentedCountry = representedCountry ?? new RepresentedCountry();
            Traits = traits ?? new Traits();
        }

        /// <summary>
        ///     Gets the continent for the requested IP address.
        /// </summary>
        [JsonProperty("continent")]
        public Continent Continent { get; internal set; }

        /// <summary>
        ///     Gets the country for the requested IP address. This
        ///     object represents the country where MaxMind believes
        ///     the end user is located
        /// </summary>
        [JsonProperty("country")]
        public Country Country { get; internal set; }

        /// <summary>
        ///     Gets the MaxMind record containing data related to your account
        /// </summary>
        [JsonProperty("maxmind")]
        public MaxMind MaxMind { get; internal set; }

        /// <summary>
        ///     Registered country record for the requested IP address. This
        ///     record represents the country where the ISP has registered a
        ///     given IP block and may differ from the user's country.
        /// </summary>
        [JsonProperty("registered_country")]
        public Country RegisteredCountry { get; internal set; }

        /// <summary>
        ///     Represented country record for the requested IP address. The
        ///     represented country is used for things like military bases or
        ///     embassies. It is only present when the represented country
        ///     differs from the country.
        /// </summary>
        [JsonProperty("represented_country")]
        public RepresentedCountry RepresentedCountry { get; internal set; }

        /// <summary>
        ///     Gets the traits for the requested IP address.
        /// </summary>
        [JsonProperty("traits")]
        public Traits Traits { get; internal set; }

        /// <summary>
        ///     Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <returns>
        ///     A <see cref="string" /> that represents this instance.
        /// </returns>
        public override string ToString()
        {
            return GetType().Name + " ["
                   + (Continent != null ? "Continent=" + Continent + ", " : "")
                   + (Country != null ? "Country=" + Country + ", " : "")
                   + (RegisteredCountry != null ? "RegisteredCountry=" + RegisteredCountry + ", " : "")
                   + (RepresentedCountry != null ? "RepresentedCountry=" + RepresentedCountry + ", " : "")
                   + (Traits != null ? "Traits=" + Traits : "")
                   + "]";
        }

        /// <summary>
        ///     Sets the locales on all the NamedEntity properties.
        /// </summary>
        /// <param name="locales">The locales specified by the user.</param>
        protected internal override void SetLocales(IEnumerable<string> locales)
        {
            locales = locales.ToList();
            if (Continent != null)
                Continent.Locales = locales;

            if (Country != null)
                Country.Locales = locales;

            if (RegisteredCountry != null)
                RegisteredCountry.Locales = locales;

            if (RepresentedCountry != null)
                RepresentedCountry.Locales = locales;
        }
    }

    public abstract class AbstractResponse
    {
        /// <summary>
        ///     This is simplify the database API. Also, we may need to use the locales in the future.
        /// </summary>
        /// <param name="locales"></param>
        protected internal virtual void SetLocales(IEnumerable<string> locales)
        {
        }
    }

    public class MaxMind
    {
        /// <summary>
        ///     Constructor
        /// </summary>
        public MaxMind()
        {
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        public MaxMind([Parameter("queries_remaining")] int? queriesRemaining = null)
        {
            QueriesRemaining = queriesRemaining;
        }

        /// <summary>
        ///     The number of remaining queried in your account for the web
        ///     service end point. This will be null when using a local
        ///     database.
        /// </summary>
        [JsonProperty("queries_remaining")]
        public int? QueriesRemaining { get; internal set; }

        /// <summary>
        ///     Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <returns>
        ///     A <see cref="string" /> that represents this instance.
        /// </returns>
        public override string ToString()
        {
            return string.Format("MaxMind [ QueriesRemaining={0} ]", QueriesRemaining);
        }
    }

    public class Country : NamedEntity
    {
        /// <summary>
        ///     Constructor
        /// </summary>
        public Country()
        {
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        public Country(int? confidence = null, int? geoNameId = null, string isoCode = null,
            IDictionary<string, string> names = null, IEnumerable<string> locales = null)
            : base(geoNameId, names, locales)
        {
            Confidence = confidence;
            IsoCode = isoCode;
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        public Country(
            int? confidence = null,
            // See note in City model
            [Parameter("geoname_id")] long? geoNameId = null,
            [Parameter("iso_code")] string isoCode = null,
            IDictionary<string, string> names = null,
            IEnumerable<string> locales = null)
            : this(confidence, (int?)geoNameId, isoCode, names, locales)
        {
        }

        /// <summary>
        ///     A value from 0-100 indicating MaxMind's confidence that the country
        ///     is correct. This value is only set when using the Insights
        ///     web service or the Enterprise database.
        /// </summary>
        [JsonProperty("confidence")]
        public int? Confidence { get; internal set; }

        /// <summary>
        ///     The
        ///     <a
        ///         href="http://en.wikipedia.org/wiki/ISO_3166-1">
        ///         two-character ISO
        ///         3166-1 alpha code
        ///     </a>
        ///     for the country.
        /// </summary>
        [JsonProperty("iso_code")]
        public string IsoCode { get; internal set; }
    }

    public abstract class NamedEntity
    {
        [JsonProperty("names")]
        private IDictionary<string, string> _names;

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        protected NamedEntity(int? geoNameId = null, IDictionary<string, string> names = null,
            IEnumerable<string> locales = null)
        {
            Names = names != null ? new Dictionary<string, string>(names) : new Dictionary<string, string>();
            GeoNameId = geoNameId;
            Locales = locales != null ? new List<string>(locales) : new List<string> { "en" };
        }

        /// <summary>
        ///     A <see cref="System.Collections.Generic.Dictionary{T,U}" />
        ///     from locale codes to the name in that locale. Don't use any of
        ///     these names as a database or dictionary key. Use the
        ///     <see
        ///         cred="GeoNameId" />
        ///     or relevant code instead.
        /// </summary>
        [JsonIgnore]
        public Dictionary<string, string> Names
        {
            get { return new Dictionary<string, string>(_names); }
            internal set { _names = value; }
        }

        /// <summary>
        ///     The GeoName ID for the city.
        /// </summary>
        [JsonProperty("geoname_id")]
        public int? GeoNameId { get; internal set; }

        /// <summary>
        ///     Gets or sets the locales specified by the user.
        /// </summary>
        [JsonIgnore]
        protected internal IEnumerable<string> Locales { get; set; }

        /// <summary>
        ///     The name of the city based on the locales list passed to the
        ///     <see cref="WebServiceClient" /> constructor. Don't use any of
        ///     these names as a database or dictionary key. Use the
        ///     <see
        ///         cred="GeoNameId" />
        ///     or relevant code instead.
        /// </summary>
        [JsonIgnore]
        public string Name
        {
            get
            {

                var locale = Locales.FirstOrDefault(l => Names.ContainsKey(l));
                return locale == null ? null : Names[locale];
            }
        }

        /// <summary>
        ///     Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <returns>
        ///     A <see cref="string" /> that represents this instance.
        /// </returns>
        public override string ToString()
        {
            return Name ?? string.Empty;
        }
    }

    public class Continent : NamedEntity
    {
        /// <summary>
        ///     Constructor
        /// </summary>
        public Continent()
        {
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        public Continent(string code = null, int? geoNameId = null, IDictionary<string, string> names = null,
            IEnumerable<string> locales = null)
            : base(geoNameId, names, locales)
        {
            Code = code;
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        public Continent(
            string code = null,
            // See note in City model
            [Parameter("geoname_id")] long? geoNameId = null,
            IDictionary<string, string> names = null,
            IEnumerable<string> locales = null)
            : this(code, (int?)geoNameId, names, locales)
        {
        }

        /// <summary>
        ///     A two character continent code like "NA" (North America) or "OC"
        ///     (Oceania).
        /// </summary>
        [JsonProperty("code")]
        public string Code { get; internal set; }
    }
    public class RepresentedCountry : Country
    {
        /// <summary>
        ///     Constructor
        /// </summary>
        public RepresentedCountry()
        {
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        public RepresentedCountry(string type = null, int? confidence = null, int? geoNameId = null,
            string isoCode = null, IDictionary<string, string> names = null, IEnumerable<string> locales = null)
            : base(confidence, geoNameId, isoCode, names, locales)
        {
            Type = type;
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        public RepresentedCountry(
            string type = null,
            int? confidence = null,
            // See note in City model
            [Parameter("geoname_id")] long? geoNameId = null,
            [Parameter("iso_code")] string isoCode = null,
            IDictionary<string, string> names = null,
            IEnumerable<string> locales = null)
            : this(type, confidence, (int?)geoNameId, isoCode, names, locales)
        {
        }

        /// <summary>
        ///     A string indicating the type of entity that is representing the
        ///     country. Currently we only return <c>military</c> but this could
        ///     expand to include other types in the future.
        /// </summary>
        [JsonProperty("type")]
        public string Type { get; internal set; }
    }
    public class Traits
    {
        /// <summary>
        ///     Constructor
        /// </summary>
        public Traits()
        {
        }

        /// <summary>
        ///     Constructor
        /// </summary>
        [Constructor]
        public Traits(
            [Parameter("autonomous_system_number")] long? autonomousSystemNumber = null,
            [Parameter("autonomous_system_organization")] string autonomousSystemOrganization = null,
            [Parameter("connection_type")] string connectionType = null,
            string domain = null,
            [Inject("ip_address")] string ipAddress = null,
            [Parameter("is_anonymous_proxy")] bool isAnonymousProxy = false,
            [Parameter("is_legitimate_proxy")] bool isLegitimateProxy = false,
            [Parameter("is_satellite_provider")] bool isSatelliteProvider = false,
            string isp = null,
            string organization = null,
            [Parameter("user_type")] string userType = null)
        {
            // XXX - if we ever do a breaking release, this property should
            // be changes to long.
            AutonomousSystemNumber = (int?)autonomousSystemNumber;
            AutonomousSystemOrganization = autonomousSystemOrganization;
            ConnectionType = connectionType;
            Domain = domain;
            IPAddress = ipAddress;
#pragma warning disable 618
            IsAnonymousProxy = isAnonymousProxy;
            IsLegitimateProxy = isLegitimateProxy;
            IsSatelliteProvider = isSatelliteProvider;
#pragma warning restore 618
            Isp = isp;
            Organization = organization;
            UserType = userType;
        }

        /// <summary>
        ///     The
        ///     <a
        ///         href="http://en.wikipedia.org/wiki/Autonomous_system_(Internet)">
        ///         autonomous system number
        ///     </a>
        ///     associated with the IP address.
        ///     This value is only set when using the City or Insights web
        ///     service or the Enterprise database.
        /// </summary>
        [JsonProperty("autonomous_system_number")]
        public int? AutonomousSystemNumber { get; internal set; }

        /// <summary>
        ///     The organization associated with the registered
        ///     <a
        ///         href="http://en.wikipedia.org/wiki/Autonomous_system_(Internet)">
        ///         autonomous system number
        ///     </a>
        ///     for the IP address. This value is only set when using the City or
        ///     Insights web service or the Enterprise database.
        /// </summary>
        [JsonProperty("autonomous_system_organization")]
        public string AutonomousSystemOrganization { get; internal set; }

        /// <summary>
        ///     The connection type of the IP address. This value is only set when
        ///     using the Enterprise database.
        /// </summary>
        [JsonProperty("connection_type")]
        public string ConnectionType { get; internal set; }

        /// <summary>
        ///     The second level domain associated with the IP address. This will
        ///     be something like "example.com" or "example.co.uk", not
        ///     "foo.example.com". This value is only set when using the City or
        ///     Insights web service or the Enterprise database.
        /// </summary>
        [JsonProperty("domain")]
        public string Domain { get; internal set; }

        /// <summary>
        ///     The IP address that the data in the model is for. If you
        ///     performed a "me" lookup against the web service, this will be the
        ///     externally routable IP address for the system the code is running
        ///     on. If the system is behind a NAT, this may differ from the IP
        ///     address locally assigned to it.
        /// </summary>
        [JsonProperty("ip_address")]
        public string IPAddress { get; internal set; }

        /// <summary>
        ///     This is true if the IP is an anonymous proxy. See
        ///     <a href="http://dev.maxmind.com/faq/geoip#anonproxy">
        ///         MaxMind's GeoIP
        ///         FAQ
        ///     </a>
        /// </summary>
        [JsonProperty("is_anonymous_proxy")]
        [Obsolete("Use our GeoIP2 Anonymous IP database instead.")]
        public bool IsAnonymousProxy { get; internal set; }

        /// <summary>
        ///     True if MaxMind believes this IP address to be a legitimate
        ///     proxy, such as an internal VPN used by a corporation.This is only
        ///     available in the GeoIP2 Enterprise database.
        /// </summary>
        [JsonProperty("is_legitimate_proxy")]
        public bool IsLegitimateProxy { get; internal set; }

        /// <summary>
        ///     This is true if the IP belong to a satellite Internet provider.
        /// </summary>
        [JsonProperty("is_satellite_provider")]
        [Obsolete("Due to increased mobile usage, we have insufficient data to maintain this field.")]
        public bool IsSatelliteProvider { get; internal set; }

        /// <summary>
        ///     The name of the ISP associated with the IP address. This value
        ///     is only set when using the City or Insights web service or the
        ///     Enterprise database.
        /// </summary>
        [JsonProperty("isp")]
        public string Isp { get; internal set; }

        /// <summary>
        ///     The name of the organization associated with the IP address. This
        ///     value is only set when using the City or Insights web service or the
        ///     Enterprise database.
        /// </summary>
        [JsonProperty("organization")]
        public string Organization { get; internal set; }

        /// <summary>
        ///     The user type associated with the IP address. This can be one of
        ///     the following values:
        ///     <list type="bullet">
        ///         <item>
        ///             <description>business</description>
        ///         </item>
        ///         <item>
        ///             <description>cafe</description>
        ///         </item>
        ///         <item>
        ///             <description>cellular</description>
        ///         </item>
        ///         <item>
        ///             <description>college</description>
        ///         </item>
        ///         <item>
        ///             <description>content_delivery_network</description>
        ///         </item>
        ///         <item>
        ///             <description>dialup</description>
        ///         </item>
        ///         <item>
        ///             <description>government</description>
        ///         </item>
        ///         <item>
        ///             <description>hosting</description>
        ///         </item>
        ///         <item>
        ///             <description>library</description>
        ///         </item>
        ///         <item>
        ///             <description>military</description>
        ///         </item>
        ///         <item>
        ///             <description>residential</description>
        ///         </item>
        ///         <item>
        ///             <description>router</description>
        ///         </item>
        ///         <item>
        ///             <description>school</description>
        ///         </item>
        ///         <item>
        ///             <description>search_engine_spider</description>
        ///         </item>
        ///         <item>
        ///             <description>traveler</description>
        ///         </item>
        ///     </list>
        ///     This value is only set when using the City or Insights web service
        ///     or the Enterprise database.
        /// </summary>
        [JsonProperty("user_type")]
        public string UserType { get; internal set; }

        /// <summary>
        ///     Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <returns>
        ///     A <see cref="string" /> that represents this instance.
        /// </returns>
        public override string ToString()
        {
            return
                "AutonomousSystemNumber: " + AutonomousSystemNumber + ", " +
                "AutonomousSystemOrganization: " + AutonomousSystemOrganization + ", " +
                "ConnectionType: " + ConnectionType + ", Domain: " + Domain + ", IPAddress: " + IPAddress + "," +
#pragma warning disable 0618
 " IsAnonymousProxy: " + IsAnonymousProxy + ", IsLegitimateProxy: " + IsLegitimateProxy + ", " +
                "IsSatelliteProvider: " + IsSatelliteProvider + ", " +
#pragma warning restore 0618
 "Isp: " + Isp + ", Organization: " + Organization + ", UserType: " + UserType;
        }
    }
}