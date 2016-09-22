﻿using EasyCallback;
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
                string paisid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["xyzab"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["xyzab"]).Trim()) : "";

                string correo = Decrypt(HttpUtility.UrlDecode(Request.QueryString["abxyz"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["abxyz"]).Trim()) : "";

                string paisiso = Decrypt(HttpUtility.UrlDecode(Request.QueryString["yzabx"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["yzabx"]).Trim()) : "";

                string codigousuario = Decrypt(HttpUtility.UrlDecode(Request.QueryString["bxyza"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["bxyza"]).Trim()) : "";

                string fechasolicitud = Decrypt(HttpUtility.UrlDecode(Request.QueryString["zabxy"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["zabxy"]).Trim()) : "";

                string nombre = Decrypt(HttpUtility.UrlDecode(Request.QueryString["xbaby"])) != null ? Decrypt(HttpUtility.UrlDecode(Request.QueryString["xbaby"]).Trim()) : "";

                DateTime fechaactual = DateTime.Now;

                if (!(Convert.ToDateTime(fechasolicitud) >= fechaactual))
                {
                    string titulo = "Sesión Expirada";
                    string mensaje = "Se ha expirado el tiempo del cambio de contraseña.<br>Vuelva a solicitarla";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AbrirAlertaPopup", "$(function() { AbrirAlertaPopup('" + titulo + "', '" + mensaje + "'); });", true);

                    Response.AddHeader("REFRESH", "3;URL='" + urlportal + "'");
                }
                else
                {
                    lblNombre.Text = nombre;
                    txtpaisid.Text = paisid;
                    txtcorreo.Text = correo;
                    txtpaisiso.Text = paisiso;
                    txtcodigousuario.Text = codigousuario;
                    txtcontrasenaanterior.Text = fechasolicitud;
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

                string urlportal = ConfigurationManager.AppSettings["URLSite"];

                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    string nuevacontrasena = datos["newPassword"].ToString();

                    //bool result = sv.ChangePasswordUser(idpais, "SISTEMA", paisiso + codigousuario, nuevacontrasena, correo, EAplicacionOrigen.RecuperarClave);
                    bool result = true;

                    if (result)
                    {
                        linkregresarasomosbelcorp.NavigateUrl = urlportal;
                        return serializer.Serialize(new
                        {
                            succes = true
                        });
                    }
                    else
                    {
                        return serializer.Serialize(new
                        {
                            succes = false
                        });
                    }
                }
            }
            catch (Exception ex)
            {
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
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
    }
}