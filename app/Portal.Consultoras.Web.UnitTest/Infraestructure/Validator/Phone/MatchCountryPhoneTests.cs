using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Infraestructure.Validator.Phone;

namespace Portal.Consultoras.Web.UnitTest.Infraestructure.Validator.Phone
{
    [TestClass]
    public class MatchCountryPhoneTests
    {
        readonly MatchCountryPhone _validator = new MatchCountryPhone();

        [TestMethod]
        [DataRow(Constantes.PaisID.Peru,                "990011514")]
        [DataRow(Constantes.PaisID.Mexico,              "9900115140")]
        [DataRow(Constantes.PaisID.Ecuador,             "9900115141")]
        [DataRow(Constantes.PaisID.Colombia,            "9900115141")]
        [DataRow(Constantes.PaisID.Chile,               "990011514000000")]
        [DataRow(Constantes.PaisID.Bolivia,             "990011514000000")]
        [DataRow(Constantes.PaisID.PuertoRico,          "990011514000000")]
        [DataRow(Constantes.PaisID.RepublicaDominicana, "990011514000000")]
        [DataRow(Constantes.PaisID.CostaRica,           "99001151")]
        [DataRow(Constantes.PaisID.Guatemala,           "99001151")]
        [DataRow(Constantes.PaisID.Panama,              "99001151")]
        [DataRow(Constantes.PaisID.ElSalvador,          "99001151")]
        public void ValidPhoneSuccessTest(int paisId, string number)
        {
            _validator.PaisId = paisId;
            var result = _validator.Valid(number);
            result.Wait();

            Assert.IsTrue(result.Result.Success);
        }

        [TestMethod]
        [DataRow(Constantes.PaisID.Peru,       "777")]
        [DataRow(Constantes.PaisID.Mexico,     "777")]
        [DataRow(Constantes.PaisID.Ecuador,    "777")]
        [DataRow(Constantes.PaisID.Chile,      "777")]
        [DataRow(Constantes.PaisID.Bolivia,    "777")]
        [DataRow(Constantes.PaisID.Colombia,   "777")]
        [DataRow(Constantes.PaisID.PuertoRico, "777")]
        [DataRow(Constantes.PaisID.Guatemala,  "777")]
        [DataRow(Constantes.PaisID.Panama,     "777")]
        [DataRow(Constantes.PaisID.ElSalvador, "777")]
        [DataRow(Constantes.PaisID.ElSalvador, null)]
        [DataRow(Constantes.PaisID.ElSalvador, "")]
        [DataRow(Constantes.PaisID.ElSalvador, "+44XX")]
        public void ValidPhoneErrorTest(int paisId, string number)
        {
            _validator.PaisId = paisId;
            var result = _validator.Valid(number);
            result.Wait();

            Assert.IsFalse(result.Result.Success);
        }
    }
}