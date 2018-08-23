using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaPasarelaCampos
    {
        [DataMember]
        public int PagoEnLineaPasarelaCamposId { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public bool EsObligatorio { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEPagoEnLineaPasarelaCampos()
        {}

        public BEPagoEnLineaPasarelaCampos(IDataRecord row)
        {
            PagoEnLineaPasarelaCamposId = row.ToInt32("PagoEnLineaPasarelaCamposId");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
            EsObligatorio = row.ToBoolean("EsObligatorio");
            Estado = row.ToBoolean("Estado");
        }
    }
}
