using System.IO;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.Reader
{
    public interface IStreamReader
    {
        Task<string> Read(Stream stream, IReaderTransformer transformer);
    }
}
