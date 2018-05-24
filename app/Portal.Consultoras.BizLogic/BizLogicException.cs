using System;

namespace Portal.Consultoras.BizLogic
{
    public class BizLogicException : Exception
    {
        public BizLogicException(string message)
            : base(message)
        {
        }

        public BizLogicException(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }
}