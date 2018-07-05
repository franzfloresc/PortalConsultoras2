using OpenSource.Library.DataAccess;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPaging
    {
        [DataMember]
        [ViewProperty]
        public int PageNumber { get; set; }

        [DataMember]
        [ViewProperty]
        public int RowsCount { get; set; }

        [DataMember]
        [ViewProperty]
        public int TotalPages { get; set; }
    }
}