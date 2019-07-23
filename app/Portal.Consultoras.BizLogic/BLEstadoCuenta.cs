using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstadoCuenta
    {
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, long consultoraId)
        {
            var lista = new List<BEEstadoCuenta>();

            var blPais = new BLPais();

            if (!blPais.EsPaisHana(PaisId)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var daEstadoCuenta = new DAEstadoCuenta(PaisId);

                using (IDataReader reader = daEstadoCuenta.GetEstadoCuentaConsultora(consultoraId))
                {
                    while (reader.Read())
                    {
                        var entidad = new BEEstadoCuenta(reader);

                        lista.Add(entidad);
                    }
                }
            }
            else
            {
                var daEstadoCuenta = new DAHEstadoCuenta();

                lista = daEstadoCuenta.GetEstadoCuentaConsultora(PaisId, consultoraId);
            }

            return lista;
        }

        public string GetDeudaActualConsultora(int PaisId, long consultoraId)
        {
            var daEstadoCuenta = new DAEstadoCuenta(PaisId);
            return daEstadoCuenta.GetDeudaActualConsultora(consultoraId);
        }

        public BEFechaFacturacion GetFechasFacturacionConsultora(int paisID, string consultora, int campaniaActual, int cantidadAnterior, int cantidadProxima)
        {
            BEFechaFacturacion objBEFechaFacturacion = new BEFechaFacturacion();
            List<BEFechaFacturacion> fechaFacturacionActual = new List<BEFechaFacturacion>();
            List<BEFechaFacturacion> fechaFacturacionAnterior = new List<BEFechaFacturacion>();
            List<BEFechaFacturacion> fechaFacturacionproxima = new List<BEFechaFacturacion>();
            var daConsultora = new DAConsultora(paisID);
            using (IDataReader reader = daConsultora.GetFechasFacturacionConsultora(consultora, campaniaActual, cantidadAnterior, cantidadProxima))
            {
                while (reader.Read())
                {
                    fechaFacturacionActual.Add(new BEFechaFacturacion(reader));
                }
                reader.NextResult();

                while (reader.Read())
                {
                    fechaFacturacionproxima.Add(new BEFechaFacturacion(reader));
                }

                reader.NextResult();

                while (reader.Read())
                {
                    fechaFacturacionAnterior.Add(new BEFechaFacturacion(reader));
                }

                objBEFechaFacturacion.ListFechaFacturacionActual = fechaFacturacionActual;
                objBEFechaFacturacion.ListFechaFacturacionProxima = fechaFacturacionproxima;
                objBEFechaFacturacion.ListFechaFacturacionAnterior = fechaFacturacionAnterior;

            }

            return objBEFechaFacturacion;
        }
    }
}
