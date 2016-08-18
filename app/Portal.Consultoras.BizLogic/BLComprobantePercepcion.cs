using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLComprobantePercepcion
    {
        public IList<BEComprobantePercepcion> SelectComprobantePercepcion(int paisID, long consultoraID)
        {
            var comprobantes = new List<BEComprobantePercepcion>();
            var DAComprobantePercepcion = new DAComprobantePercepcion(paisID);

            using (IDataReader reader = DAComprobantePercepcion.GetComprobantePercepcion(paisID, consultoraID))
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
            var DAComprobantePercepcion = new DAComprobantePercepcion(paisID);

            using (IDataReader reader = DAComprobantePercepcion.GetComprobantePercepcionDetalle(IdComprobantePercepcion))
                while (reader.Read())
                {
                    var comprobante = new BEComprobantePercepcionDetalle(reader);
                    comprobantes.Add(comprobante);
                }

            return comprobantes;
        }

    }
}
