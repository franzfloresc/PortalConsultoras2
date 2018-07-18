using Amazon.S3.Model;
using System;
using System.IO;
using System.Configuration;

namespace Portal.Consultoras.Common
{
    public class ConfigS3
    {
        private static readonly string MY_AWS_ACCESS_KEY_ID = System.Configuration.ConfigurationManager.AppSettings["MY_AWS_ACCESS_KEY_ID"];
        private static readonly string MY_AWS_SECRET_KEY = System.Configuration.ConfigurationManager.AppSettings["MY_AWS_SECRET_KEY"];
        private static readonly string BUCKET_NAME = System.Configuration.ConfigurationManager.AppSettings["BUCKET_NAME"];
        private static readonly string BUCKET_NAME_QAS = System.Configuration.ConfigurationManager.AppSettings["BUCKET_NAME_QAS"];
        private static readonly string ROOT_DIRECTORY = System.Configuration.ConfigurationManager.AppSettings["ROOT_DIRECTORY"];
        private static readonly string URL_S3 = System.Configuration.ConfigurationManager.AppSettings["URL_S3"];
        private static readonly string rutaRevistaDigital = System.Configuration.ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.CarpetaRevistaDigital] ?? string.Empty;

        public static string GetUrlFileS3(string carpetaPais, string fileName, string carpetaAnterior = "")
        {
            fileName = (fileName ?? "").Trim();
            if (fileName == "")
                return fileName;

            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;

            var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return URL_S3 + "/" + BUCKET_NAME + "/" + root + carpeta + fileName;
        }

        //public static string GetUrlS3(string carpetaPais)
        //{
        //    var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
        //    var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

        //    return URL_S3 + "/" + BUCKET_NAME + "/" + root + carpeta;
        //}

        //public static string GetUrlFileRDS3(string carpetaPais, string fileName)
        //{
        //    fileName = fileName ?? "";
        //    if (fileName.StartsWith(URL_S3))
        //        return fileName;

        //    if (fileName.StartsWith("http:/"))
        //        return fileName;

        //    if (fileName.StartsWith("https:/"))
        //        return fileName;

        //    var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
        //    var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

        //    return URL_S3 + "/" + BUCKET_NAME + "/" + root + "/" + rutaRevistaDigital + "/" + carpeta + fileName;
        //}

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
                var deleteRequest = new DeleteObjectRequest
                {
                    BucketName = BUCKET_NAME,
                    Key = root + carpeta + fileName
                };
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

        public static bool SetFileS3(string path, string carpetaPais, string fileName, bool actualizar = false)
        {
            return SetFileS3(path, carpetaPais, fileName, true, true, false, actualizar);
        }
        public static bool SetFileS3(string path, string carpetaPais, string fileName, bool archivoPublico, bool EliminarArchivo, bool throwException, bool actualizar = false)
        {
            try
            {
                var root = string.IsNullOrEmpty(ROOT_DIRECTORY) ? "" : ROOT_DIRECTORY + "/";
                var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

                if (fileName == "")
                    return true;

                if (File.Exists(path) || actualizar)
                {
                    var inputStream = new FileStream(path, FileMode.Open);

                    var request = new PutObjectRequest
                    {
                        BucketName = BUCKET_NAME,
                        Key = root + carpeta + fileName,
                        InputStream = inputStream
                    };

                    if (archivoPublico)
                        request.CannedACL = Amazon.S3.S3CannedACL.PublicRead;

                    using (var client = Amazon.AWSClientFactory.CreateAmazonS3Client(ConfigS3.MY_AWS_ACCESS_KEY_ID, ConfigS3.MY_AWS_SECRET_KEY, Amazon.RegionEndpoint.USEast1))
                    {
                        client.PutObject(request);
                    }

                    if (EliminarArchivo)
                        File.Delete(path);
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
                    var expiryUrlRequest = new GetPreSignedUrlRequest
                {
                    BucketName = BUCKET_NAME,
                    Key = root + carpeta + fileName,
                    Expires = DateTime.Now.AddDays(1)
                };

                    url = client.GetPreSignedURL(expiryUrlRequest);
                }
                else
                {
                    if (carpetaAnterior != string.Empty) url = carpetaAnterior + "/" + fileName;
                    else url = fileName;
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
    }
}
