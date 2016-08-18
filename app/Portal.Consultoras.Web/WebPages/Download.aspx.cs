using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class Download : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = Request.QueryString["file"];
            string fileName = GetFileNameFromUrl(url);
            
            Stream stream = null;            
            int bytesToRead = 10000; //This controls how many bytes to read at a time and send to the client
            byte[] buffer = new Byte[bytesToRead]; // Buffer to read bytes in chunk size specified above
            
            try
            {
                //Create a WebRequest to get the file
                HttpWebRequest fileReq = (HttpWebRequest)HttpWebRequest.Create(url);
                //Create a response for this request
                HttpWebResponse fileResp = (HttpWebResponse)fileReq.GetResponse();

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



            finally
            {
                if (stream != null)
                {
                    //Close the input stream
                    stream.Close();
                }
            }


            //try
            //{
            //    string requestFile = Request.QueryString["file"];

            //    if (string.IsNullOrEmpty(requestFile))
            //    {
            //        throw new FileNotFoundException("File to download cannot be null or empty");
            //    }

            //    var uri = new Uri(requestFile);
            //    string filename = Path.GetFullPath(uri.LocalPath);
            //    var fileInfo = new FileInfo(filename);

            //    if (!fileInfo.Exists)
            //    {
            //        throw new FileNotFoundException("File to download was not found", filename);
            //    }

            //    // get content type based on file extension. Example:
            //    // http://stackoverflow.com/a/691599
            //    Response.ContentType = GetContentType(fileInfo.Extension);

            //    Response.AddHeader("Content-Disposition",
            //                       "attachment; filename=\"" + fileInfo.Name + "\"");
            //    Response.WriteFile(fileInfo.FullName);
            //    Response.End();
            //}
            //catch (ThreadAbortException)
            //{
            //    // ignore exception
            //}
            //catch (FileNotFoundException ex)
            //{
            //    Response.StatusCode = (int)System.Net.HttpStatusCode.NotFound;
            //    Response.StatusDescription = ex.Message;
            //}
            //catch (Exception ex)
            //{
            //    Response.StatusCode = (int)System.Net.HttpStatusCode.InternalServerError;
            //    Response.StatusDescription =
            //    string.Format("Error downloading file: {0}", ex.Message);
            //}
        }

        private string GetFileNameFromUrl(string url)
        {            
            string fileWithoutExt = Path.GetFileNameWithoutExtension(url);
            string extension = Path.GetExtension(url);

            int indexUrlParam = extension.IndexOf("?");
            if (indexUrlParam != -1) extension = extension.Substring(0, indexUrlParam);

            return fileWithoutExt + extension;
        }
    }
}