using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Common.Exceptions
{
    [Serializable]
    public class ClientInformationException : System.Exception
    {
        public ClientInformationException() : base()
        {
        }

        public ClientInformationException(string message) : base(message)
        {
        }

        public ClientInformationException(string message, Exception inner) : base(message, inner)
        {
        }
        protected ClientInformationException(
            SerializationInfo info,
            StreamingContext context) : base(info, context)
        {
        }
    }
}