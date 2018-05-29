using EasyCallback;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class RestablecerContrasena : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(ModificaClaveCS);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string urlportal = ConfigurationManager.AppSettings["URLSite"];

            if (!Page.IsPostBack)
            {
                var esEsika = false;
                var paisid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["xyzab"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["xyzab"]).Trim()) : "";
                var correo = Decrypt(HttpUtility.UrlDecode(Request.QueryString["abxyz"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["abxyz"]).Trim()) : "";
                var paisiso = Decrypt(HttpUtility.UrlDecode(Request.QueryString["yzabx"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["yzabx"]).Trim()) : "";
                var codigousuario = Decrypt(HttpUtility.UrlDecode(Request.QueryString["bxyza"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["bxyza"]).Trim()) : "";
                var fechasolicitud = Decrypt(HttpUtility.UrlDecode(Request.QueryString["zabxy"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["zabxy"]).Trim()) : "";
                var nombre = Decrypt(HttpUtility.UrlDecode(Request.QueryString["xbaby"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["xbaby"]).Trim()) : "";
                var guiid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["wxabc"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["wxabc"]).Trim()) : "";

                DateTime fechaactual = DateTime.Now;

                if (paisid == "2" || paisid == "3" || paisid == "4" || paisid == "6" || paisid == "7" || paisid == "8" || paisid == "11" || paisid == "13" || paisid == "14")
                    esEsika = true;

                TimeSpan tspan;
                tspan = fechaactual.Subtract(Convert.ToDateTime(fechasolicitud));

                if (tspan.Minutes >= 5)
                {
                    divCambiarClave.Visible = false;
                    Response.Redirect(urlportal);
                }
                else
                {
                    divCambiarClave.Visible = true;
                    lblNombre.Text = nombre;
                    txtpaisid.Text = paisid;
                    txtcorreo.Text = correo;
                    txtpaisiso.Text = paisiso;
                    txtcodigousuario.Text = codigousuario;
                    txtcontrasenaanterior.Text = fechasolicitud;
                    txtmarca.Text = esEsika ? "esika" : "lbel";
                }
            }
        }

        public string ModificaClaveCS(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            try
            {
                int idpais = Convert.ToInt32(txtpaisid.Text);
                string paisiso = txtpaisiso.Text;
                string codigousuario = txtcodigousuario.Text;
                string correo = txtcorreo.Text;

                Session["email"] = correo;

                string urlportal = ConfigurationManager.AppSettings["UrlSiteSE"];

                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                string nuevacontrasena = datos["newPassword"].ToString();

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    bool result = sv.CambiarClaveUsuario(idpais, paisiso, codigousuario, nuevacontrasena, correo, "SISTEMA", EAplicacionOrigen.RecuperarClave);

                    if (result)
                    {
                        return serializer.Serialize(new
                        {
                            success = true,
                            url = urlportal
                        });
                    }

                    return serializer.Serialize(new
                    {
                        success = false,
                        urlportal = urlportal
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "RestablecerContrasena - ModificarClaveCS");

                return serializer.Serialize(new
                {
                    succes = false,
                    estado = "0"
                });
            }
        }

        private string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                if (encryptor != null)
                {
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(),
                            CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }

                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
            }
            return cipherText;
        }
    }
}