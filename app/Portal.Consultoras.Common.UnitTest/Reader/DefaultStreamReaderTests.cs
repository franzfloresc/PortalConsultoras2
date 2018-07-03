using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Common.Reader;

namespace Portal.Consultoras.Common.UnitTest.Reader
{
    [TestClass]
    public class DefaultStreamReaderTests
    {
        [TestMethod]
        public void ReadCsvTest()
        {
            var content = @"codigoConsultora
            213123
            444556
            677778";
            var items = GetElements(content);

            Assert.AreEqual(3, items.Length);
        }

        [TestMethod]
        public void ReadCsvWithComaTest()
        {
            var content = @"codigoConsultora
            213123,
            444556,
            677778,";
            var items = GetElements(content);

            Assert.AreEqual(3, items.Length);
        }

        [TestMethod]
        public void ReadCsvWithEmptyLinesTest()
        {
            var content = @"codigoConsultora
            213123
            444556
            677778


            ";
            var items = GetElements(content);

            Assert.AreEqual(3, items.Length);
        }

        private string[] GetElements(string content)
        {
            var reader = new DefaultStreamReader();
            var transform = CreateTransformer();
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(content));

            var task = reader.Read(stream, transform);
            task.Wait();

            var result = task.Result;
            var items = result.Split(',');
            return items;
        }

        private IReaderTransformer CreateTransformer()
        {
            var mock = new Mock<IReaderTransformer>();
            mock.Setup(t => t.Line(It.IsAny<string>(), It.IsAny<int>()))
                .Returns((string line, int pos) =>
                {
                    if (pos == 0)
                    {
                        return string.Empty;
                    }

                    var items = line.Split(',');

                    return items.Length > 0 ? items[0].Trim(): string.Empty;
                });

            mock.Setup(t => t.Complete(It.IsAny<IEnumerable<string>>()))
                .Returns<IEnumerable<string>>(list => string.Join(",", list.Where(l => !string.IsNullOrEmpty(l))));

            return mock.Object;
        }
    }
}
