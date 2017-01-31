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
    public class BLEstrategia
    {
        public List<BEEstrategia> GetEstrategias(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetEstrategia(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> FiltrarEstrategia(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.FiltrarEstrategia(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public List<BETallaColor> GetTallaColor(BETallaColor entidad)
        {
            try
            {
                var listaTallaColor = new List<BETallaColor>();
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetTallaColor(entidad))
                {
                    while (reader.Read())
                    {
                        listaTallaColor.Add(new BETallaColor(reader));
                    }
                }
                return listaTallaColor;
            }
            catch (Exception) { throw; }
        }

        public int InsertTallaColorCUV(BETallaColor entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.InsertTallaColorCUV(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetOfertaByCUV(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int InsertEstrategia(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.InsertEstrategia(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int DeshabilitarEstrategia(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.DeshabilitarEstrategia(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int EliminarTallaColor(BETallaColor entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.EliminarTallaColor(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int ValidarCUVsRecomendados(BEEstrategia entidad)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                int result = DAEstrategia.ValidarCUVsRecomendados(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.GetEstrategiaPedido(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(entidad.PaisID);
                using (IDataReader reader = DAEstrategia.FiltrarEstrategiaPedido(entidad))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public string ValidarStockEstrategia(BEEstrategia entidad)
        {
            var DAEstrategia = new DAEstrategia(entidad.PaisID);
            return DAEstrategia.ValidarStockEstrategia(entidad);
        }
        // 1747 - Inicio
        public IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID)
        {
            var lista = new List<BEConfiguracionValidacionZE>();
            var DAEstrategia = new DAEstrategia(PaisID);

            using (IDataReader reader = DAEstrategia.GetRegionZonaZE(RegionID, ZonaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionZE(reader);
                    lista.Add(entidad);
                }

            return lista;
        }
        // 1747 - Fin

        public string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv)
        {
            var imagen = string.Empty;
            var DAEstrategia = new DAEstrategia(paisID);

            return DAEstrategia.GetImagenOfertaPersonalizadaOF(campaniaID, cuv);
        }

        public int GetCantidadOfertasParaTi(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.GetCantidadOfertasParaTi(campaniaId, tipoConfigurado);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfigurado(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(paisId);
                using (IDataReader reader = DAEstrategia.GetOfertasParaTiByTipoConfigurado(campaniaId, tipoConfigurado))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int InsertEstrategiaTemporal(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario)
        {
            var DAEstrategia = new DAEstrategia(paisId);
            return DAEstrategia.InsertEstrategiaTemporal(lista, campaniaId, codigoUsuario);
        }

        public int GetCantidadOfertasParaTiTemporal(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.GetCantidadOfertasParaTiTemporal(campaniaId, tipoConfigurado);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfiguradoTemporal(int paisId, int campaniaId, int tipoConfigurado)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();

                var DAEstrategia = new DAEstrategia(paisId);
                using (IDataReader reader = DAEstrategia.GetOfertasParaTiByTipoConfiguradoTemporal(campaniaId, tipoConfigurado))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int DeleteEstrategiaTemporal(int paisId, int campaniaId)
        {
            try
            {
                var DAEstrategia = new DAEstrategia(paisId);
                int result = DAEstrategia.DeleteEstrategiaTemporal(campaniaId);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int InsertEstrategiaOfertaParaTi(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario)
        {
            var DAEstrategia = new DAEstrategia(paisId);
            return DAEstrategia.InsertEstrategiaOfertaParaTi(lista, campaniaId, codigoUsuario);
        }

        /*PL20-1226*/
        public List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            try
            {
                List<BEEstrategia> listaEstrategias = new List<BEEstrategia>();
                var DAEstrategia = new DAEstrategia(paisID);

                using (IDataReader reader = DAEstrategia.GetEstrategiaODD(codCampania, codConsultora, fechaInicioFact))
                {
                    while (reader.Read())
                    {
                        listaEstrategias.Add(new BEEstrategia(reader));
                    }
                }
                return listaEstrategias;
            }
            catch (Exception) { throw; }
        }

        public int ActivarDesactivarEstrategias(int paisID, String UsuarioModificacion, String EstrategiasActivas, String EstrategiasDesactivas)
        {
            var DAEstrategia = new DAEstrategia(paisID);
            return DAEstrategia.ActivarDesactivarEstrategias(UsuarioModificacion, EstrategiasActivas, EstrategiasDesactivas);
        }

    }
}
