using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;

namespace Portal.Consultoras.Web.Providers
{
    public class EstrategiaComponenteProvider
    {
        private readonly ConfiguracionManagerProvider _configuracionManagerProvider;
        private readonly int _paisId;
        private readonly string _paisISO;
        
        public EstrategiaComponenteProvider(int paisId, string paisIso)
        {
            _configuracionManagerProvider = new ConfiguracionManagerProvider();
            _paisId = paisId;
            _paisISO = paisIso;
        }

        public List<EstrategiaComponenteModel> GetListaComponentes(EstrategiaPersonalizadaProductoModel estrategiaModelo, string codigoTipoEstrategia, out bool esMultimarca)
        {
            string joinCuv;
            esMultimarca = false;
            var listaBeEstrategiaProductos = GetEstrategiaProductos(estrategiaModelo, out joinCuv);
            if (joinCuv == "") return new List<EstrategiaComponenteModel>();

            var listaProductos = GetAppProductoBySap(estrategiaModelo, joinCuv);
            if (!listaProductos.Any()) return new List<EstrategiaComponenteModel>();

            var listaEstrategiaComponente = GetEstrategiaDetalleCompuesta(estrategiaModelo, listaBeEstrategiaProductos, listaProductos, codigoTipoEstrategia);
            //estrategiaModelo.CodigoVariante = "";
            var listaComponentesPorOrdenar = GetEstrategiaDetalleFactorCuadre(listaEstrategiaComponente);
            listaComponentesPorOrdenar = OrdenarComponentesPorMarca(listaComponentesPorOrdenar, out esMultimarca);
            return listaComponentesPorOrdenar;
        }

        private List<BEEstrategiaProducto> GetEstrategiaProductos(EstrategiaPersonalizadaProductoModel estrategiaModelo, out string codigoSap)
        {
            codigoSap = "";
            const string separador = "|";
            var txtBuil = new StringBuilder();
            txtBuil.Append(separador);

            var listaProducto = new List<BEEstrategiaProducto>();
            if (!string.IsNullOrEmpty(estrategiaModelo.CodigoVariante))
            {

                var estrategiaX = new BEEstrategia { PaisID = _paisId, EstrategiaID = estrategiaModelo.EstrategiaID };
                using (var svc = new PedidoServiceClient())
                {
                    listaProducto = svc.GetEstrategiaProducto(estrategiaX).ToList();
                }

                foreach (var item in listaProducto)
                {
                    item.SAP = Util.Trim(item.SAP);
                    if (item.SAP != "" && !txtBuil.ToString().Contains(separador + item.SAP + separador))
                        txtBuil.Append(item.SAP + separador);
                }
            }

            codigoSap = txtBuil.ToString();
            codigoSap = codigoSap == separador ? "" : codigoSap.Substring(separador.Length, codigoSap.Length - separador.Length * 2);

            return listaProducto;
        }

        private List<Producto> GetAppProductoBySap(EstrategiaPersonalizadaProductoModel estrategiaModelo, string joinSap)
        {
            List<Producto> listaAppCatalogo;
            var numeroCampanias = Convert.ToInt32(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));
            using (var svc = new ProductoServiceClient())
            {
                listaAppCatalogo = svc.ObtenerProductosPorCampaniasBySap(_paisISO, estrategiaModelo.CampaniaID, joinSap, numeroCampanias).ToList();
            }
            return listaAppCatalogo.Any() ? listaAppCatalogo : new List<Producto>();
        }

        private List<EstrategiaComponenteModel> GetEstrategiaDetalleCompuesta(EstrategiaPersonalizadaProductoModel estrategiaModelo,
                                                                    List<BEEstrategiaProducto> listaBeEstrategiaProductos,
                                                                    List<Producto> listaProductos,
                                                                    string codigoTipoEstrategia)
        {
            var listaEstrategiaComponenteProductos =
                Mapper.Map<List<Producto>, List<EstrategiaComponenteModel>>(listaProductos);

            var listaComponentesTemporal = new List<EstrategiaComponenteModel>();
            listaBeEstrategiaProductos = listaBeEstrategiaProductos.OrderBy(p => p.Grupo).ToList();
            listaEstrategiaComponenteProductos = listaEstrategiaComponenteProductos.OrderBy(p => p.CodigoProducto).ToList();

            var idPk = 1;
            listaEstrategiaComponenteProductos.ForEach(h => h.Id = idPk++);

            idPk = 0;
            foreach (var beEstrategiaProducto in listaBeEstrategiaProductos)
            {
                var componenteModel = (EstrategiaComponenteModel)
                    (listaEstrategiaComponenteProductos.FirstOrDefault(p => beEstrategiaProducto.SAP == p.CodigoProducto)
                    ?? new EstrategiaComponenteModel()).Clone();

                if (Util.Trim(componenteModel.CodigoProducto) == "" &&
                    estrategiaModelo.CodigoVariante != Constantes.TipoEstrategiaSet.CompuestaFija)
                    continue;

                if (listaEstrategiaComponenteProductos.Count(p => beEstrategiaProducto.SAP == p.CodigoProducto) > 1)
                {
                    componenteModel = (EstrategiaComponenteModel)
                        (listaEstrategiaComponenteProductos.FirstOrDefault(p => beEstrategiaProducto.SAP == p.CodigoProducto && p.Id > idPk)
                        ?? new EstrategiaComponenteModel()).Clone();
                }

                componenteModel.NombreComercial = string.Concat(componenteModel.NombreComercial, " ", componenteModel.Volumen);

                if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom)
                {
                    componenteModel.NombreComercial = string.Concat(Util.Trim(beEstrategiaProducto.NombreProducto), " ", beEstrategiaProducto.Descripcion1);
                }

                if (!string.IsNullOrEmpty(beEstrategiaProducto.ImagenProducto))
                {
                    componenteModel.Imagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + _paisISO, beEstrategiaProducto.ImagenProducto, Globals.UrlMatriz + "/" + _paisISO);
                }
                if (!string.IsNullOrEmpty(beEstrategiaProducto.NombreMarca))
                {
                    componenteModel.DescripcionMarca = beEstrategiaProducto.NombreMarca;
                }

                componenteModel.Orden = beEstrategiaProducto.Orden;
                componenteModel.Grupo = beEstrategiaProducto.Grupo;
                componenteModel.PrecioCatalogo = beEstrategiaProducto.Precio;
                componenteModel.PrecioCatalogoString = Util.DecimalToStringFormat(beEstrategiaProducto.Precio, _paisISO);
                componenteModel.Digitable = beEstrategiaProducto.Digitable;
                componenteModel.Cuv = Util.Trim(beEstrategiaProducto.CUV);
                componenteModel.Cantidad = beEstrategiaProducto.Cantidad;
                componenteModel.FactorCuadre = beEstrategiaProducto.FactorCuadre > 0 ? beEstrategiaProducto.FactorCuadre : 1;
                listaComponentesTemporal.Add(componenteModel);
                idPk = componenteModel.Id;
            }

            listaEstrategiaComponenteProductos = listaComponentesTemporal;

            switch (estrategiaModelo.CodigoVariante)
            {
                case Constantes.TipoEstrategiaSet.CompuestaFija:
                    listaEstrategiaComponenteProductos.ForEach(h => { h.Digitable = 0; });
                    listaEstrategiaComponenteProductos = listaEstrategiaComponenteProductos.Where(h => h.NombreComercial != "").ToList();
                    break;
                case Constantes.TipoEstrategiaSet.IndividualConTonos:
                    if (listaEstrategiaComponenteProductos.Count == 1)
                    {
                        listaEstrategiaComponenteProductos = new List<EstrategiaComponenteModel>();
                    }
                    else
                    {
                        listaEstrategiaComponenteProductos.ForEach(h => h.FactorCuadre = 1);
                        listaEstrategiaComponenteProductos = listaEstrategiaComponenteProductos.OrderBy(h => h.Orden).ToList();
                    }
                    break;
                default:
                    var listaComponentes = new List<EstrategiaComponenteModel>();
                    EstrategiaComponenteModel hermano;
                    foreach (var item in listaEstrategiaComponenteProductos)
                    {
                        hermano = (EstrategiaComponenteModel)item.Clone();
                        hermano.Hermanos = new List<EstrategiaComponenteModel>();
                        if (hermano.Digitable == 1)
                        {
                            var existe = false;
                            foreach (var itemR in listaComponentes)
                            {
                                existe = itemR.Hermanos.Any(h => h.Cuv == hermano.Cuv);
                                if (existe) break;
                            }
                            if (existe) continue;

                            hermano.Hermanos = listaEstrategiaComponenteProductos.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                        }

                        listaComponentes.Add(hermano);
                    }

                    listaEstrategiaComponenteProductos = listaComponentes.OrderBy(p => p.Orden).ToList();
                    break;
            }

            return listaEstrategiaComponenteProductos;
        }

        private List<EstrategiaComponenteModel> GetEstrategiaDetalleFactorCuadre(List<EstrategiaComponenteModel> listaHermanos)
        {
            var listaHermanosCuadre = new List<EstrategiaComponenteModel>();

            listaHermanos = listaHermanos ?? new List<EstrategiaComponenteModel>();
            foreach (var hermano in listaHermanos)
            {
                listaHermanosCuadre.Add((EstrategiaComponenteModel)hermano.Clone());

                if (hermano.FactorCuadre <= 1) continue;
                for (var i = 0; i < hermano.FactorCuadre - 1; i++)
                {
                    listaHermanosCuadre.Add((EstrategiaComponenteModel)hermano.Clone());
                }
            }

            return listaHermanosCuadre;
        }

        private List<EstrategiaComponenteModel> OrdenarComponentesPorMarca(List<EstrategiaComponenteModel> listaComponentesPorOrdenar, out bool esMultimarca)
        {
            int contador = 0;
            var listaComponentesOrdenados = new List<EstrategiaComponenteModel>();
            var listaComponentesCyzone = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>() : listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.Cyzone);
            var listaComponentesEzika = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>() : listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.Esika);
            var listaComponentesLbel = !listaComponentesPorOrdenar.Any() ? new List<EstrategiaComponenteModel>() : listaComponentesPorOrdenar.Where(x => x.IdMarca == Constantes.Marca.LBel);
            contador += listaComponentesCyzone.Any() ? 1 : 0;
            contador += listaComponentesEzika.Any() ? 1 : 0;
            contador += listaComponentesLbel.Any() ? 1 : 0;
            esMultimarca = contador > 1 ? true : false;
            listaComponentesOrdenados.AddRange(listaComponentesCyzone);
            listaComponentesOrdenados.AddRange(listaComponentesEzika);
            listaComponentesOrdenados.AddRange(listaComponentesLbel);
            return listaComponentesOrdenados;
        }
    }
}