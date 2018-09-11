using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class WebTracking : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var dataQueryString = Request.QueryString["data"];
            if (dataQueryString == null)
            {
                Response.Redirect("~/WebPages/UserUnknownLogin.aspx");
                return;
            }

            if (!CargarSessionConsultora(dataQueryString)) return;

            var campania = Request.QueryString["campania"];
            var nroPedido = Request.QueryString["nroPedido"];

            if (campania == null) CargarTablasMaestras();
            else CargarPedidoEspecifico(campania, nroPedido);

            lnkPoliticasVenta.NavigateUrl = Globals.RutaCdn + "/SeguimientoPedido/" + Convert.ToString(ViewState["PAISISO"]) + "/Politica.pdf";
            

        }

        protected void gridPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MOSTRAR")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());

                Label lblNumeroPedido = (Label)gridPedidos.Rows[index].FindControl("lblNumeroPedido");
                Label lblCampana = (Label)gridPedidos.Rows[index].FindControl("lblCampana");
                Label lblFecha = (Label)gridPedidos.Rows[index].FindControl("lblFecha");
                Label lblEstado = (Label)gridPedidos.Rows[index].FindControl("lblEstado");

                int paisId = Convert.ToInt32(ViewState["PAIS"]);
                string codigo = Convert.ToString(ViewState["CODIGO"]);
                string paisIso = Convert.ToString(ViewState["PAISISO"]);
                string campana = lblCampana.Text;
                string nropedido = lblNumeroPedido.Text;
                string estado = lblEstado.Text;
                DateTime fecha = Convert.ToDateTime(lblFecha.Text);

                pnlNovedadesEntrega.Visible = true;
                pnlNovedadesPostVenta.Visible = false;
                CargarSeguimientoPedido(paisId, codigo, campana, fecha, nropedido, paisIso, estado);
            }
        }

        protected void gridPostVenta_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MOSTRAR")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());

                Label lblNumeroRecojo = (Label)gridPostVenta.Rows[index].FindControl("lblNumeroRecojo");
                int estadoRecojoId = gridPostVenta.DataKeys[index] != null ? (int)gridPostVenta.DataKeys[index]["EstadoRecojoID"] : 0;
                int paisId = Convert.ToInt32(ViewState["PAIS"]);
                string nroRecojo = lblNumeroRecojo.Text;


                pnlNovedadesPostVenta.Visible = true;
                pnlNovedadesEntrega.Visible = false;
                CargarSeguimientoPostVenta(paisId, nroRecojo, estadoRecojoId);
            }
        }

        protected void gridDatos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string paisIso = Convert.ToString(ViewState["PAISISO"]);
            Image boton = (Image)e.Row.FindControl("imgMuestra");
            Image botonSi = (Image)e.Row.FindControl("imgSI");
            Image botonNo = (Image)e.Row.FindControl("imgNO");
            Image botonNo2 = (Image)e.Row.FindControl("imgNO2");
            Label lblTexto = (Label)e.Row.FindControl("lblTexto");
            Label lblFecha = (Label)e.Row.FindControl("lblFecha");
            LinkButton botonSegPed = (LinkButton)e.Row.FindControl("imgSegPed");
            Label lblTextoValorTurno = (Label)e.Row.FindControl("lblTextoValorTurno");

            if (lblTextoValorTurno != null)
                lblTextoValorTurno.ForeColor = System.Drawing.ColorTranslator.FromHtml((ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(paisIso)) ? "#e81c36" : "#b75d9f");

            if (boton == null)
                return;

            BETracking tracking = e.Row.DataItem as BETracking;

            if (tracking == null) return;

            string strSituacion = tracking.Situacion;

            if (strSituacion.Contains("<br/>"))
            {
                strSituacion = strSituacion.Substring(0, strSituacion.IndexOf("<br/>"));
            }

            string strFecha = string.Empty;

            if (tracking.Fecha.HasValue)
                strFecha = tracking.Fecha.Value.TimeOfDay.TotalHours.Equals(0) 
                    ? tracking.Fecha.Value.ToString("dd/MM/yyyy")
                    : tracking.Fecha.Value.ToString();

            if (strFecha == string.Empty)
            {
                botonSi.Visible = false;
                botonNo.Visible = true;
                if (strSituacion.ToUpper() == "CHEQUEADO")
                {
                    botonSi.Visible = false;
                    botonNo.Visible = false;
                }
            }
            else
            {
                if (strFecha == "01/01/2001")
                {
                    botonSi.Visible = false;
                    botonNo.Visible = true;
                }
                else
                {
                    if (strFecha == "01/01/2010" || strFecha == "02/01/2010")
                    {
                        botonNo.Visible = false;
                        if (strFecha == "01/01/2010")
                        {
                            botonSi.Visible = true;
                            botonNo2.Visible = false;
                            lblFecha.ForeColor = System.Drawing.Color.Blue;
                            lblFecha.Font.Bold = true;
                        }
                        else
                        {
                            botonSi.Visible = false;
                            botonNo2.Visible = true;
                            lblFecha.ForeColor = System.Drawing.Color.Red;
                            lblFecha.Font.Bold = true;
                        }

                        lblTexto.Visible = true;
                        botonSegPed.Visible = true;
                    }
                    else
                    {
                        botonSi.Visible = true;
                        botonNo.Visible = false;
                    }
                }
            }

            switch (strSituacion.ToUpper())
            {
                case "PEDIDO RECIBIDO":
                    boton.ImageUrl = "~/Content/Images/webtracking/pedidorecibido.png";
                    break;
                case "FACTURADO":
                    boton.ImageUrl = "~/Content/Images/webtracking/factura.png";
                    break;
                case "INICIO DE ARMADO":
                    boton.ImageUrl = "~/Content/Images/webtracking/box.png";
                    boton.Width = 70;
                    break;
                case "CHEQUEADO":
                    boton.ImageUrl = "~/Content/Images/webtracking/check.png";
                    boton.Width = 50;
                    break;
                case "PUESTO EN TRANSPORTE":
                    boton.ImageUrl = "~/Content/Images/webtracking/camion.png";
                    boton.Width = 70;
                    break;
                case "ENTREGADO":
                    boton.ImageUrl = "~/Content/Images/webtracking/home.png";
                    boton.Width = 55;
                    break;
                case "FECHA ESTIMADA DE ENTREGA":
                    boton.ImageUrl = "~/Content/Images/webtracking/calendario.png";
                    botonSi.Visible = false;
                    botonNo.Visible = false;
                    break;
            }

        }

        protected void BtnCancel1_Click(object sender, EventArgs e)
        {
            var hidMostrarAyuda = HidMostrarAyuda.Value;

            if (hidMostrarAyuda == "1")
            {
                int paisId = Convert.ToInt32(ViewState["PAIS"]);
                string codigo = Convert.ToString(ViewState["CODIGO"]);

                try
                {
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        sv.UpdateIndicadorAyudaWebTracking(paisId, codigo, true);
                    }
                    lblMensaje.Visible = false;
                }
                catch (Exception ex)
                {
                    lblMensaje.Visible = true;
                    lblMensaje.Text = ex.Message;
                }

                CheckBoxNo.Checked = true;
            }
            else
            {
                CheckBoxNo.Checked = false;
            }

        }

        private bool CargarSessionConsultora(string encriptado)
        {
            try
            {
                string cadenaDesencriptada = Util.DesencriptarQueryString(encriptado);
                string[] query = cadenaDesencriptada.Split(';');

                if (query.Length != 6)
                {
                    lblMensaje.Visible = true;
                    lblMensaje.Text = "El medio que envie la informacion en modo seguro, esta enviando de forma incorrecta. Notifique al área de tecnologia correspondiente. Gracias + Error: len de los datos=" + query.Length.ToString();
                    return false;
                }

                int paisId = Convert.ToInt32(query[0]);
                string codigoConsultora = query[1];
                int mostrarAyuda = Convert.ToInt32(query[2]);
                string paisIso = query[3];
                int campanhaId = int.Parse(query[4]);

                ViewState["CODIGO"] = codigoConsultora;
                ViewState["PAIS"] = paisId;
                ViewState["PAISISO"] = paisIso;
                ViewState["CAMPANHAID"] = campanhaId;
                ViewState["MOSTRARAYUDA"] = mostrarAyuda;
                return true;
            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = ex.Message;
                return false;
            }
        }

        private void CargarTablasMaestras()
        {
            try
            {
                int paisId = Convert.ToInt32(ViewState["PAIS"]);
                string codigoConsultora = Convert.ToString(ViewState["CODIGO"]);
                string paisIso = Convert.ToString(ViewState["PAISISO"]);
                //int campanhaId = Convert.ToInt32(ViewState["CAMPANHAID"]);
                int mostrarAyuda = Convert.ToInt32(ViewState["MOSTRARAYUDA"]);

                CargarPedidos(paisId, codigoConsultora);
                if (paisIso == Constantes.CodigosISOPais.Colombia)
                {
                    lnkPoliticasVenta.Visible = true;
                    pPostVenta.Visible = true;
                    CargarPostVenta(paisId, codigoConsultora);
                }
                else
                {
                    lnkPoliticasVenta.Visible = false;
                }

                MostrarAyuda(mostrarAyuda);
            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = ex.Message;
            }
        }

        private void CargarPedidoEspecifico(string campania, string nroPedido)
        {
            if (nroPedido == "0") nroPedido = null;
            try
            {
                int paisId = Convert.ToInt32(ViewState["PAIS"]);
                string codigoConsultora = Convert.ToString(ViewState["CODIGO"]);
                string paisIso = Convert.ToString(ViewState["PAISISO"]);

                BETracking beTracking;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    beTracking = sv.GetPedidoByConsultoraAndCampaniaAndNroPedido(paisId, codigoConsultora, Convert.ToInt32(campania), nroPedido);
                }

                pnlNovedadesEntrega.Visible = true;
                pnlNovedadesPostVenta.Visible = false;
                HtmlTableCell row1 = (HtmlTableCell)vTracking.FindControl("cellPedidos");
                row1.Style.Add("display", "none");

                CargarSeguimientoPedido(paisId, codigoConsultora, campania, beTracking.Fecha.HasValue ? beTracking.Fecha.Value : DateTime.Now, beTracking.NumeroPedido, paisIso, beTracking.Estado);
            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = ex.Message;
            }
        }

        private void CargarPedidos(int paisId, string codigo)
        {
            IList<BETracking> pedidos;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                pedidos = sv.GetPedidosByConsultora(paisId, codigo, 6);
            }

            List<BETracking> listaPedidos = new List<BETracking>();
            listaPedidos.AddRange(pedidos);

            gridPedidos.DataSource = listaPedidos;
            gridPedidos.DataBind();
        }

        private void CargarPostVenta(int paisId, string codigo)
        {
            IList<BEPostVenta> postVentas;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                postVentas = sv.GetMisPostVentaByConsultora(paisId, codigo);
            }

            List<BEPostVenta> listaPostVenta = new List<BEPostVenta>();
            listaPostVenta.AddRange(postVentas);

            gridPostVenta.DataSource = listaPostVenta;
            gridPostVenta.DataBind();
        }

        public void CargarSeguimientoPedido(int paisID, string codigo, string campana, DateTime fecha, string nropedido, string paisISO, string estado)
        {
            try
            {
                pnlSeguimientoPedido.Visible = true;
                pnlSeguimientoPostVenta.Visible = false;
                pnlSinTracking.Visible = false;


                if (string.IsNullOrEmpty(nropedido))
                {
                    lblMensajeSinTracking.Text = ConfigurationManager.AppSettings["MensajeSinTracking"].ToString();
                    pnlSinTracking.Visible = true;

                    gridDatos.DataSource = null;
                    gridDatos.DataBind();

                    gvNovedades.DataSource = null;
                    gvNovedades.DataBind();

                    lblMensaje.Visible = false;

                    return;
                }

                IList<BENovedadTracking> novedades = new List<BENovedadTracking>();
                BENovedadFacturacion obeNovedadFacturacion;
                IList<BETracking> tracking;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    tracking = sv.GetTrackingByPedido(paisID, codigo, campana, nropedido);

                    if (ConfigurationManager.AppSettings["WebTrackingConfirmacion"].Contains(paisISO))
                    {
                        novedades = sv.GetNovedadesTracking(paisID, nropedido);
                    }
                    
                    pnlStatusGeneral.Visible = false;
                    if (estado == "RECHAZADO")
                    {
                        obeNovedadFacturacion = sv.GetPedidoRechazadoByConsultora(paisID, campana, codigo, fecha);
                        if (obeNovedadFacturacion != null)
                        {
                            lblEstadoFacturacion.Text = "RECHAZADO";
                            lblNovedadFacturacion.Text = "PEDIDO RECHAZADO POR " + obeNovedadFacturacion.DescripcionMotivo.ToUpper();
                            pnlStatusGeneral.Visible = true;
                        }
                    }

                    if (estado == "ANULADO")
                    {
                        obeNovedadFacturacion = sv.GetPedidoAnuladoByConsultora(paisID, campana, codigo, fecha, nropedido);
                        if (obeNovedadFacturacion != null)
                        {
                            lblEstadoFacturacion.Text = "ANULADO";
                            lblNovedadFacturacion.Text = obeNovedadFacturacion.DescripcionMotivo.ToUpper();
                            pnlStatusGeneral.Visible = true;
                        }
                    }
                }

                if (tracking.Count == 0)
                {
                    tracking = AgregarTracking(codigo, fecha);
                }
                else
                {
                    foreach (var item in tracking)
                    {
                        string strFecha = string.Empty;
                        string strTexto = string.Empty;

                        if (item.Fecha.HasValue)
                            strFecha = item.Fecha.Value.TimeOfDay.TotalHours.Equals(0) 
                                ? item.Fecha.Value.ToString("d/MM/yyyy") 
                                : item.Fecha.Value.ToString();

                        if (strFecha == "01/01/2001" || strFecha == "01/01/0001" || strFecha == "1/01/0001")
                        {
                            strFecha = string.Empty;
                        }
                        else
                        {
                            if (strFecha == "1/01/2010" || strFecha == "2/01/2010")
                            {
                                if (strFecha == "1/01/2010")
                                {
                                    IList<BENovedadTracking> temp = novedades.Where(p => p.TipoEntrega == "01").ToList();
                                    if (temp.Count != 0)
                                        strFecha = temp[0].FechaNovedad.ToString();
                                    strTexto = "Mira el detalle de tu entrega";
                                }
                                else
                                {
                                    strFecha = "No Entregado";
                                    strTexto = "Mira los detalles";
                                }
                            }
                        }

                        item.CodigoConsultora = strFecha;
                        item.NumeroPedido = strTexto;
                        
                        if (item.Etapa == 6 && !string.IsNullOrEmpty(item.ValorTurno))
                        {
                            if (item.ValorTurno.ToUpper() == "AM")
                            {
                                item.ValorTurno = "<b>En la mañana</b>";
                            }
                            else if (item.ValorTurno.ToUpper() == "PM")
                            {
                                item.ValorTurno = "<b>En la tarde</b>";
                            }
                            else
                            {
                                item.ValorTurno = string.Empty;
                            }
                        }
                    }

                    lblNovCampania.Text = campana;
                    lblNovEstado.Text = estado;
                    lblNovFecha.Text = fecha.ToString("dd/MM/yyyy");
                    lblNovNroPedido.Text = nropedido;
                }

                gridDatos.DataSource = tracking;
                gridDatos.DataBind();

                gvNovedades.DataSource = novedades;
                gvNovedades.DataBind();

                lblMensaje.Visible = false;
            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = ex.Message;
            }
        }

        public void CargarSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoRecojoID)
        {
            try
            {
                pnlSeguimientoPostVenta.Visible = true;
                pnlSeguimientoPedido.Visible = false;

                IList<BEPostVenta> listaSeguimiento;
                IList<BEPostVenta> listaNovedadesPostVenta;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaSeguimiento = sv.GetSeguimientoPostVenta(paisID, numeroRecojo, estadoRecojoID);
                    listaNovedadesPostVenta = sv.GetNovedadPostVenta(paisID, numeroRecojo);
                }

                lblNovNroPedido.Text = listaNovedadesPostVenta.Select(i => i.NumeroRecojo).FirstOrDefault();
                lblNovFecha.Text = listaNovedadesPostVenta.Select(i => i.FechaRecojo.ToString("dd/MM/yyyy")).FirstOrDefault();
                lblNovCampania.Text = listaNovedadesPostVenta.Select(i => i.Campania).FirstOrDefault();
                lblNovEstado.Text = listaNovedadesPostVenta.Select(i => i.EstadoRecojo).FirstOrDefault();

                gridSeguimientoPostVenta.DataSource = listaSeguimiento;
                gridSeguimientoPostVenta.DataBind();

                gvNovedadesPostVenta.DataSource = listaNovedadesPostVenta;
                gvNovedadesPostVenta.DataBind();

                lblMensaje.Visible = false;
            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = ex.Message;
            }
        }

        private IList<BETracking> AgregarTracking(string codigo, DateTime fecha)
        {
            List<BETracking> lista = new List<BETracking>();
            BETracking beTracking = new BETracking();
            beTracking.CodigoConsultora = codigo;
            beTracking.Etapa = 1;
            beTracking.Situacion = "Pedido Recibido";
            beTracking.Fecha = fecha;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 2;
            beTracking.Situacion = "Facturado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 3;
            beTracking.Situacion = "Inicio de Armado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 4;
            beTracking.Situacion = "Chequeado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 5;
            beTracking.Situacion = "Puesto en transporte";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 6;
            beTracking.Situacion = "Fecha Estimada de Entrega";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 7;
            beTracking.Situacion = "Entregado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            return lista;
        }

        public void MostrarAyuda(int indicador)
        {
            if (indicador == 1)
            {
                CheckBoxNo.Checked = true;
                return;
            }

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Ayuda", "openAyuda();", true);
        }

        protected void gridDatos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "NOVEDADES")
            {
                mvTracking.ActiveViewIndex = 1;

                gvNovedades.SelectedIndex = 0;
                if (gvNovedades.DataKeys[0] != null)
                {
                    string lat = (string) gvNovedades.DataKeys[0]["Latitud"];
                    string longi = (string) gvNovedades.DataKeys[0]["Longitud"];
                    string novedad = "Entrega";

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Mapa",
                        "CargarMapa(" + lat + "," + longi + ",'" + novedad + "');", true);
                }
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            mvTracking.ActiveViewIndex = 0;
        }

        protected void gvNovedades_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Mapa")
            {

                int index = Convert.ToInt32(e.CommandArgument.ToString());
                gvNovedades.SelectedIndex = index;

                if (gvNovedades.DataKeys[index] != null)
                {
                    string lat = (string) gvNovedades.DataKeys[index]["Latitud"];
                    string longi = (string) gvNovedades.DataKeys[index]["Longitud"];
                    string novedad = "Entrega";

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Mapa",
                        "CargarMapa(" + lat + "," + longi + ",'" + novedad + "');", true);
                }

            }

            else if (e.CommandName == "Foto")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());

                if (gvNovedades.DataKeys[index] != null)
                {
                    string urlImagen = (string)gvNovedades.DataKeys[index]["Foto"];
                    string novedad = "Entrega";

                    int imagenExiste = 0;

                    if (!string.IsNullOrEmpty(urlImagen))
                    {
                        imagenExiste = 1;
                    }

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Foto", "CargarFoto(" + imagenExiste + ",'" + urlImagen + "','" + novedad + "');", true);
                }

            }

            else if (e.CommandName == "Boleta")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                if (gvNovedades.DataKeys[index] != null)
                {
                    string urlImagen = (string) gvNovedades.DataKeys[index]["Boleta"];
                    string novedad = "Entrega";

                    int imagenExiste = 0;

                    if (!string.IsNullOrEmpty(urlImagen))
                    {
                        imagenExiste = 1;
                    }

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Boleta",
                        "CargarBoleta(" + imagenExiste + ",'" + urlImagen + "','" + novedad + "');", true);

                }

            }

        }

        protected void gvNovedades_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string paisIso = Convert.ToString(ViewState["PAISISO"]);

            if (paisIso == Constantes.CodigosISOPais.Colombia && e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton botonFoto = (ImageButton)e.Row.FindControl("btnFoto");
                botonFoto.Visible = true;

                ImageButton botonBoleta = (ImageButton)e.Row.FindControl("btnBoleta");
                botonBoleta.Visible = true;
            }

        }

        protected void gridSeguimientoPostVenta_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Image boton = (Image)e.Row.FindControl("imgMuestra");
            Image botonSi = (Image)e.Row.FindControl("imgSI");
            Image botonNo2 = (Image)e.Row.FindControl("imgNO2");
            Label lblTexto = (Label)e.Row.FindControl("lblTexto");
            Label lblFecha = (Label)e.Row.FindControl("lblFecha");
            LinkButton botonSegPed = (LinkButton)e.Row.FindControl("imgSegPed");

            if (boton != null)
            {
                BEPostVenta seguimientoPostVenta = e.Row.DataItem as BEPostVenta;
                if (seguimientoPostVenta == null) return;

                int estadoRecojoId = seguimientoPostVenta.EstadoRecojoID;
                if (estadoRecojoId == 0) boton.ImageUrl = "~/Content/Images/webtracking/calendario.png";
                else
                {
                    lblFecha.ForeColor = System.Drawing.Color.Blue;
                    lblFecha.Font.Bold = true;
                    lblTexto.Text = "Mira el detalle de tu recojo";
                    lblTexto.Visible = true;
                    botonSegPed.Visible = true;
                    boton.ImageUrl = "~/Content/Images/webtracking/home.png";
                    boton.Width = 55;

                    if (estadoRecojoId == 1)
                    {
                        botonSi.Visible = true;
                        botonNo2.Visible = false;
                    }
                    else
                    {
                        botonNo2.Visible = true;
                        botonSi.Visible = false;
                    }
                }
            }
        }

        protected void gridSeguimientoPostVenta_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "NOVEDADES")
            {
                mvTracking.ActiveViewIndex = 1;

                gvNovedadesPostVenta.SelectedIndex = 0;
                if (gvNovedadesPostVenta.DataKeys[0] != null)
                {
                    string lat = (string) gvNovedadesPostVenta.DataKeys[0]["Latitud"];
                    string longi = (string) gvNovedadesPostVenta.DataKeys[0]["Longitud"];
                    string novedad = "Recojo";

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Mapa",
                        "CargarMapa(" + lat + "," + longi + ",'" + novedad + "');", true);

                }

            }

        }

        protected void gvNovedadesPostVenta_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Mapa")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                gvNovedadesPostVenta.SelectedIndex = index;
                if (gvNovedadesPostVenta.DataKeys[index] != null)
                {
                    string lat = (string)gvNovedadesPostVenta.DataKeys[index]["Latitud"];
                    string longi = (string)gvNovedadesPostVenta.DataKeys[index]["Longitud"];
                    string novedad = "Recojo";

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Mapa", "CargarMapa(" + lat + "," + longi + ",'" + novedad + "');", true);
                }
            }

            else if (e.CommandName == "Foto")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                if (gvNovedadesPostVenta.DataKeys[index] != null)
                {
                    string urlImagen = (string)gvNovedadesPostVenta.DataKeys[index]["Foto1"];
                    string novedad = "Recojo";

                    int imagenExiste = 0;

                    if (!string.IsNullOrEmpty(urlImagen))
                    {
                        imagenExiste = 1;
                    }

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Foto", "CargarFoto(" + imagenExiste + ",'" + urlImagen + "','" + novedad + "');", true);
                }

            }

            else if (e.CommandName == "Boleta")
            {
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                if (gvNovedadesPostVenta.DataKeys[index] != null)
                {
                    string urlImagen = (string)gvNovedadesPostVenta.DataKeys[index]["Foto2"];
                    string novedad = "Recojo";

                    int imagenExiste = 0;

                    if (!string.IsNullOrEmpty(urlImagen))
                    {
                        imagenExiste = 1;
                    }

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Boleta", "CargarBoleta(" + imagenExiste + ",'" + urlImagen + "','" + novedad + "');", true);
                }

            }
        }

        protected void gvNovedadesPostVenta_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string paisIso = Convert.ToString(ViewState["PAISISO"]);

            if (paisIso == Constantes.CodigosISOPais.Colombia && e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton botonFoto = (ImageButton)e.Row.FindControl("btnFoto");
                botonFoto.Visible = true;

                ImageButton botonBoleta = (ImageButton)e.Row.FindControl("btnBoleta");
                botonBoleta.Visible = true;
            }
        }
    }
}
