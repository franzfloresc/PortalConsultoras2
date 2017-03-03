using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseShowRoomController : BaseController
    {
        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            bool resultado = false;

            var showRoomEvento = new BEShowRoomEvento();
            var showRoomEventoConsultora = new BEShowRoomEventoConsultora();

            if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
            showRoomEventoConsultora = userData.BeShowRoomConsultora;
            showRoomEvento = userData.BeShowRoom;

            if (showRoomEvento != null && showRoomEvento.Estado == 1 && showRoomEventoConsultora != null)
            {
                int diasAntes = showRoomEvento.DiasAntes;
                int diasDespues = showRoomEvento.DiasDespues;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (esIntriga)
                {
                    if (!(fechaHoy >= userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Date
                    && fechaHoy <= userData.FechaInicioCampania.AddDays(showRoomEvento.DiasDespues).Date))
                    {
                        ViewBag.DiasFaltan = userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Day - fechaHoy.Day;
                        if (ViewBag.DiasFaltan > 0)
                        {
                            resultado = true;
                        }
                    }
                }
                else
                {
                    if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date &&
                     fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date))
                    {
                        resultado = true;
                    }
                }
            }

            return resultado;
        }

        public List<ShowRoomOfertaModel> ObtenerListaProductoShowRoom(int campaniaId, string codigoConsultora, bool esFacturacion = false)
        {
            var listaShowRoomOferta = new List<BEShowRoomOferta>();
            //var listaShowRoomOfertaModel = new List<ShowRoomOfertaModel>();
            var listaShowRoomOfertaFinal = new List<BEShowRoomOferta>();

            if (Session[Constantes.ConstSession.ListaProductoShowRoom] != null)
            {
                var listadoOfertasTodas = (List<BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom];
                var listadoOfertasTodasModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listadoOfertasTodas);
                listadoOfertasTodasModel.Update(x =>
                {
                    x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                    x.CodigoISO = userData.CodigoISO;
                    x.Simbolo = userData.Simbolo;
                });
                return listadoOfertasTodasModel;
            }

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, campaniaId, codigoConsultora).ToList();
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                if (listaShowRoomOferta != null)
                {
                    listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                    listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));
                }
            }

            var listaTieneStock = new List<Lista>();
            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                string codigoSap = "";
                foreach (var beProducto in listaShowRoomOferta)
                {
                    if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                    {
                        codigoSap += beProducto.CodigoProducto + "|";
                    }
                }

                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                try
                {
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new ServicePROLConsultas.wsConsulta())
                        {
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                            listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                    listaTieneStock = new List<Lista>();
                }
            }

            foreach (var beShowRoomOferta in listaShowRoomOferta)
            {
                bool tieneStockProl = true;
                if (esFacturacion)
                {
                    var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                    if (itemStockProl != null)
                        tieneStockProl = itemStockProl.estado == 1;
                }

                if (tieneStockProl)
                {
                    listaShowRoomOfertaFinal.Add(beShowRoomOferta);
                }
            }

            //Session[Constantes.ConstSession.ListaProductoShowRoom] = null;
            Session[Constantes.ConstSession.ListaProductoShowRoom] = listaShowRoomOfertaFinal;
            var listadoOfertasTodasModel1 = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOfertaFinal);
            listadoOfertasTodasModel1.Update(x =>
            {
                x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
            });
            return listadoOfertasTodasModel1;
        }

        public string GetDescripcionMarca(int marcaId)
        {
            string result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "Lbel";
                    break;
                case 2:
                    result = "Esika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 4:
                    result = "S&M";
                    break;
                case 5:
                    result = "Home Collection";
                    break;
                case 6:
                    result = "Finart";
                    break;
                case 7:
                    result = "Generico";
                    break;
                case 8:
                    result = "Glance";
                    break;
                default:
                    result = "NO DISPONIBLE";
                    break;
            }

            return result;
        }

        public ShowRoomOfertaModel ViewDetalleOferta(int id)
        {
            var modelo = GetOfertaConDetalle(id);
            modelo.ListaOfertaShowRoom = GetOfertaListadoExcepto(id);
            var listaDetalle = ObtenerPedidoWebDetalle();
            modelo.ListaOfertaShowRoom.Update(o => o.Agregado = (listaDetalle.Find(p => p.CUV == o.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none");

            // redes sociales
            modelo.FBRuta = GetUrlCompartirFB();
            var mensaje = "";
            modelo.ListaDetalleOfertaShowRoom.ToList().ForEach(d => mensaje += d.NombreProducto + " + ");
            mensaje = Util.Trim(mensaje);
            mensaje = mensaje.EndsWith("+") ? mensaje.Substring(0, mensaje.Length - 1) : mensaje;
            modelo.FBMensaje = modelo.Descripcion + ": " + Util.Trim(mensaje);

            // agrupar por marca
            modelo.ListaDetalleOfertaShowRoom = modelo.ListaDetalleOfertaShowRoom.OrderBy(d => d.MarcaProducto).ToList();
            var nombreMarca = "";
            modelo.ListaDetalleOfertaShowRoom.Update(d =>
            {
                d.MarcaProducto = d.MarcaProducto == nombreMarca ? "" : d.MarcaProducto;
                nombreMarca = d.MarcaProducto == nombreMarca ? nombreMarca : d.MarcaProducto;
            });
            return modelo;
        }

        public ShowRoomOfertaModel GetOfertaConDetalle(int idOferta)
        {
            var ofertaShowRoomModelo = new ShowRoomOfertaModel();
            //var modelo = new ShowRoomOfertaModel();
            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = new List<ShowRoomOfertaDetalleModel>();

            if (idOferta <= 0) return ofertaShowRoomModelo;

            var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);

            ofertaShowRoomModelo = listadoOfertasTodasModel.Find(o => o.OfertaShowRoomID == idOferta) ?? new ShowRoomOfertaModel();

            //modelo = (ShowRoomOfertaModel) ofertaShowRoomModelo.Clone();

            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = ofertaShowRoomModelo.ListaDetalleOfertaShowRoom ?? new List<ShowRoomOfertaDetalleModel>();
            if (ofertaShowRoomModelo.OfertaShowRoomID <= 0) return ofertaShowRoomModelo;

            ofertaShowRoomModelo.ImagenProducto = Util.Trim(ofertaShowRoomModelo.ImagenProducto);
            ofertaShowRoomModelo.ImagenProducto = ofertaShowRoomModelo.ImagenProducto == "" ? "/Content/Images/showroom/no_disponible.png" : ofertaShowRoomModelo.ImagenProducto;

            var listaDetalle = new List<BEShowRoomOfertaDetalle>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaDetalle = sv.GetProductosShowRoomDetalle(userData.PaisID, userData.CampaniaID, ofertaShowRoomModelo.CUV).ToList();
            }

            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = Mapper.Map<List<BEShowRoomOfertaDetalle>, List<ShowRoomOfertaDetalleModel>>(listaDetalle);
            
            return ofertaShowRoomModelo;

        }

        public List<ShowRoomOfertaModel> GetOfertaListadoExcepto(int idOferta)
        {
            var listaOferta = new List<ShowRoomOfertaModel>();
            if (idOferta <= 0) return listaOferta;

            var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            listaOferta = listadoOfertasTodasModel.Where(o => o.OfertaShowRoomID != idOferta).ToList();
            return listaOferta;
        }
    }
}