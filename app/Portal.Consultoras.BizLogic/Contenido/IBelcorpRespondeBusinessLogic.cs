using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IBelcorpRespondeBusinessLogic
    {
        IList<BEBelcorpResponde> GetBelcorpResponde(int paisID);        
    }
}
