﻿using Portal.Consultoras.Data.PagoEnLinea;
using Portal.Consultoras.Entities.PagoEnLinea;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
