using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLComprobantePercepcion
    {
        public IList<BEComprobantePercepcion> SelectComprobantePercepcion(int paisID, long consultoraID)
        {
            var comprobantes = new List<BEComprobantePercepcion>();
            var daComprobantePercepcion = new DAComprobantePercepcion(paisID);

            using (IDataReader reader = daComprobantePercepcion.GetComprobantePercepcion(paisID, consultoraID))
                while (reader.Read())
                {
                    var comprobante = new BEComprobantePercepcion(reader);
                    comprobantes.Add(comprobante);
                }

            return comprobantes;
        }

        public IList<BEComprobantePercepcionDetalle> SelectComprobantePercepcionDetalle(int paisID, int IdComprobantePercepcion)
        {
            var comprobantes = new List<BEComprobantePercepcionDetalle>();
            var daComprobantePercepcion = new DAComprobantePercepcion(paisID);

            using (IDataReader reader = daComprobantePercepcion.GetComprobantePercepcionDetalle(IdComprobantePercepcion))
                while (reader.Read())
                {
                    var comprobante = new BEComprobantePercepcionDetalle(reader);
                    comprobantes.Add(comprobante);
                }

            return comprobantes;
        }

    }
}
