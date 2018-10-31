using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class DownloadFTP : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string file = Request.QueryString["file"];

            MemoryStream outputStream = new MemoryStream();
            try
            {
                string uri = file;
                NetworkCredential nc = new NetworkCredential();
                nc.UserName = ConfigurationManager.AppSettings["FTP_RV_USER"];
                nc.Password = ConfigurationManager.AppSettings["FTP_RV_PASS"];
                FtpWebRequest request = (FtpWebRequest)FtpWebRequest.Create(new Uri(uri));
                request.Method = WebRequestMethods.Ftp.DownloadFile;
                request.UseBinary = true;
                request.Credentials = nc;
                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                Stream strm = response.GetResponseStream();

                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = strm.Read(buffer, 0, bufferSize);

                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = strm.Read(buffer, 0, bufferSize);
                }
                strm.Close();
                outputStream.Close();
                response.Close();

                byte[] data = outputStream.GetBuffer();

                Response.Buffer = true;
                Response.ContentType = "PDF";
                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment;filename=" + DevolverNombre(file));
                Response.Charset = "UTF-8";
                Response.ContentEncoding = Encoding.UTF8;
                Response.BinaryWrite(data);
                Response.Flush();
                Response.Close();
               
            }
            catch (WebException)
            {
                //
            }

        }

        public string DevolverNombre(string url)
        {
            string[] cadenas = url.Split('/');
            string nombre = string.Empty;
            
            if (cadenas.Length > 0)
            {
                nombre = cadenas[cadenas.Length - 2] + "_" + cadenas[cadenas.Length - 1];
            }

            return nombre;
        }
    }
}