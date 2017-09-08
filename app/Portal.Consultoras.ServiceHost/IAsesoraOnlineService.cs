using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace Portal.Consultoras.ServiceHost
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IAsesoraOnlineService" in both code and config file together.
    [ServiceContract]
    public interface IAsesoraOnlineService
    {
        [OperationContract]
        void DoWork();
    }
}
