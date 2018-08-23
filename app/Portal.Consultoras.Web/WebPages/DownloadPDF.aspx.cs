using Portal.Consultoras.Common;
using System;
using System.IO;
using System.Net;
using System.Web;


namespace Portal.Consultoras.Web.WebPages
{
    public partial class DownloadPDF : BaseWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = Server.MapPath("~" + Request.QueryString["file"]);

            string fileName = System.IO.Path.GetFileName(url);
            string extensionName = Path.GetExtension(url);

            if (extensionName.ToLower() != "pdf")
            {
                Response.Redirect("/Login/SesionExpirada");
            }

            Stream stream = null;

            //This controls how many bytes to read at a time and send to the client
            int bytesToRead = 10000;

            // Buffer to read bytes in chunk size specified above
            byte[] buffer = new Byte[bytesToRead];
            try
            {
                
                // The number of bytes read
                FileWebRequest fileReq = (FileWebRequest)FileWebRequest.Create(url);
                FileWebResponse fileResp = (FileWebResponse)fileReq.GetResponse();

                if (fileReq.ContentLength > 0)
                    fileResp.ContentLength = fileReq.ContentLength;
                //Get the Stream returned from the response
                stream = fileResp.GetResponseStream();
                // prepare the response to the client. resp is the client Response
                var resp = HttpContext.Current.Response;

                //Indicate the type of data being sent
                resp.ContentType = "application/octet-stream";

                //Name the file 
                resp.AddHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                resp.AddHeader("Content-Length", fileResp.ContentLength.ToString());

                int length;
                do
                {
                    // Verify that the client is connected.
                    if (resp.IsClientConnected)
                    {
                        // Read data into the buffer.
                        length = stream.Read(buffer, 0, bytesToRead);

                        // and write it out to the response's output stream
                        resp.OutputStream.Write(buffer, 0, length);

                        // Flush the data
                        resp.Flush();

                        //Clear the buffer
                        buffer = new Byte[bytesToRead];
                    }
                    else
                    {
                        // cancel the download if client has disconnected
                        length = -1;
                    }
                } while (length > 0); //Repeat until no data is read
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "DownloadPDF - Page_Load");
            }
            finally
            {
                if (stream != null)
                {
                    //Close the input stream
                    stream.Close();
                }
            }
            
        }

        public string DevolverNombre(string url)
        {
            string[] cadenas = url.Split('/');
            string nombre = string.Empty;

            if (cadenas.Length > 0)
            {
                nombre = cadenas[cadenas.Length - 1] ;
            }

            return nombre;
        }
    }
}