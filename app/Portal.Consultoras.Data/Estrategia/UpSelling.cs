using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Estrategia
{
    public class UpSelling : DataAccess
    {
        public UpSelling(int paisId) : base(paisId, EDbSource.Portal)
        {}


    }
}
