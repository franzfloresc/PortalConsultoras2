using OpenSource.Library.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPaging
    {
        private int PageNumber_;
        private int RowsCount_;
        private int TotalPages_;

        [DataMember]
        [ViewProperty]
        public int PageNumber
        {
            get { return PageNumber_; }
            set { PageNumber_ = value; }
        }

        [DataMember]
        [ViewProperty]
        public int RowsCount
        {
            get { return RowsCount_; }
            set { RowsCount_ = value; }
        }

        [DataMember]
        [ViewProperty]
        public int TotalPages
        {
            get { return TotalPages_; }
            set { TotalPages_ = value; }
        }
    }
}