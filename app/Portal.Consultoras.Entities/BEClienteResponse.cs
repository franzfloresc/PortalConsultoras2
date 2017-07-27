
using Portal.Consultoras.Entities.Cliente;
using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    public class BEClienteResponse
    {
        public long ClienteID { get; set; }
        public long ConsultoraID { get; set; }
        public int ClienteIDSB { get; set; }
        public string CodigoRespuesta { get; set; }
        public string MensajeRespuesta { get; set; }

        public IEnumerable<BENota> Notas { get; set; }
    }
}
