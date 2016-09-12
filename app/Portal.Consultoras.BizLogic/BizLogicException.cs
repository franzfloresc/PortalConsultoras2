using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BizLogicException : Exception
    {
        //private int state;

        public BizLogicException(string message)
            : base(message)
        {
            //this.state = state;
        }

        public BizLogicException(string message, Exception innerException)
            : base(message, innerException)
        {
            //this.state = state;
        }

        //public int State
        //{
        //    get { return state; }
        //}
    }
}
