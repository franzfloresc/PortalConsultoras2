using Amazon.S3.Model;
using System;
using System.IO;
using System.Configuration;

namespace Portal.Consultoras.Common
{
    public class ConfigS3
    {
        public static string MY_AWS_ACCESS_KEY_ID = ConfigurationManager.AppSettings["MY_AWS_ACCESS_KEY_ID"];
        public static string MY_AWS_SECRET_KEY = ConfigurationManager.AppSettings["MY_AWS_SECRET_KEY"];
        public static string BUCKET_NAME = ConfigurationManager.AppSettings["BUCKET_NAME"];
        public static string BUCKET_NAME_QAS = ConfigurationManager.AppSettings["BUCKET_NAME_QAS"];
        public static string ROOT_DIRECTORY = ConfigurationManager.AppSettings["ROOT_DIRECTORY"];
        //MEJORA S3
        public static string URL_S3 = ConfigurationManager.AppSettings["URL_S3"];

        public static string RutaCdn = ConfigurationManager.AppSettings["RutaCDN"];

        public static string GetUrlFileS3(string carpetaPais, string fileName, string carpetaAnterior = "")
        {
            fileName = fileName ?? "";
            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;
            
            if (fileName.Trim() == "") return fileName;

            var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return URL_S3 + "/" + BUCKET_NAME + "/" + root + carpeta + fileName;
        }

        public static string GetUrlS3(string carpetaPais)
        {
            var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return URL_S3 + "/" + BUCKET_NAME + "/" + root + carpeta;
        }

        public static void DeleteFileS3(string carpetaPais, string fileName)
        {
            var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            var client = Amazon.AWSClientFactory.CreateAmazonS3Client(
                MY_AWS_ACCESS_KEY_ID,
                MY_AWS_SECRET_KEY,
                Amazon.RegionEndpoint.USEast1);

            var s3FileInfo = new Amazon.S3.IO.S3FileInfo(client,
                BUCKET_NAME,
                root + carpeta + fileName);

            if (s3FileInfo.Exists)
            {
                var deleteRequest = new DeleteObjectRequest();
                deleteRequest.BucketName = BUCKET_NAME;
                deleteRequest.Key = root + carpeta + fileName;
                // Fix Error: cliente no cuenta con permiso para eliminar archivos. 
                try
                {
                    client.DeleteObject(deleteRequest);
                }
                catch (Exception e)
                {
                    LogManager.SaveLog(e, "", "");
                }

            }

            client.Dispose();
        }

        public static bool SetFileS3(string path, string carpetaPais, string fileName)
        {
            return SetFileS3(path, carpetaPais, fileName, true, true, false);
        }
        public static bool SetFileS3(string path, string carpetaPais, string fileName, bool archivoPublico, bool EliminarArchivo, bool throwException)
        {
            try
            {
                var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
                var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

                if (fileName != "")
                {
                    if (File.Exists(path))
                    {
                        var inputStream = new FileStream(path, FileMode.Open);
                        using (var client = Amazon.AWSClientFactory.CreateAmazonS3Client(MY_AWS_ACCESS_KEY_ID, MY_AWS_SECRET_KEY, Amazon.RegionEndpoint.USEast1))
                        {
                            var request = new PutObjectRequest();
                            request.BucketName = BUCKET_NAME;
                            request.Key = root + carpeta + fileName;
                            request.InputStream = inputStream;
                            if (archivoPublico) request.CannedACL = Amazon.S3.S3CannedACL.PublicRead;
                            client.PutObject(request);
                        }
                        if (EliminarArchivo) File.Delete(path);
                    }
                }
                return true;
            }
            catch
            {
                if (throwException) throw;
                return false;
            }
        }

        public static string GetUrlFileS3WithAuthentication(string carpetaPais, string fileName, string carpetaAnterior)
        {
            try
            {
                var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
                var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

                if (fileName.Trim() == "")
                    return fileName;

                var client = Amazon.AWSClientFactory.CreateAmazonS3Client(
                    MY_AWS_ACCESS_KEY_ID,
                    MY_AWS_SECRET_KEY,
                    Amazon.RegionEndpoint.USEast1);

                var s3FileInfo = new Amazon.S3.IO.S3FileInfo(client,
                    BUCKET_NAME,
                    root + carpeta + fileName);

                var url = "";

                if (s3FileInfo.Exists)
                {
                    var expiryUrlRequest = new GetPreSignedUrlRequest();
                    expiryUrlRequest.BucketName = BUCKET_NAME;
                    expiryUrlRequest.Key = root + carpeta + fileName;
                    expiryUrlRequest.Expires = DateTime.Now.AddDays(1);

                    url = client.GetPreSignedURL(expiryUrlRequest);
                }
                else
                {
                    if (carpetaAnterior != string.Empty)
                    {
                        url = carpetaAnterior + "/" + fileName;
                    }
                    else
                    {
                        url = fileName;
                    }
                }

                client.Dispose();

                return url;
            }
            catch (Exception) { throw; }
        }

        public static string GetUrlFileS3WithAuthentication(string keyRuta)
        {
            try
            {
                if (keyRuta.Trim() == "")
                    return keyRuta;

                var client = Amazon.AWSClientFactory.CreateAmazonS3Client(
                    MY_AWS_ACCESS_KEY_ID,
                    MY_AWS_SECRET_KEY,
                    Amazon.RegionEndpoint.USEast1);

                var s3FileInfo = new Amazon.S3.IO.S3FileInfo(client, BUCKET_NAME_QAS, keyRuta);

                string url = string.Empty;

                if (s3FileInfo.Exists)
                {
                    var expiryUrlRequest = new GetPreSignedUrlRequest
                    {
                        BucketName = BUCKET_NAME_QAS,
                        Key = keyRuta,
                        Expires = DateTime.Now.AddDays(1)
                    };

                    url = client.GetPreSignedURL(expiryUrlRequest);
                }

                client.Dispose();

                return url;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string GetUrlFileCdn(string carpetaPais, string fileName)
        {
            fileName = fileName ?? "";
            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;
            
            if (fileName.Trim() == "") return fileName;
            
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return RutaCdn + "/" + carpeta + fileName;
        }
    }
}
