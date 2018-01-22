using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.Controllers;
using EasyCallback;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Portal.Consultoras.Common;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Configuration;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class RecuperarClave : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(RecuperarClaveCS);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string urlportal = ConfigurationManager.AppSettings["URLSite"];

            if (!Page.IsPostBack)
            {
                string uAg = Request.ServerVariables["HTTP_USER_AGENT"];
                Regex regEx = new Regex(@"android|iphone|ipad|ipod|blackberry|symbianos|nokia", RegexOptions.IgnoreCase);
                bool isMobile = regEx.IsMatch(uAg);

                if (isMobile)
                    Response.Redirect(urlportal + "/WebPages/RecuperarClaveMobile.aspx");

                DropDowListPaises();
            }
        }

        private void DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList();
                lst.Insert(0, new BEPais { PaisID = 0, NombreCorto = "-- Seleccione --" });
            }

            ddlPais.DataSource = lst;
            ddlPais.DataTextField = "NombreCorto";
            ddlPais.DataValueField = "PaisID";
            ddlPais.DataBind();
        }

        public string RecuperarClaveCS(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                string password = "";
                string mensaje = "";
                List<BEUsuarioCorreo> lst;
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    string correo = datos["Correo"].ToString();
                    int codigoPais = Convert.ToInt32(datos["IdPais"].ToString());

                    lst = sv.SelectByEmail(correo, codigoPais).ToList();

                    if (codigoPais.ToString().Trim() == "4")
                    {
                        if (lst.Count == 0)
                        {
                            return serializer.Serialize(new
                            {
                                succes = false,
                                pais = codigoPais,
                                mensaje = "El Número de Cédula ingresado no existe."
                            });
                        }
                        else
                        {
                            correo = lst[0].Descripcion; // contiene el correo del destinatario
                            if (correo.Trim() == "")
                            {
                                return serializer.Serialize(new
                                {
                                    succes = false,
                                    pais = codigoPais,
                                    mensaje = "No tienes un correo registrado para el envío de tu clave.<br />Por favor comunícate con el Servicio de Atención al Cliente 0-8000-9-37452"
                                });
                            }
                        }// 1895 - Fin
                    }
                    // 1891 - Fin

                    if (lst[0].Cantidad == 0)
                        return serializer.Serialize(new
                        {
                            succes = false,
                            estado = "2",
                            pais = codigoPais,
                            numero = lst[0].Descripcion
                        });
                    else
                    {
                        password = Util.CreateRandomPassword(8);
                        bool result = sv.ChangePasswordUser(codigoPais, "SISTEMA", lst[0].CodigoISO + lst[0].CodigoUsuario, password, correo, EAplicacionOrigen.RecuperarClave);
                        if (result)
                        {
                            #region Mensaje
                            mensaje = mensaje + "<body style='font-family:Arial, Helvetica, sans-serif; font-size: 12px; color:#333333; margin:0; padding:0; background-color:#F0F0F0;'>" +
                                                    "<table width='100%' border='0' cellpadding='0' cellspacing='0'>" +
                                                        "<tr>" +
                                                            "<td width='100%' style='height: 50px; background:#6C207F;'>&nbsp;</td>" +
                                                        "</tr>" +
                                                    "</table>" +
                                                    "<table width='100%' border='0' cellpadding='0' cellspacing='0' style='padding:0px; margin:0px;' >" +
                                                        "<tr>" +
                                                            "<td width='100%' style='text-align:center; background-color:#F0F0F0; overflow:hidden; display:block; padding: 24px 0px 24px 0px;'>" +
                                                                "<table border='0' cellpadding='0' cellspacing='0' style='width:722px; margin: 0px auto; text-align:left;' >" +
                                                                    "<tr>" +
                                                                        "<td valign='top'>" +
                                                                            "<table width='722' border='0' cellpadding='0' cellspacing='0'>" +
                                                                                "<tr>" +
                                                                                    "<td align='left' style='color:#6C207F; font-size:25px; padding: 0px 0px 10px 0px; text-align:left;'>" +
                                                                                        "BELCORP" +
                                                                                    "</td>" +
                                                                                "</tr>" +
                                                                                "<tr>" +
                                                                                    "<td width='722' valign='top' style='background:#E5E5E5; line-height: 18px; padding: 20px 20px 30px 20px;'>" +
                                                                                        "<table width='100%' border='0' cellpadding='0'>" +
                                                                                            "<tr>" +
                                                                                                "<td style='padding: 0px 0px 15px 0px; text-align:left; display:block;'><b>Hola:</b> " + lst[0].NombreCompleto + "</td>" +
                                                                                            "</tr>" +
                                                                                            "<tr>" +
                                                                                                "<td style='padding: 0px 0px 15px 0px; text-align:left; display:block;'>" +
                                                                                                    "Tu nueva clave secreta para ingresar a <b><a href='http://www.somosbelcorp.com' style='color:#333333; text-align:left;'>www.somosbelcorp.com</a></b> es: " + password +
                                                                                                "</td>" +
                                                                                            "</tr>" +
                                                                                            "<tr>" +
                                                                                                "<td style='padding: 0px; text-align:left;'>" +
                                                                                                    "Te recomendamos cambiarla por otra clave que te sea más fácil recordar." +
                                                                                                "</td>" +
                                                                                            "</tr>" +
                                                                                            "<tr>" +
                                                                                                "<td style='padding: 0px 0px 15px 0px; text-align:left;'>" +
                                                                                                    "<b>IMPORTANTE:</b> Tu clave es de uso personal. Mantenla segura y no la compartas con nadie." +
                                                                                                "</td>" +
                                                                                            "</tr>" +
                                                                                            "<tr>" +
                                                                                                "<td style='padding: 0px 0px 15px 0px; text-align:left;'>Guardar este correo en caso que necesites esta información.</td>" +
                                                                                            "</tr>" +
                                                                                            "<tr>" +
                                                                                                "<td style='text-align:left;'>Gracias,</td>" +
                                                                                            "</tr>" +
                                                                                            "<tr>" +
                                                                                                "<td>Equipo BELCORP</td>" +
                                                                                            "</tr>" +
                                                                                        "</table>" +
                                                                                    "</td>" +
                                                                                "</tr>" +
                                                                            "</table>" +
                                                                        "</td>" +
                                                                    "</tr>" +
                                                                "</table>" +
                                                            "</td>" +
                                                        "</tr>" +
                                                    "</table>" +
                                                    "<table width='100%' border='0' cellpadding='0' cellspacing='0' style='text-align:center;'>" +
                                                    "<tr>" +
                                                    "<td width='100%' style='height: 50px; background:#FFFFFF;'>" +
                                                        "<table border='0' cellpadding='0' cellspacing='0' style='width:722px; margin:0px auto;'>" +
                                                          "<tr>" +
                                                            "<td style='padding: 5px 0px 0px 0px; font-size: 11px; color:#6C207F; text-align:right;'>" +
                                                                "Copyright Belcorp 2013. All rights reserved" +
                                                            "</td>" +
                                //Mejora - Correo
                                //"</tr>" +
                                //"<tr>" +
                                //  "<td style='font-family:Arial, Helvetica, sans-serif, serif; font-weight:bold; font-size:12px; text-align:right; padding-top:8px;'>Belcorp - " + nomPais + "</td>" +
                                                          "</tr>" +
                                                        "</table>" +
                                                    "</td>" +
                                                  "</tr>" +
                                                "</table>" +
                                            "</body>";
                            #endregion
                            Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + lst[0].CodigoISO + ") Cambio de contraseña de Somosbelcorp", mensaje, true, "Somos Belcorp");
                            return serializer.Serialize(new
                            {
                                succes = true,
                                pais = codigoPais,
                                mensaje = "Te hemos enviado una nueva clave a tu correo: " + correo + "."
                            });
                        }
                        else
                        {
                            return serializer.Serialize(new
                            {
                                succes = false,
                                pais = codigoPais,
                                estado = "0"
                            });
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "RecuperarClave - RecuperarClaveCS");

                return serializer.Serialize(new
                {
                    succes = false,
                    estado = "0"
                });
            }
        }

    }
}