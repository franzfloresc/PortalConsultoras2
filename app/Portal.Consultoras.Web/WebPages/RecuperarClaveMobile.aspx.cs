using EasyCallback;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class RecuperarClaveMobile : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(RecuperarClaveCSMobile);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DropDowListPaisesMobile();
            }
        }

        //Inicio Mobile

        private void DropDowListPaisesMobile()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList();
                lst.Insert(0, new BEPais { PaisID = 0, NombreCorto = "-- Seleccione --" });
            }

            ddlPaisMobile.DataSource = lst;
            ddlPaisMobile.DataTextField = "NombreCorto";
            ddlPaisMobile.DataValueField = "PaisID";
            ddlPaisMobile.DataBind();
        }

        private string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                if (encryptor != null)
                {
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(),
                            CryptoStreamMode.Write))
                        {
                            cs.Write(clearBytes, 0, clearBytes.Length);
                            cs.Close();
                        }

                        clearText = Convert.ToBase64String(ms.ToArray());
                    }
                }
            }
            return clearText;
        }

        public string RecuperarClaveCSMobile(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    string correo = datos["Correo"].ToString();
                    string codigoPais = Convert.ToString(datos["IdPais"]);

                    var lst = sv.SelectByEmail(correo, Convert.ToInt32(codigoPais)).ToList();
                    
                    if (codigoPais.Trim() == "4")
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

                        correo = lst[0].Descripcion; // contiene el correo del destinatario
                        if (correo.Trim() == "")
                        {
                            return serializer.Serialize(new
                            {
                                succes = false,
                                pais = codigoPais,
                                mensaje = "No tienes un correo registrado para poder restablecer tu clave.<br />Por favor comunícate con el Servicio de Atención al Cliente 0-8000-9-37452"
                            });
                        }
                    }

                    if (lst[0].Cantidad == 0)
                        return serializer.Serialize(new
                        {
                            succes = false,
                            estado = "2",
                            pais = codigoPais,
                            numero = lst[0].Descripcion
                        });

                    Session["email"] = correo;

                    string urlportal = ConfigurationManager.AppSettings["URLSite"];

                    DateTime diasolicitud = DateTime.Now.AddHours(DateTime.Now.Hour + 24);

                    string paisid = HttpUtility.UrlEncode(Encrypt(codigoPais.Trim())) ?? "";
                    string email = HttpUtility.UrlEncode(Encrypt(correo.Trim())) ?? "";
                    string paisiso = HttpUtility.UrlEncode(Encrypt(lst[0].CodigoISO.Trim())) ?? "";
                    string codigousuario = HttpUtility.UrlEncode(Encrypt(lst[0].CodigoUsuario.Trim())) ?? "";
                    string fechasolicitud = HttpUtility.UrlEncode(Encrypt(Convert.ToString(diasolicitud).Trim())) ?? "";

                    var uri = new Uri(urlportal + "/WebPages/RestablecerContrasena.aspx?xyzab=param1&abxyz=param2&yzabx=param3&bxyza=param4&zabxy=param5");
                    var qs = HttpUtility.ParseQueryString(uri.Query);
                    qs.Set("xyzab", paisid);
                    qs.Set("abxyz", email);
                    qs.Set("yzabx", paisiso);
                    qs.Set("bxyza", codigousuario);
                    qs.Set("zabxy", fechasolicitud);

                    var uriBuilder = new UriBuilder(uri);
                    uriBuilder.Query = qs.ToString();
                    var newUri = uriBuilder.Uri;

                    HttpCookie cokie = new HttpCookie("datosenviado");
                    cokie["email"] = correo;
                    cokie["paisiso"] = lst[0].CodigoISO;
                    cokie.Expires = DateTime.Now.AddDays(1);
                    Response.Cookies.Add(cokie);

                    #region Mensaje

                    var mensaje = "<body style='background:#fff; text-align: center;'>";


                    mensaje += "<style>";

                    mensaje += "@media screen and (max-width:980px) { .container { width:98%; } section { width:98%; } }";
                    mensaje += "@media screen and (max-width:700px) { section { float:none; width:96%; font-size:1.2em; }}";
                    mensaje += "@media screen and (max-width:480px) { section { font-size:1.5em; width:94%; border: 0px; } }";
                    mensaje += "</style>";

                    mensaje += "<div class='container' style='width:600px; margin:0px auto; font-size:1em; text-align:justify;'>";
                    mensaje += "<div class='logo_modal'>";
                    mensaje += "<a href='#' id='logo'>";
                    mensaje += "<img src='https://s3.amazonaws.com/somosbelcorp/2016/Mobile/Logo.gif?versionId=PIwlmhsR2yIAoWH2vFY26ElGITYTQpsJ' />";
                    mensaje += "</a>";
                    mensaje += "</div>";

                    mensaje += "<section style='padding: 10px; background:#fff; -moz-border-radius:5px;-webkit-border-radius:5px;-o-border-radius:5px;border-radius:5px; float: left; width: 100%;'>";

                    mensaje += "<p style='color:#415261; font-size:17px;'>";
                    mensaje += "Ingresa a este link para poder restablecer tu contrase&ntilde;a:";
                    mensaje += "</p>";

                    mensaje += "<div>";
                    mensaje += "<a href='" + newUri + "' type='href' name='idrecuperacontrasena' class='botonenviar' style='width: 278px; height: 35px; left: 21px; top: 275px; border-radius:30px; padding-top: 10px; background: #722789; border: 1px solid #722789; color: #fff; line-height: 2; vertical-align: middle; font-size:13px; font-weight:bold; margin-bottom: 6px; display: block; text-decoration:none; text-align:center;' target='_blank' data-email='" + Session["email"] + "' />RESTABLECER CONTRASE&Ntilde;A</a>";

                    mensaje += "</div>";

                    mensaje += "<p style='color:#415261; font-size:17px; margin-right: 24%;'>";
                    mensaje += "Aviso: Tienes 24 horas para elegir tu contrase&ntilde;a. Despu&eacute;s tendr&aacute;s que solicitar una nueva.";
                    mensaje += "</p>";

                    mensaje += "</section>";

                    mensaje += "</div>";

                    mensaje += "</body>";


                    #endregion

                    Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + lst[0].CodigoISO + ") Cambio de contraseña de Somosbelcorp", mensaje, true, "Somos Belcorp");

                    return serializer.Serialize(new
                    {
                        succes = true,
                        pais = codigoPais,
                        url = urlportal + "/WebPages/CorreoEnviado.aspx",
                        mensaje = "Te hemos enviado una nueva clave a tu correo: " + correo + "."

                    });
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "RecuperarClaveMobile - RecuperarClaveCSMobile");

                return serializer.Serialize(new
                {
                    succes = false,
                    estado = "0"
                });
            }
        }

        //Fín Mobile
    }
}