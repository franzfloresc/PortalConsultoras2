using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLAdministrarEstrategia
    {
        public List<BEDescripcionEstrategia> ActualizarDescripcionEstrategia(int paisId, int campaniaId, int tipoEstrategiaId, List<BEDescripcionEstrategia> listaDescripcionEstrategias)
        {
            var listdDescripcionEstrategias = new List<BEDescripcionEstrategia>();
            var daEstrategia = new DAEstrategia(paisId);
            using (var reader = daEstrategia.ActualizarDescripcionEstrategia(campaniaId, tipoEstrategiaId, listaDescripcionEstrategias))
            {
                while (reader.Read())
                {
                    listdDescripcionEstrategias.Add(new BEDescripcionEstrategia(reader));
                }
            }
            return listdDescripcionEstrategias;
        }

        public int ActualizarTonoEstrategia(int paisId, int estrategiaId, string codigoEstrategia, int tieneVariedad)
        {
            var daEstrategia = new DAEstrategia(paisId);
            return daEstrategia.ActualizarTonoEstrategia(estrategiaId, codigoEstrategia, tieneVariedad);
        }

        #region Nuevo Masivo
        public bool EstrategiaTemporalActualizarPrecioNivel(int paisId, int campaniaId, string estrategiaCodigo, string joinCuv)
        {
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                return daEstrategia.EstrategiaTemporalActualizarPrecioNivel(campaniaId, estrategiaCodigo, joinCuv);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                return false;
            }
        }

        public bool EstrategiaTemporalActualizarSetDetalle(int paisId, int campaniaId, string estrategiaCodigo, string joinCuv)
        {
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                return daEstrategia.EstrategiaTemporalActualizarSetDetalle(campaniaId, estrategiaCodigo, joinCuv);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                return false;
            }
        }
        #endregion
    }
}