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
            esMultimarca = false;
            var listaBeEstrategiaProductos = GetEstrategiaProductos(estrategiaModelo);

            if (!listaBeEstrategiaProductos.Any()) return new List<EstrategiaComponenteModel>();

            var listaEstrategiaComponente = GetEstrategiaDetalleCompuesta(estrategiaModelo, listaBeEstrategiaProductos, codigoTipoEstrategia);
            //var listaComponentesPorOrdenar = GetEstrategiaDetalleFactorCuadre(listaEstrategiaComponente);
            var listaComponentesPorOrdenar = OrdenarComponentesPorMarca(listaEstrategiaComponente, out esMultimarca);
            return listaComponentesPorOrdenar;
        }

        public List<BEEstrategiaProducto> GetEstrategiaProductosList(EstrategiaPersonalizadaProductoModel estrategiaModelo, out string codigoSap)
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


            return listaProducto;
        }


        private List<BEEstrategiaProducto> GetEstrategiaProductos(EstrategiaPersonalizadaProductoModel estrategiaModelo)
        {
            var listaProducto = new List<BEEstrategiaProducto>();

            if (string.IsNullOrEmpty(estrategiaModelo.CodigoVariante)) return listaProducto;

            using (var svc = new PedidoServiceClient())
            {
                var parameters = new BEEstrategia { PaisID = _paisId, EstrategiaID = estrategiaModelo.EstrategiaID };
                listaProducto = svc.GetEstrategiaProducto(parameters).ToList();
            }

            listaProducto.ForEach(x =>
            {
                x.NombreComercial = x.NombreComercial ?? string.Empty;
                x.NombreBulk = x.NombreBulk ?? string.Empty;
                //
                if (!string.IsNullOrWhiteSpace(x.NombreBulk))
                {
                    x.NombreComercial = string.IsNullOrWhiteSpace(x.NombreBulk)
                        ? x.NombreComercial
                        : x.NombreComercial.Replace(x.NombreBulk, string.Empty);
                }
                else
                {
                    x.NombreBulk = x.NombreComercial;
                }
                //
                x.ImagenProducto = x.ImagenProducto ?? string.Empty;
                x.ImagenBulk = x.ImagenBulk ?? string.Empty;
                if (string.IsNullOrWhiteSpace(x.ImagenProducto) && string.IsNullOrWhiteSpace(x.ImagenBulk)) return;
                var codigoIsoPais = SessionManager.SessionManager.Instance.GetUserData().CodigoISO;
                var campaniaId = SessionManager.SessionManager.Instance.GetUserData().CampaniaID;
                var codigoMarca = string.Empty;
                if (x.IdMarca == Constantes.Marca.LBel) codigoMarca = "L";
                if (x.IdMarca == Constantes.Marca.Esika) codigoMarca = "E";
                if (x.IdMarca == Constantes.Marca.Cyzone) codigoMarca = "C";
                x.ImagenBulk = string.IsNullOrWhiteSpace(x.ImagenBulk) ?
                    string.Format(_configuracionManagerProvider.GetRutaImagenesAppCatalogo(), codigoIsoPais, campaniaId, codigoMarca, x.ImagenProducto) :
                    string.Format(_configuracionManagerProvider.GetRutaImagenesAppCatalogoBulk(), codigoIsoPais, campaniaId, codigoMarca,x.ImagenBulk);
            });

            return listaProducto;
        }

        private List<EstrategiaComponenteModel> GetEstrategiaDetalleCompuesta(EstrategiaPersonalizadaProductoModel estrategiaModelo,
                                                                    List<BEEstrategiaProducto> listaBeEstrategiaProductos,
                                                                    string codigoTipoEstrategia)
        {
            var listaComponentesTemporal = new List<EstrategiaComponenteModel>();
            listaBeEstrategiaProductos = listaBeEstrategiaProductos.OrderBy(p => p.Grupo).ToList();

            var idPk = 0;
            foreach (var beEstrategiaProducto in listaBeEstrategiaProductos)
            {
                var componenteModel = new EstrategiaComponenteModel { };
                componenteModel.NombreComercial = string.Concat(beEstrategiaProducto.NombreComercial, " ", beEstrategiaProducto.Volumen);

                if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom)
                {
                    componenteModel.NombreComercial = string.IsNullOrEmpty(beEstrategiaProducto.NombreProducto)
                        ? componenteModel.NombreComercial
                        : string.Concat(Util.Trim(beEstrategiaProducto.NombreProducto), " ", beEstrategiaProducto.Volumen);
                }
                //else
                //{
                //    componenteModel.NombreComercial = string.IsNullOrEmpty(beEstrategiaProducto.NombreComercial)
                //        ? beEstrategiaProducto.NombreProducto
                //        : string.Empty;
                //}

                componenteModel.Descripcion = beEstrategiaProducto.Descripcion;
                componenteModel.NombreBulk = beEstrategiaProducto.NombreBulk;
                componenteModel.ImagenBulk = beEstrategiaProducto.ImagenBulk;
                componenteModel.DescripcionMarca = beEstrategiaProducto.NombreMarca;
                componenteModel.IdMarca = beEstrategiaProducto.IdMarca;
                componenteModel.Orden = beEstrategiaProducto.Orden;
                componenteModel.Grupo = beEstrategiaProducto.Grupo;
                componenteModel.PrecioCatalogo = beEstrategiaProducto.Precio;
                componenteModel.PrecioCatalogoString = Util.DecimalToStringFormat(beEstrategiaProducto.Precio, _paisISO);
                componenteModel.Digitable = beEstrategiaProducto.Digitable;
                componenteModel.Cuv = Util.Trim(beEstrategiaProducto.CUV);
                componenteModel.Cantidad = beEstrategiaProducto.Cantidad;
                componenteModel.FactorCuadre = beEstrategiaProducto.FactorCuadre > 0 ? beEstrategiaProducto.FactorCuadre : 1;
                componenteModel.NombreComercial = Util.Trim(componenteModel.NombreComercial);
                if (componenteModel.NombreComercial == "")
                {
                    componenteModel.NombreComercial = beEstrategiaProducto.NombreProducto;
                }

                listaComponentesTemporal.Add(componenteModel);
                idPk = componenteModel.Id;
            }

            switch (estrategiaModelo.CodigoVariante)
            {
                case Constantes.TipoEstrategiaSet.CompuestaFija:
                    listaComponentesTemporal.ForEach(h => { h.Digitable = 0; });
                    listaComponentesTemporal = listaComponentesTemporal.Where(h => h.NombreComercial != "").ToList();
                    break;
                case Constantes.TipoEstrategiaSet.IndividualConTonos:
                    if (listaComponentesTemporal.Count == 1)
                    {
                        listaComponentesTemporal = new List<EstrategiaComponenteModel>();
                    }
                    else
                    {
                        listaComponentesTemporal.ForEach(h => h.FactorCuadre = 1);
                        listaComponentesTemporal = listaComponentesTemporal.OrderBy(h => h.Orden).ToList();
                    }
                    break;
                default:
                    var listaComponentes = new List<EstrategiaComponenteModel>();
                    EstrategiaComponenteModel hermano;
                    foreach (var item in listaComponentesTemporal)
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

                            hermano.Hermanos = listaComponentesTemporal.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                        }

                        if (hermano.Hermanos.Any())
                        {
                            hermano.NombreComercial = string.IsNullOrWhiteSpace(hermano.NombreBulk) ? hermano.NombreComercial : hermano.NombreComercial.Replace(hermano.NombreBulk, "");
                        }

                        listaComponentes.Add(hermano);
                    }

                    listaComponentesTemporal = listaComponentes.OrderBy(p => p.Orden).ToList();
                    break;
            }

            return listaComponentesTemporal;
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
            esMultimarca = contador > 1;
            listaComponentesOrdenados.AddRange(listaComponentesCyzone);
            listaComponentesOrdenados.AddRange(listaComponentesEzika);
            listaComponentesOrdenados.AddRange(listaComponentesLbel);
            return listaComponentesOrdenados;
        }
    }
}