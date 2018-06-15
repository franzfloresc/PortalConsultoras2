using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

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

        #region Nuevo Masivo

        public int GetCantidadOfertasPersonalizadas(int paisId, int campaniaId, int tipoConfigurado, string codigoEstrategia)
        {
            var daEstrategia = new DAEstrategia(paisId);
            int result = daEstrategia.GetCantidadOfertasPersonalizadas(campaniaId, tipoConfigurado, codigoEstrategia);
            return result;
        }

        public List<BEEstrategia> GetOfertasPersonalizadasByTipoConfigurado(int paisId, int campaniaId, int tipoConfigurado, string estrategiaCodigo, int pagina, int cantidadCuv)
        {
            var listaEstrategias = new List<BEEstrategia>();
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                using (IDataReader reader = daEstrategia.GetOfertasPersonalizadasByTipoConfigurado(campaniaId, tipoConfigurado, estrategiaCodigo, pagina, cantidadCuv))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader, true));
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                listaEstrategias = new List<BEEstrategia>();
            }
            return listaEstrategias;
        }

        public int GetCantidadOfertasPersonalizadasTemporal(int paisId, int nroLote, int tipoConfigurado)
        {
            var daEstrategia = new DAEstrategia(paisId);
            int result = daEstrategia.GetCantidadOfertasPersonalizadasTemporal(nroLote, tipoConfigurado);
            return result;
        }

        public int EstrategiaTemporalDelete(int paisId, int nroLote)
        {
            var daEstrategia = new DAEstrategia(paisId);
            int result = daEstrategia.EstrategiaTemporalDelete(nroLote);
            return result;
        }


        public List<BEEstrategia> GetOfertasPersonalizadasByTipoConfiguradoTemporal(int paisId, int tipoConfigurado, int nroLote)
        {
            List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

            var daEstrategia = new DAEstrategia(paisId);
            using (IDataReader reader = daEstrategia.GetOfertasPersonalizadasByTipoConfiguradoTemporal(tipoConfigurado, nroLote))
            {
                while (reader.Read())
                {
                    listaEstrategias.Add(new BEEstrategia(reader));
                }
            }
            return listaEstrategias;
        }

        public int EstrategiaTemporalInsertarMasivo(int paisId, int campaniaId, string estrategiaCodigo, int pagina, int cantidadCuv, int nroLote)
        {
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                return daEstrategia.EstrategiaTemporalInsertarMasivo(campaniaId, estrategiaCodigo, pagina, cantidadCuv, nroLote);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                return 0;
            }
        }

        public bool EstrategiaTemporalActualizarPrecioNivel(int paisId, int nroLote, int pagina)
        {
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                return daEstrategia.EstrategiaTemporalActualizarPrecioNivel(nroLote, pagina);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                return false;
            }
        }

        public bool EstrategiaTemporalActualizarSetDetalle(int paisId, int nroLote, int pagina)
        {
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                return daEstrategia.EstrategiaTemporalActualizarSetDetalle(nroLote, pagina);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                return false;
            }
        }

        public int EstrategiaTemporalInsertarEstrategiaMasivo(int paisId, int nroLote)
        {
            try
            {
                var daEstrategia = new DAEstrategia(paisId);
                return daEstrategia.EstrategiaTemporalInsertarEstrategiaMasivo(nroLote);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId);
                return 0;
            }
        }
        #endregion
    }
}