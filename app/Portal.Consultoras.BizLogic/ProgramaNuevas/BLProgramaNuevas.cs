using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ProgramaNuevas;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLProgramaNuevas : IProgramaNuevasBusinessLogic
    {
        public Enumeradores.ValidacionProgramaNuevas ValidarBusquedaProgramaNuevas(int paisID, int campaniaID, int ConsultoraID, string codigoPrograma, int consecutivoNueva, string cuv)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo;
            if (!EstaEnRangoCuvProgramaNuevas(paisID, Convert.ToInt32(cuv))) return Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo;
            List<BEProductoProgramaNuevas> lstProdcutos = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstProdcutos == null || lstProdcutos.Count == 0) return Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste;
            if (!lstProdcutos.Any(x => x.CodigoCupon == cuv)) return Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste;
            if (codigoPrograma == "") return Enumeradores.ValidacionProgramaNuevas.ConsultoraNoNueva;
            lstProdcutos = FiltrarProductosNuevasByNivelyCodigoPrograma(lstProdcutos, consecutivoNueva, codigoPrograma);
            if (!lstProdcutos.Any(a => a.CodigoCupon == cuv)) return Enumeradores.ValidacionProgramaNuevas.CuvNoPerteneceASuPrograma;
            return Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas;
        }

        public int ValidarCantidadMaximaProgramaNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return 0;
            List<BEProductoProgramaNuevas> lstProdcutos = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstProdcutos.Count == 0) return 0;
            lstProdcutos = FiltrarProductosNuevasByNivelyCodigoPrograma(lstProdcutos, consecutivoNueva, codigoPrograma);
            if (lstProdcutos.Count == 0) return 0;
            var CantidadMaxima = lstProdcutos.Where(a => a.CodigoCupon == cuvIngresado).Select(b => b.UnidadesMaximas).FirstOrDefault();
            if (cantidadIngresada + cantidadEnPedido > CantidadMaxima) return CantidadMaxima;
            return 0;
        }

        public BERespValidarElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, List<string> lstCuvPedido)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            List<BEProductoProgramaNuevas> lstProductos = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstProductos == null || lstProductos.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            lstProductos = FiltrarProductosNuevasByNivelyCodigoPrograma(lstProductos, consecutivoNueva, codigoPrograma);
            if (lstProductos.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            var cuv = lstProductos.FirstOrDefault(a => a.CodigoCupon == cuvIngresado);
            if (cuv == null) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            if (cuv.IndicadorCuponIndependiente) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            List<BEProductoProgramaNuevas> lstElectivas = lstProductos.Where(a => !a.IndicadorCuponIndependiente && a.CodigoCupon != cuvIngresado).ToList();
            if (lstElectivas.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivosProgramaNuevas(paisID, nivelInput);
            if (limElectivos <= 0) limElectivos = 1;

            var listElecPedido = lstCuvPedido.Where(c => lstElectivas.Any(e => e.CodigoCupon == c)).ToList();
            var cantElecPedido = listElecPedido.Count;
            if (cantElecPedido > limElectivos) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.NoAgregarExcedioLimite, limElectivos);

            BERespValidarElectivos resp;
            if (limElectivos == 1)
            {
                if (cantElecPedido == 1) resp = new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Reemplazar, listElecPedido);
                else resp = new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            }
            else
            {
                if (cantElecPedido == limElectivos) resp = new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.NoAgregarExcedioLimite, limElectivos);
                else resp = new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.AgregarYMostrarMensaje, limElectivos) { NumElectivosEnPedido = cantElecPedido + 1 };
            }
            return resp;
        }

        public void UpdateFlagCupones(int paisID, List<BEPedidoWebDetalle> listPedidoDetalle)
        {
            if (listPedidoDetalle == null || listPedidoDetalle.Count == 0) return;
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return;

            var fnEnRango = GetFnEnRangoCuvProgramaNuevas(paisID);
            listPedidoDetalle.ForEach(d => d.EnRangoProgNuevas = fnEnRango(Convert.ToInt32(d.CUV)));
        }

        public bool EsCuvDuoPerfecto(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, string cuv)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return false;

            var lstCuponNuevas = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstCuponNuevas == null || lstCuponNuevas.Count == 0) return false;
            lstCuponNuevas = FiltrarProductosNuevasByNivelyCodigoPrograma(lstCuponNuevas, consecutivoNueva, codigoPrograma);
            if (lstCuponNuevas.Count == 0) return false;

            var lstElectivas = lstCuponNuevas.Where(c => !c.IndicadorCuponIndependiente).ToList();
            if (lstElectivas.Count <= 1) return false;
            var electivo = lstElectivas.FirstOrDefault(e => e.CodigoCupon == cuv);
            if (electivo == null) return false;

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivosProgramaNuevas(paisID, nivelInput);
            if (limElectivos <= 1) return false;
            return true;
        }

        public bool TieneListaEstrategiaDuoPerfecto(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<string> lstCuv)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagBannerElecMultiple, paisID)) return false;

            var lstCuponNuevas = GetProductosProgramaNuevasByCampaniaCache(paisID, campaniaID);
            if (lstCuponNuevas == null || lstCuponNuevas.Count == 0) return false;
            lstCuponNuevas = FiltrarProductosNuevasByNivelyCodigoPrograma(lstCuponNuevas, consecutivoNueva, codigoPrograma);
            if (lstCuponNuevas.Count == 0) return false;

            var lstElectivas = lstCuponNuevas.Where(c => !c.IndicadorCuponIndependiente).ToList();
            if (lstElectivas.Count <= 1) return false;
            var countElecLista = lstElectivas.Count(e => lstCuv.Contains(e.CodigoCupon));
            if (countElecLista <= 1) return false;

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivosProgramaNuevas(paisID, nivelInput);
            if (limElectivos <= 1) return false;
            return true;
        }

        public int GetLimElectivosProgNuevas(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma)
        {
            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivosProgramaNuevas(paisID, nivelInput);
            if (limElectivos <= 0) limElectivos = 1;
            return limElectivos;
        }

        #region Metodos de Programa Nuevas

        private bool IsFlagOn(string codigo, int paisID)
        {
            var blTablaLogicaDatos = new BLTablaLogicaDatos();
            var lstTabla = blTablaLogicaDatos.GetListCache(paisID, Constantes.ProgNuevas.EncenderValidacion.TablaLogicaID);
            if (lstTabla.Count == 0) return false;
            if (lstTabla.Where(a => a.Codigo == codigo).Select(b => b.Valor).FirstOrDefault() == "1") return true;
            return false;
        }

        private bool EstaEnRangoCuvProgramaNuevas(int paisID, int cuv)
        {
            var fnEnRango = GetFnEnRangoCuvProgramaNuevas(paisID);
            return fnEnRango(cuv);
        }
        private Predicate<int> GetFnEnRangoCuvProgramaNuevas(int paisID)
        {
            var lstTabla = new BLTablaLogicaDatos().GetListCache(paisID, Constantes.ProgNuevas.Rango.TablaLogicaID);
            if (lstTabla.Count == 0) return new Predicate<int>(cuv => false);

            int cuvIni = Convert.ToInt32(lstTabla.Where(a => a.Codigo == Constantes.ProgNuevas.Rango.cuvInicio).Select(b => b.Descripcion).FirstOrDefault());
            int cuvFin = Convert.ToInt32(lstTabla.Where(a => a.Codigo == Constantes.ProgNuevas.Rango.cuvFinal).Select(b => b.Descripcion).FirstOrDefault());
            return new Predicate<int>(cuv => cuvIni <= cuv && cuv <= cuvFin);
        }

        private List<BEProductoProgramaNuevas> GetProductosProgramaNuevasByCampania(int paisID, int campaniaID)
        {
            var daProducto = new DAProducto(paisID);
            var productos = new List<BEProductoProgramaNuevas>();
            using (IDataReader reader = daProducto.GetProductosProgramaNuevas(campaniaID))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProductoProgramaNuevas(reader));
                }
            }
            return productos;
        }
        private List<BEProductoProgramaNuevas> GetProductosProgramaNuevasByCampaniaCache(int paisID, int campaniaID)
        {
            return CacheManager<List<BEProductoProgramaNuevas>>.ValidateDataElement(paisID, ECacheItem.ProductoProgramaNuevas, campaniaID.ToString(), () => GetProductosProgramaNuevasByCampania(paisID, campaniaID));
        }

        private List<BEProductoProgramaNuevas> FiltrarProductosNuevasByNivelyCodigoPrograma(List<BEProductoProgramaNuevas> lstProdcutos, int consecutivoNueva, string codigoPrograma)
        {
            return lstProdcutos.Where(a =>
                a.CodigoPrograma == codigoPrograma && NivelNuevaEnRango(consecutivoNueva + 1, a.CodigoNivel, a.NumeroCampanasVigentes)
            ).ToList();
        }

        private List<BENivelesProgramaNuevas> GetNivelesProgramaNuevasByCampania(int paisID, string campania)
        {
            using (var reader = new DANivelesProgramaNuevas(paisID).GetByCampania(campania))
            {
                return MapUtil.MapToCollection<BENivelesProgramaNuevas>(reader, true, true);
            }
        }
        private List<BENivelesProgramaNuevas> GetNivelesProgramaNuevasByCampaniaCache(int paisID, string campania)
        {
            return CacheManager<List<BENivelesProgramaNuevas>>.ValidateDataElement(paisID, ECacheItem.NivelesProgramaNuevas, campania, () => GetNivelesProgramaNuevasByCampania(paisID, campania));
        }
        private int GetLimiteElectivosProgramaNuevas(int paisID, BENivelesProgramaNuevas nivel)
        {
            var listNiveles = GetNivelesProgramaNuevasByCampaniaCache(paisID, nivel.Campania).Where(n =>
                n.CodigoPrograma == nivel.CodigoPrograma && NivelNuevaEnRango(Convert.ToInt32(nivel.CodigoNivel), n.CodigoNivel, n.NumeroCampanasVigentes)
            ).ToList();
            if (!listNiveles.Any()) return 1;

            return listNiveles.Max(n => n.UnidadesNivel);
        }

        private bool NivelNuevaEnRango(int nivelConsultora, string nivelInicial, int campaniasVigentes)
        {
            int iNivelInicial = Convert.ToInt32(nivelInicial);
            return iNivelInicial <= nivelConsultora && nivelConsultora <= (iNivelInicial + campaniasVigentes - 1);
        }

        #endregion


        public List<BEPremioNuevas> ListarPremioNuevasPaginado(BEPremioNuevas premio)
        {
        
            List<BEPremioNuevas> listPaginado = null;
            try
            {
                using (var reader = new DAPremioNuevas(premio.PaisID).ListarPremioNuevasPaginado(premio))
                {
                    listPaginado = MapUtil.MapToCollection<BEPremioNuevas>(reader, true, true);
                }

                listPaginado.Update(x =>
                {
                    x.ActiveDesc = x.ActivePremioAuto == true ? "Si" : "No";
                    x.ActiveTooltipDesc = x.ActiveTooltip == true ? "Si" : "No";
                    x.ActiveTooltipMontoDesc = x.ActiveMonto == true ? "Si" : "No";
                    x.Ind_Cup_ElecDesc = x.ActivePremioElectivo == true ? "Si" : "No";
                });
                return listPaginado;
            }

            catch (Exception ex)
            {
                LogManager.SaveLog(ex, premio.CodigoUsuario, premio.PaisID);
                throw new BizLogicException("Error en BLProgramaNuevas.ListarPremioNuevasPaginado", ex);
            }
        }
        public BEPremioNuevas Editar(BEPremioNuevas premio)
        {
            try
            {
                using (var reader = new DAPremioNuevas(premio.PaisID).Editar(premio))
                {
                    return MapUtil.MapToCollection<BEPremioNuevas>(reader, true, true).FirstOrDefault();
                }
            }

            catch (Exception ex)
            {
                LogManager.SaveLog(ex, premio.CodigoUsuario, premio.PaisID);
                throw new BizLogicException("Error en BLProgramaNuevas.Editar", ex);
            }

            
        }
        public BEPremioNuevas Insertar(BEPremioNuevas premio)
        {
            try
            {
                using (var reader = new DAPremioNuevas(premio.PaisID).Insertar(premio))
                {
                    return MapUtil.MapToCollection<BEPremioNuevas>(reader, true, true).FirstOrDefault();
                }
            }

            catch (Exception ex)
            {
                LogManager.SaveLog(ex, premio.CodigoUsuario, premio.PaisID);
                throw new BizLogicException("Error en BLProgramaNuevas.Insertar", ex);
            }
           
        }



    }
}
