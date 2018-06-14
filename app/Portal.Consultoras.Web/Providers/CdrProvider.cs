using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class CdrProvider
    {
        protected ISessionManager sessionManager;
        
        public CdrProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }
        
        public List<BECDRWeb> CargarBECDRWeb(MisReclamosModel model, int paisId, long consultoraId)
        {
            List<BECDRWeb> entidadLista;
            try
            {
                if (sessionManager.GetCdrWeb() != null)
                {
                    return sessionManager.GetCdrWeb();
                }

                var entidad = new BECDRWeb
                {
                    CampaniaID = model.CampaniaID,
                    PedidoID = model.PedidoID,
                    ConsultoraID = int.Parse(consultoraId.ToString())
                };

                using (var sv = new CDRServiceClient())
                {
                    entidadLista = sv.GetCDRWeb(paisId, entidad).ToList();
                }

                sessionManager.SetCdrWeb(null);
                if (entidadLista.Count == 1)
                {
                    sessionManager.SetCdrWeb(entidadLista);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, consultoraId.ToString(), paisId.ToString());
                sessionManager.SetCdrWeb(null);
                entidadLista = new List<BECDRWeb>();
            }

            return entidadLista;
        }

        public List<BECDRWebDetalle> CargarDetalle(MisReclamosModel model, int paisId, string codigoIso)
        {
            try
            {
                if (sessionManager.GetCDRWebDetalle() != null)
                {
                    return sessionManager.GetCDRWebDetalle();
                }

                model = model ?? new MisReclamosModel();

                List<BECDRWebDetalle> lista;
                var entidad = new BECDRWebDetalle { CDRWebID = model.CDRWebID };
                using (var sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDetalle(paisId, entidad, model.PedidoID).ToList();
                }

                lista.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, paisId).Descripcion);
                lista.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, paisId).Descripcion);
                lista.Update(p => p.FormatoPrecio1 = Util.DecimalToStringFormat(p.Precio, codigoIso));
                lista.Update(p => p.FormatoPrecio2 = Util.DecimalToStringFormat(p.Precio2, codigoIso));
                sessionManager.SetCDRWebDetalle(lista);
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", codigoIso);
                sessionManager.SetCDRWebDetalle(null);
                return new List<BECDRWebDetalle>();
            }
        }

        public List<BECDRMotivoReclamo> CargarMotivo(MisReclamosModel model, DateTime date, int paisId, int campaniaId, long consultoraId)
        {
            var listaRetorno = new List<BECDRMotivoReclamo>();
            try
            {
                model.Operacion = Util.SubStr(model.Operacion, 0);
                var listaFiltro = CargarMotivoOperacionPorDias(model, date, paisId, campaniaId, consultoraId);
                foreach (var item in listaFiltro)
                {
                    if (item.CodigoOperacion != model.Operacion && model.Operacion != "")
                        continue;

                    if (listaRetorno.Any(r => r.CodigoReclamo == item.CodigoReclamo))
                        continue;

                    var desc = ObtenerDescripcion(item.CDRMotivoReclamo.CodigoReclamo, Constantes.TipoMensajeCDR.Motivo, paisId);
                    var add = new BECDRMotivoReclamo
                    {
                        CodigoReclamo = item.CodigoReclamo,
                        DescripcionReclamo = desc.Descripcion
                    };
                    listaRetorno.Add(add);
                }

                return listaRetorno;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return listaRetorno;
            }
        }
        
        public void CargarInformacion(int paisId, int campaniaId, long consultoraId)
        {
            sessionManager.SetCDRWebDetalle(null);
            sessionManager.SetCdrWeb(null);

            var listaMotivoOperacion = CargarMotivoOperacion(paisId);
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            var maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(paisId, campaniaId, consultoraId, maxDias);

            var listaCampanias = new List<CampaniaModel>();
            var campania = new CampaniaModel
            {
                CampaniaID = 0,
                NombreCorto = "¿En qué campaña lo solicitaste?"
            };
            listaCampanias.Add(campania);
            foreach (var facturado in listaPedidoFacturados)
            {
                var existe = listaCampanias.Where(c => c.CampaniaID == facturado.CampaniaID) ?? new List<CampaniaModel>();
                if (!existe.Any())
                {
                    campania = new CampaniaModel
                    {
                        CampaniaID = facturado.CampaniaID,
                        NombreCorto = facturado.CampaniaID.ToString()
                    };
                    listaCampanias.Add(campania);
                }
            }
            sessionManager.SetCdrCampanias(listaCampanias);

            CargarParametriaCdr(paisId);
            CargarCdrWebDatos(paisId);
        }

        public List<BECDRParametria> CargarParametriaCdr(int paisId)
        {
            try
            {
                if (sessionManager.GetCdrParametria() != null)
                {
                    var listaDescripcion = sessionManager.GetCdrParametria();
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                List<BECDRParametria> lista;
                var entidad = new BECDRParametria();
                using (var sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRParametria(paisId, entidad).ToList();
                }

                sessionManager.SetCdrParametria(lista);
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", paisId.ToString());
                sessionManager.SetCdrParametria(null);
                return new List<BECDRParametria>();
            }
        }

        public BECDRWebDatos ObtenerCdrWebDatosByCodigo(string codigo, int paisId)
        {
            return CargarCdrWebDatos(paisId).FirstOrDefault(p => p.Codigo == codigo);
        }

        public List<BECDRWebMotivoOperacion> CargarMotivoOperacionPorDias(MisReclamosModel model, DateTime date, int paisId, int campaniaId, long consultoraId)
        {
            var listaPedidoFacturado = CargarPedidosFacturados(paisId, campaniaId, consultoraId);
            var pedido = listaPedidoFacturado.FirstOrDefault(p => p.PedidoID == model.PedidoID) ?? new BEPedidoWeb();
            var fechaSys = date;
            var fechaFinCampania = pedido.FechaRegistro.Date;
            var diferencia = fechaSys - fechaFinCampania;
            var differenceInDays = diferencia.Days;

            if (differenceInDays <= 0) return new List<BECDRWebMotivoOperacion>();

            var listaMotivoOperacion = CargarMotivoOperacion(paisId);
            var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDRTipoOperacion.NumeroDiasAtrasOperacion >= differenceInDays).ToList();
            return listaFiltro.OrderBy(p => p.Prioridad).ToList();
        }
        
        public List<BEPedidoWeb> CargarPedidosFacturados(int paisId, int campaniaId, long consultoraId, int maxDias = 0)
        {
            try
            {
                if (sessionManager.GetCdrPedidosFacturado() != null)
                {
                    return sessionManager.GetCdrPedidosFacturado();
                }

                if (maxDias <= 0) return new List<BEPedidoWeb>();

                List<BEPedidoWeb> listaPedidoFacturados;
                using (var sv = new PedidoServiceClient())
                {
                    listaPedidoFacturados = sv.GetPedidosFacturadoSegunDias(paisId, campaniaId, consultoraId, maxDias).ToList();
                }

                sessionManager.SetCdrPedidosFacturado(listaPedidoFacturados);
                return listaPedidoFacturados;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, consultoraId.ToString(), paisId.ToString());
                sessionManager.SetCdrPedidosFacturado(null);
                return new List<BEPedidoWeb>();
            }
        }
        
        public BECDRWebDescripcion ObtenerDescripcion(string codigoSsic, string tipo, int paisId)
        {
            codigoSsic = Util.SubStr(codigoSsic, 0);
            tipo = Util.SubStr(tipo, 0);
            var listaDescripcion = CargarDescripcion(paisId);
            var desc = listaDescripcion.FirstOrDefault(d => d.CodigoSSIC == codigoSsic && d.Tipo == tipo) ?? new BECDRWebDescripcion();

            desc.Descripcion = Util.SubStr(desc.Descripcion, 0);
            return desc;
        }

        public string MensajeGestionCdrInhabilitadaYChatEnLinea(int esZonaValida, int indicadorBloqueo, DateTime fechaInicioCampania, double zonaHoraria, int paisId, int campaniaId, long consultoraId, bool EsAppMobile = false)
        {
            var mensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitada(esZonaValida, indicadorBloqueo, fechaInicioCampania, zonaHoraria, paisId, campaniaId, consultoraId);
            if (string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return mensajeGestionCdrInhabilitada;
            if (!EsAppMobile) mensajeGestionCdrInhabilitada = String.Format("{0} {1}", mensajeGestionCdrInhabilitada, Constantes.CdrWebMensajes.ContactateChatEnLinea);
            return mensajeGestionCdrInhabilitada;
        }

        private List<BECDRWebDatos> CargarCdrWebDatos(int paisId)
        {
            try
            {
                if (sessionManager.GetCdrWebDatos() != null)
                {
                    var listacdrWebDatos = sessionManager.GetCdrWebDatos();
                    if (listacdrWebDatos.Count > 0)
                        return listacdrWebDatos;
                }

                List<BECDRWebDatos> lista;
                var entidad = new BECDRWebDatos();
                using (var sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDatos(paisId, entidad).ToList();
                }

                sessionManager.SetCdrWebDatos(lista);
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", paisId.ToString());
                sessionManager.SetCdrWebDatos(null);
                return new List<BECDRWebDatos>();
            }
        }

        private string MensajeGestionCdrInhabilitada(int esZonaValida, int indicadorBloqueo, DateTime fechaInicioCampania, double zonaHoraria, int paisId, int campaniaId, long consultoraId)
        {
            if (esZonaValida == 0) return Constantes.CdrWebMensajes.ZonaBloqueada;
            if (indicadorBloqueo == 1) return Constantes.CdrWebMensajes.ConsultoraBloqueada;
            if (CumpleRangoCampaniaCDR(paisId, campaniaId, consultoraId) == 0) return Constantes.CdrWebMensajes.SinPedidosDisponibles;

            var diasFaltantes = Util.GetDiasFaltantesFacturacion(fechaInicioCampania, zonaHoraria);
            if (diasFaltantes == 0) return Constantes.CdrWebMensajes.FueraDeFecha;

            var cdrDiasAntesFacturacion = 0;
            var cdrWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.DiasAntesFacturacion, paisId);
            if (cdrWebDatos != null) int.TryParse(cdrWebDatos.Valor, out cdrDiasAntesFacturacion);
            if (diasFaltantes <= cdrDiasAntesFacturacion) return Constantes.CdrWebMensajes.FueraDeFecha;

            return string.Empty;
        }

        private List<BECDRWebDescripcion> CargarDescripcion(int paisId)
        {
            try
            {
                if (sessionManager.GetCdrDescripcion() != null)
                {
                    var listaDescripcion = sessionManager.GetCdrDescripcion();
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                List<BECDRWebDescripcion> lista;
                var entidad = new BECDRWebDescripcion();
                using (var sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDescripcion(paisId, entidad).ToList();
                }

                sessionManager.SetCdrDescripcion(lista);
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", paisId.ToString());
                sessionManager.SetCdrDescripcion(null);
                return new List<BECDRWebDescripcion>();
            }
        }

        private List<BECDRWebMotivoOperacion> CargarMotivoOperacion(int paisId)
        {
            try
            {
                if (sessionManager.GetCdrMotivoOperacion() != null)
                {
                    return sessionManager.GetCdrMotivoOperacion();
                }

                List<BECDRWebMotivoOperacion> listaMotivoOperacion;
                using (var sv = new CDRServiceClient())
                {
                    listaMotivoOperacion = sv.GetCDRWebMotivoOperacion(paisId, new BECDRWebMotivoOperacion()).ToList();
                }

                var diasFaltantes = 0;
                var cdrWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.ValidacionDiasFaltante, paisId);
                if (cdrWebDatos != null) int.TryParse(cdrWebDatos.Valor, out diasFaltantes);

                if (diasFaltantes > 0)
                {
                    var operacionFaltanteList = new List<string> { "F", "G" };
                    listaMotivoOperacion.Where(mo => operacionFaltanteList.Contains(mo.CodigoOperacion))
                        .Update(mo =>
                        {
                            mo.CDRTipoOperacion.NumeroDiasAtrasOperacion = Math.Min(diasFaltantes, mo.CDRTipoOperacion.NumeroDiasAtrasOperacion);
                        });
                }

                sessionManager.SetCdrMotivoOperacion(listaMotivoOperacion);
                return listaMotivoOperacion;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", paisId.ToString());
                sessionManager.SetCdrMotivoOperacion(null);
                return new List<BECDRWebMotivoOperacion>();
            }
        }
        
        private int CumpleRangoCampaniaCDR(int paisId, int campaniaId, long consultoraId)
        {
            var listaMotivoOperacion = CargarMotivoOperacion(paisId);
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            var maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(paisId, campaniaId, consultoraId, maxDias);
            return (listaPedidoFacturados.Count > 0) ? 1 : 0;
        }
    }
}