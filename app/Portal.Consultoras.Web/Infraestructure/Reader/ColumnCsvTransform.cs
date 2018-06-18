using System.Collections.Generic;
using System.Linq;
using Portal.Consultoras.Common.Reader;

namespace Portal.Consultoras.Web.Infraestructure.Reader
{
    public class ColumnCsvTransform : IReaderTransformer
    {
        private const string Separator = ",";
        public string Line(string line, int position)
        {
            if (position == 0)
            {
                return string.Empty;
            }

            var items = line.Split(Separator[0]);

            return items.Length > 0 ? items[0].Trim(): string.Empty;
        }

        public string Complete(IEnumerable<string> lines)
        {
            return string.Join(Separator, lines.Where(r => !string.IsNullOrWhiteSpace(r)));
        }
    }
}