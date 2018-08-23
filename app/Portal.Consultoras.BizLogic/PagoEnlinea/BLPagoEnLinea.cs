using Portal.Consultoras.Data.PagoEnLinea;
using Portal.Consultoras.Entities.PagoEnLinea;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.PagoEnlinea
{
    public class BLPagoEnLinea
    {
        public int InsertPagoEnLineaResultadoLog(int paisId, BEPagoEnLineaResultadoLog entidad)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            return dataAccess.InsertPagoEnLineaResultadoLog(entidad);
        }

        public string ObtenerTokenTarjetaGuardadaByConsultora(int paisId, string codigoConsultora)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            return dataAccess.ObtenerTokenTarjetaGuardadaByConsultora(codigoConsultora);
        }

        public void UpdateMontoDeudaConsultora(int paisId, string codigoConsultora, decimal montoDeuda)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            dataAccess.UpdateMontoDeudaConsultora(codigoConsultora, montoDeuda);
        }

        public BEPagoEnLineaResultadoLog ObtenerPagoEnLineaById(int paisId, int pagoEnLineaResultadoLogId)
        {
            BEPagoEnLineaResultadoLog entidad = null;
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (IDataReader reader = DAPagoEnLinea.ObtenerPagoEnLineaById(pagoEnLineaResultadoLogId))
                if (reader.Read())
                {
                    entidad = new BEPagoEnLineaResultadoLog(reader);
                }
            return entidad;

        }

        public void UpdateVisualizado(int paisId, int pagoEnLineaResultadoLogId)
        {
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);
            DAPagoEnLinea.UpdateVisualizado(pagoEnLineaResultadoLogId);
        }

        public BEPagoEnLineaResultadoLog ObtenerUltimoPagoEnLineaByConsultoraId(int paisId, long consultoraId)
        {
            BEPagoEnLineaResultadoLog entidad = null;
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (IDataReader reader = DAPagoEnLinea.ObtenerUltimoPagoEnLineaByConsultoraId(consultoraId))
                if (reader.Read())
                {
                    entidad = new BEPagoEnLineaResultadoLog(reader);
                }
            return entidad;
        }

        public List<BEPagoEnLineaResultadoLogReporte> ObtenerPagoEnLineaByFiltro(int paisId, BEPagoEnLineaFiltro filtro)
        {
            var lista = new List<BEPagoEnLineaResultadoLogReporte>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaByFiltro(filtro))
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaResultadoLogReporte(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaTipoPago> ObtenerPagoEnLineaTipoPago(int paisId)
        {
            var lista = new List<BEPagoEnLineaTipoPago>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaTipoPago())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaTipoPago(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaMedioPago> ObtenerPagoEnLineaMedioPago(int paisId)
        {
            var lista = new List<BEPagoEnLineaMedioPago>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaMedioPago())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaMedioPago(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaMedioPagoDetalle> ObtenerPagoEnLineaMedioPagoDetalle(int paisId)
        {
            var lista = new List<BEPagoEnLineaMedioPagoDetalle>();
            var daPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = daPagoEnLinea.ObtenerPagoEnLineaMedioPagoDetalle())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaMedioPagoDetalle(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaTipoPasarela> ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(int paisId, string codigoPlataforma)
        {
            var lista = new List<BEPagoEnLineaTipoPasarela>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(codigoPlataforma))
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaTipoPasarela(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaPasarelaCampos> ObtenerPagoEnLineaPasarelaCampos(int paisId)
        {
            var lista = new List<BEPagoEnLineaPasarelaCampos>();
            var daPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = daPagoEnLinea.ObtenerPagoEnLineaPasarelaCampos())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaPasarelaCampos(reader));
                }
            }

            return lista;
        }

        public int ObtenerNumeroOrden(int paisId)
        {
            return new DAPagoEnLinea(paisId).ObtenerNumeroOrden();
        }
    }
}
