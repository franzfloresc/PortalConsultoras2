﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Portal.Consultoras.Web.WebPages
{
    public partial class DownloadPDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string file = Request.QueryString["file"];

            //try
            //{
            //    var bytes = File.ReadAllBytes(Server.MapPath(file));
            //    Response.Buffer = true;
            //    Response.ContentType = "Application/pdf";
            //    Response.Clear();
            //    Response.AddHeader("Content-Disposition", "attachment;filename=" + DevolverNombre(file));
            //    Response.TransmitFile(Server.MapPath(file));
            //    Response.Charset = "UTF-8";
            //    Response.ContentEncoding = Encoding.UTF8;
            //    Response.BinaryWrite(bytes);
            //    Response.Flush();
            //    Response.Close();
            //}
            //catch (WebException ex)
            //{

            //}
            //catch (Exception ex)
            //{

            //}

            string url = Server.MapPath("~" + Request.QueryString["file"]);

            string fileName = System.IO.Path.GetFileName(url);
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
            catch (Exception)
            {
                
                
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