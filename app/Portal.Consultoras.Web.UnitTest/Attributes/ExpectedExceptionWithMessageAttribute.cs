using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.UnitTest.Attributes
{
    public class ExpectedExceptionWithMessageAttribute : ExpectedExceptionBaseAttribute
    {
        public Type ExceptionType { get; set; }

        public string ExpectedMessage { get; set; }

        public ExpectedExceptionWithMessageAttribute(Type exceptionType)
        {
            this.ExceptionType = exceptionType;
        }

        public ExpectedExceptionWithMessageAttribute(Type exceptionType, string expectedMessage)
        {
            this.ExceptionType = exceptionType;

            this.ExpectedMessage = expectedMessage;
        }

        protected override void Verify(Exception e)
        {
            var exception = e;
            if(e.GetType() == typeof(AggregateException))
            {
                exception = e.InnerException;
            }
            if (exception.GetType() != this.ExceptionType)
            {
                Assert.Fail(String.Format(
                                "ExpectedExceptionWithMessageAttribute failed. Expected exception type: {0}. Actual exception type: {1}. Exception message: {2}",
                                this.ExceptionType.FullName,
                                exception.GetType().FullName,
                                exception.Message
                                )
                            );
            }

            var actualMessage = exception.Message.Trim();

            if (this.ExpectedMessage != null)
            {
                Assert.AreEqual(this.ExpectedMessage, actualMessage);
            }

            Console.Write("ExpectedExceptionWithMessageAttribute:" + exception.Message);
        }
    }
}
