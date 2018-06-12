using System.Collections.Generic;

namespace Portal.Consultoras.Common.Reader
{
    public interface IReaderTransformer
    {
        string Line(string line, int position);
        string Complete(IEnumerable<string> lines);
    }
}
