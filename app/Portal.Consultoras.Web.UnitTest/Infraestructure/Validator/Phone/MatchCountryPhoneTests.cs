using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Infraestructure.Validator.Phone;

namespace Portal.Consultoras.Web.UnitTest.Infraestructure.Validator.Phone
{
    [TestClass]
    public class MatchCountryPhoneTests
    {
        readonly MatchCountryPhone _validator = new MatchCountryPhone();

        [TestMethod]
        [DataRow("PE", "990011514")]
        [DataRow("MX", "990011514000000")]
        [DataRow("EC", "9900115141")]
        [DataRow("CL", "990011514000000")]
        [DataRow("BO", "990011514000000")]
        [DataRow("PR", "990011514000000")]
        [DataRow("DO", "990011514000000")]
        [DataRow("CR", "99001151")]
        [DataRow("GT", "99001151")]
        [DataRow("PA", "99001151")]
        [DataRow("SV", "99001151")]
        public void ValidPhoneSuccessTest(string isoPais, string number)
        {
            _validator.IsoPais = isoPais;
            var result = _validator.Valid(number);
            result.Wait();

            Assert.IsTrue(result.Result.Success);
        }

        [TestMethod]
        [DataRow("PE", "777")]
        [DataRow("MX", "777")]
        [DataRow("EC", "777")]
        [DataRow("CL", "777")]
        [DataRow("BO", "777")]
        [DataRow("PR", "777")]
        [DataRow("DO", "777")]
        [DataRow("CR", "777")]
        [DataRow("GT", "777")]
        [DataRow("PA", "777")]
        [DataRow("SV", "777")]
        [DataRow("SV", null)]
        [DataRow("SV", "")]
        [DataRow("SV", "+44XX")]
        public void ValidPhoneErrorTest(string isoPais, string number)
        {
            _validator.IsoPais = isoPais;
            var result = _validator.Valid(number);
            result.Wait();

            Assert.IsFalse(result.Result.Success);
        }

        [TestMethod]
        public void ValidPhoneNotConfiguredTest()
        {
            _validator.IsoPais = "MN";
            var result = _validator.Valid("12");
            result.Wait();
            
            Assert.IsFalse(result.Result.Success);
            Assert.IsTrue(result.Result.ErrorMessage.Contains("no configurado"));
        }
    }
}