using ICSharpCode.SharpZipLib.Zip;
using System;
using System.IO;
using System.Net;

namespace Portal.Consultoras.BizLogic
{
    public static class BLFileManager
    {
        public static void CompressFile(string fileName, string zipFileName, string inZipFileName)
        {
            const int bufferSize = 8192;

            using (ZipOutputStream zipOuput = new ZipOutputStream(File.Create(zipFileName)))
            {
                zipOuput.SetLevel(5);// Normal compression
                byte[] buffer = new byte[bufferSize];

                ZipEntry entry = new ZipEntry(inZipFileName) { DateTime = DateTime.Now };

                // Could also use the last write time or similar for the file.
                zipOuput.PutNextEntry(entry);

                using (FileStream fs = File.OpenRead(fileName))
                {
                    int sourceBytes;
                    do
                    {
                        sourceBytes = fs.Read(buffer, 0, buffer.Length);
                        zipOuput.Write(buffer, 0, sourceBytes);
                    } while (sourceBytes > 0);
                }
                zipOuput.Finish();
                zipOuput.Close();
            }
        }

        public static void FtpUploadFile(string ftpAddressFileName, string filePath, string username, string password)
        {
            //Create FTP request
            var request = (FtpWebRequest)FtpWebRequest.Create(ftpAddressFileName);

            request.Method = WebRequestMethods.Ftp.UploadFile;

            string[] split = username.Split('\\');
            string domain = null;
            if (split.Length == 2)
            {
                domain = split[0];
                username = split[1];
            }

            request.Credentials = domain == null
                ? new NetworkCredential(username, password)
                : new NetworkCredential(username, password, domain);

            request.UsePassive = true;
            request.UseBinary = true;
            request.KeepAlive = false;

            //Load the file
            FileStream stream = File.OpenRead(filePath);
            byte[] buffer = new byte[stream.Length];

            stream.Read(buffer, 0, buffer.Length);
            stream.Close();

            //Upload file
            Stream reqStream = request.GetRequestStream();
            reqStream.Write(buffer, 0, buffer.Length);
            reqStream.Close();
        }
    }
}