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
        public Enumeradores.ValidacionProgramaNuevas ValidarBusquedaCuv(int paisID, int campaniaID, string codigoPrograma, int consecutivoNueva, string cuv)
        {
            return ValidarBusquedaListCuv(paisID, campaniaID, codigoPrograma, consecutivoNueva, new List<string> { cuv }).First().Value;
        }

        public Dictionary<string, Enumeradores.ValidacionProgramaNuevas> ValidarBusquedaListCuv(int paisID, int campaniaID, string codigoPrograma, int consecutivoNueva, List<string> listCuv)
        {
            var dicValidacionCuv = listCuv.Distinct().ToDictionary(c => c, c => Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo);
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return dicValidacionCuv;

            var fnEnRango = GetFnEnRangoCuv(paisID);
            var listCuvEnRango = dicValidacionCuv.Where(vc => fnEnRango(Convert.ToInt32(vc.Key))).ToList();
            if (listCuvEnRango.Count == 0) return dicValidacionCuv;

            var listCuvActualNuevas = GetProductosByCampaniaCache(paisID, campaniaID);
            listCuvEnRango.ForEach(cv => dicValidacionCuv[cv.Key] = Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste);
            if (listCuvActualNuevas == null || listCuvActualNuevas.Count == 0) return dicValidacionCuv;

            var listCuvNuevas = listCuvEnRango.Where(vc => listCuvActualNuevas.Any(p => p.CodigoCupon == vc.Key)).ToList();
            if (codigoPrograma == "")
            {
                listCuvNuevas.ForEach(cv => dicValidacionCuv[cv.Key] = Enumeradores.ValidacionProgramaNuevas.ConsultoraNoNueva);
                return dicValidacionCuv;
            }

            var listCuvPerteneceActualNuevas = FiltrarProductosByNivelyCodigoPrograma(listCuvActualNuevas, consecutivoNueva, codigoPrograma);
            var listCuvPerteneceNuevas = listCuvEnRango.Where(vc => listCuvPerteneceActualNuevas.Any(p => p.CodigoCupon == vc.Key)).ToList();
            listCuvNuevas.ForEach(cv => dicValidacionCuv[cv.Key] = Enumeradores.ValidacionProgramaNuevas.CuvNoPerteneceASuPrograma);
            listCuvPerteneceNuevas.ForEach(cv => dicValidacionCuv[cv.Key] = Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas);

            return dicValidacionCuv;
        }

        public int ValidarCantidadMaxima(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, int cantidadEnPedido, string cuvIngresado, int cantidadIngresada)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return 0;
            List<BEProductoProgramaNuevas> lstProdcutos = GetProductosByCampaniaCache(paisID, campaniaID);
            if (lstProdcutos.Count == 0) return 0;
            lstProdcutos = FiltrarProductosByNivelyCodigoPrograma(lstProdcutos, consecutivoNueva, codigoPrograma);
            if (lstProdcutos.Count == 0) return 0;
            var CantidadMaxima = lstProdcutos.Where(a => a.CodigoCupon == cuvIngresado).Select(b => b.UnidadesMaximas).FirstOrDefault();
            if (cantidadIngresada + cantidadEnPedido > CantidadMaxima) return CantidadMaxima;
            return 0;
        }

        public BERespValidarElectivos ValidaCuvElectivo(int paisID, int campaniaID, string cuvIngresado, int consecutivoNueva, string codigoPrograma, List<string> lstCuvPedido)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            List<BEProductoProgramaNuevas> lstProductos = GetProductosByCampaniaCache(paisID, campaniaID);
            if (lstProductos == null || lstProductos.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            lstProductos = FiltrarProductosByNivelyCodigoPrograma(lstProductos, consecutivoNueva, codigoPrograma);
            if (lstProductos.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            var cuv = lstProductos.FirstOrDefault(a => a.CodigoCupon == cuvIngresado);
            if (cuv == null) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);
            if (!cuv.EsCuponElectivo) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            List<BEProductoProgramaNuevas> lstElectivas = lstProductos.Where(a => a.EsCuponElectivo && a.CodigoCupon != cuvIngresado).ToList();
            if (lstElectivas.Count == 0) return new BERespValidarElectivos(Enumeradores.ValidarCuponesElectivos.Agregar);

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivos(paisID, nivelInput);
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

        public void UpdFlagCupones(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<BEPedidoWebDetalle> listPedidoDetalle)
        {
            if (listPedidoDetalle == null || listPedidoDetalle.Count == 0) return;
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return;
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagLabelPedidoDet, paisID)) return;
            if (codigoPrograma == "") return;

            var fnEnRango = GetFnEnRangoCuv(paisID);
            var listDetalleEnRango = listPedidoDetalle.Where(d => fnEnRango(Convert.ToInt32(d.CUV))).ToList();
            if (listDetalleEnRango.Count == 0) return;
            var listCuvNuevasCampania = GetProductosByCampaniaCache(paisID, campaniaID);

            var listCuvNuevas = FiltrarProductosByNivelyCodigoPrograma(listCuvNuevasCampania, consecutivoNueva, codigoPrograma);
            if (listCuvNuevas.Count == 0) return;
            var listDetNuevas = listDetalleEnRango.Where(d => listCuvNuevas.Any(p => p.CodigoCupon == d.CUV)).ToList();
            listDetNuevas.ForEach(d => d.EsCuponNuevas = true);

            ValidFlagEsPremioNueva(listDetNuevas, listCuvNuevas);
            var listDetNuevasNoPremios = listDetNuevas.Where(d => !d.EsPremioElectivo).ToList();
            ValidFlagEsElecMultipleNuevas(paisID, campaniaID, codigoPrograma, consecutivoNueva, listDetNuevasNoPremios, listCuvNuevas);
        }

        public bool EsCuvElecMultiple(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, string cuv)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagProgNuevas, paisID)) return false;

            var lstCuponNuevas = GetProductosByCampaniaCache(paisID, campaniaID);
            if (lstCuponNuevas == null || lstCuponNuevas.Count == 0) return false;
            lstCuponNuevas = FiltrarProductosByNivelyCodigoPrograma(lstCuponNuevas, consecutivoNueva, codigoPrograma);
            if (lstCuponNuevas.Count == 0) return false;

            var lstElectivas = lstCuponNuevas.Where(c => c.EsCuponElectivo).ToList();
            if (lstElectivas.Count <= 1) return false;
            var electivo = lstElectivas.FirstOrDefault(e => e.CodigoCupon == cuv);
            if (electivo == null) return false;

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivos(paisID, nivelInput);
            if (limElectivos <= 1) return false;
            return true;
        }

        public bool TieneListaEstrategiaElecMultiple(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma, List<string> lstCuv)
        {
            if (!IsFlagOn(Constantes.ProgNuevas.EncenderValidacion.FlagBannerElecMultiple, paisID)) return false;

            var lstCuponNuevas = GetProductosByCampaniaCache(paisID, campaniaID);
            if (lstCuponNuevas == null || lstCuponNuevas.Count == 0) return false;
            lstCuponNuevas = FiltrarProductosByNivelyCodigoPrograma(lstCuponNuevas, consecutivoNueva, codigoPrograma);
            if (lstCuponNuevas.Count == 0) return false;

            var lstElectivas = lstCuponNuevas.Where(c => c.EsCuponElectivo).ToList();
            if (lstElectivas.Count <= 1) return false;
            var countElecLista = lstElectivas.Count(e => lstCuv.Contains(e.CodigoCupon));
            if (countElecLista <= 1) return false;

            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivos(paisID, nivelInput);
            if (limElectivos <= 1) return false;
            return true;
        }

        public int GetLimElectivos(int paisID, int campaniaID, int consecutivoNueva, string codigoPrograma)
        {
            var nivelInput = new BENivelesProgramaNuevas { Campania = campaniaID.ToString(), CodigoPrograma = codigoPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivos(paisID, nivelInput);
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
        
        private Predicate<int> GetFnEnRangoCuv(int paisID)
        {
            var lstTabla = new BLTablaLogicaDatos().GetListCache(paisID, Constantes.ProgNuevas.Rango.TablaLogicaID);
            if (lstTabla.Count == 0) return new Predicate<int>(cuv => false);

            int cuvIni = Convert.ToInt32(lstTabla.Where(a => a.Codigo == Constantes.ProgNuevas.Rango.cuvInicio).Select(b => b.Descripcion).FirstOrDefault());
            int cuvFin = Convert.ToInt32(lstTabla.Where(a => a.Codigo == Constantes.ProgNuevas.Rango.cuvFinal).Select(b => b.Descripcion).FirstOrDefault());
            return new Predicate<int>(cuv => cuvIni <= cuv && cuv <= cuvFin);
        }

        private List<BEProductoProgramaNuevas> GetProductosByCampania(int paisID, int campaniaID)
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
        private List<BEProductoProgramaNuevas> GetProductosByCampaniaCache(int paisID, int campaniaID)
        {
            return CacheManager<List<BEProductoProgramaNuevas>>.ValidateDataElement(paisID, ECacheItem.ProductoProgramaNuevas, campaniaID.ToString(), () => GetProductosByCampania(paisID, campaniaID));
        }

        private List<BEProductoProgramaNuevas> FiltrarProductosByNivelyCodigoPrograma(List<BEProductoProgramaNuevas> lstProdcutos, int consecutivoNueva, string codigoPrograma)
        {
            return lstProdcutos.Where(a =>
                a.CodigoPrograma == codigoPrograma && NivelNuevaEnRango(consecutivoNueva + 1, a.CodigoNivel, a.NumeroCampanasVigentes)
            ).ToList();
        }

        private List<BENivelesProgramaNuevas> GetNivelesByCampania(int paisID, string campania)
        {
            using (var reader = new DANivelesProgramaNuevas(paisID).GetByCampania(campania))
            {
                return MapUtil.MapToCollection<BENivelesProgramaNuevas>(reader, true, true);
            }
        }
        private List<BENivelesProgramaNuevas> GetNivelesByCampaniaCache(int paisID, string campania)
        {
            return CacheManager<List<BENivelesProgramaNuevas>>.ValidateDataElement(paisID, ECacheItem.NivelesProgramaNuevas, campania, () => GetNivelesByCampania(paisID, campania));
        }
        private int GetLimiteElectivos(int paisID, BENivelesProgramaNuevas nivel)
        {
            var listNiveles = GetNivelesByCampaniaCache(paisID, nivel.Campania).Where(n =>
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

        private void ValidFlagEsPremioNueva(List<BEPedidoWebDetalle> listDetNuevas, List<BEProductoProgramaNuevas> listCuvNuevas)
        {
            var listCuvPremioElec = listCuvNuevas.Where(c => c.EsPremioElectivo).ToList();
            if (listCuvPremioElec.Count == 0) return;

            var listDetallePremioElec = listDetNuevas.Where(d => listCuvPremioElec.Any(p => p.CodigoCupon == d.CUV)).ToList();
            listDetallePremioElec.ForEach(d => d.EsPremioElectivo = true);
        }
        private void ValidFlagEsElecMultipleNuevas(int paisID, int campania, string codPrograma, int consecutivoNueva, List<BEPedidoWebDetalle> listDetNuevas, List<BEProductoProgramaNuevas> listCuvNuevas)
        {
            var listCuvElectivas = listCuvNuevas.Where(c => !c.EsCuponIndependiente).ToList();
            if (listCuvElectivas.Count == 0) return;
            
            var nivelInput = new BENivelesProgramaNuevas { Campania = campania.ToString(), CodigoPrograma = codPrograma, CodigoNivel = "0" + (consecutivoNueva + 1) };
            var limElectivos = GetLimiteElectivos(paisID, nivelInput);
            if (limElectivos <= 1) return;

            var listDetalleElectivos = listDetNuevas.Where(d => listCuvElectivas.Any(c => c.CodigoCupon == d.CUV)).ToList();
            listDetalleElectivos.ForEach(d => d.EsElecMultipleNuevas = true);
        }

        #endregion
    }
}
