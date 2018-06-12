using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common.Reader
{
    public class DefaultStreamReader : IStreamReader
    {
        public async Task<string> Read(Stream stream, IReaderTransformer transformer)
        {
            if (!CanProcessStream(stream))
            {
                return null;
            }

            var lines = await GetLines(stream, transformer);

            return transformer.Complete(lines);
        }

        private async Task<IEnumerable<string>> GetLines(Stream stream, IReaderTransformer transformer)
        {
            var lines = new List<string>();
            using (var reader = new StreamReader(stream))
            {
                string line;
                var position = 0;
                while ((line = await reader.ReadLineAsync()) != null)
                {
                    lines.Add(transformer.Line(line.Trim(), position));
                    position++;
                }
            }

            return lines;
        }

        private bool CanProcessStream(Stream stream)
        {
            return stream != null && stream.CanRead;
        }
    }
}
