using System;

namespace Portal.Consultoras.Common
{
    public class CustomTraceException : Exception
    {
        readonly string _stackTrace;

        public CustomTraceException(string message, string stackTrace) : base(message)
        {
            _stackTrace = stackTrace;
        }

        public override string StackTrace { get { return _stackTrace; } }
    }
}