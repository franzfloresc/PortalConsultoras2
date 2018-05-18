using Amazon.S3.Model;
using System;
using System.IO;

namespace Portal.Consultoras.Common
{
    public class ConfigS3
    {
        private static readonly string MY_AWS_ACCESS_KEY_ID = System.Configuration.ConfigurationManager.AppSettings["MY_AWS_ACCESS_KEY_ID"] ?? string.Empty;
        private static readonly string MY_AWS_SECRET_KEY = System.Configuration.ConfigurationManager.AppSettings["MY_AWS_SECRET_KEY"] ?? string.Empty;
        private static readonly string BUCKET_NAME = System.Configuration.ConfigurationManager.AppSettings["BUCKET_NAME"] ?? string.Empty;
        private static readonly string BUCKET_NAME_QAS = System.Configuration.ConfigurationManager.AppSettings["BUCKET_NAME_QAS"] ?? string.Empty;
        private static readonly string ROOT_DIRECTORY = System.Configuration.ConfigurationManager.AppSettings["ROOT_DIRECTORY"] ?? string.Empty;
        private static readonly string URL_S3 = System.Configuration.ConfigurationManager.AppSettings["URL_S3"] ?? string.Empty;
        private static readonly string rutaRevistaDigital = System.Configuration.ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.CarpetaRevistaDigital] ?? string.Empty;

        public static string GetUrlFileS3Base(string carpetaPais)
        {
            return URL_S3 + "/" + BUCKET_NAME + "/" + ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "");
        }

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

            carpetaPais = carpetaPais ?? "";
            return URL_S3 + "/" + BUCKET_NAME + "/" + ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName;
        }

        public static string GetUrlS3(string carpetaPais)
        {
            return URL_S3 + "/" + BUCKET_NAME + "/" + ROOT_DIRECTORY + "/" + (carpetaPais != "" ? carpetaPais + "/" : "");
        }

        public static string GetUrlFileRDS3(string carpetaPais, string fileName)
        {
            fileName = fileName ?? "";
            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;

            return URL_S3 + "/" + BUCKET_NAME + "/" + ROOT_DIRECTORY + "/" + rutaRevistaDigital + "/" + (carpetaPais != "" ? carpetaPais + "/" : "") + fileName;
        }

        public static void DeleteFileS3(string carpetaPais, string fileName)
        {
            var client = Amazon.AWSClientFactory.CreateAmazonS3Client(
                ConfigS3.MY_AWS_ACCESS_KEY_ID,
                ConfigS3.MY_AWS_SECRET_KEY,
                Amazon.RegionEndpoint.USEast1);

            var s3FileInfo = new Amazon.S3.IO.S3FileInfo(client,
                ConfigS3.BUCKET_NAME,
                ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName);

            if (s3FileInfo.Exists)
            {
                var deleteRequest = new DeleteObjectRequest
                {
                    BucketName = ConfigS3.BUCKET_NAME,
                    Key = ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName
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
                if (fileName == "")
                    return true;

                if (File.Exists(path) || actualizar)
                {
                    var inputStream = new FileStream(path, FileMode.Open);

                    var request = new PutObjectRequest
                    {
                        BucketName = ConfigS3.BUCKET_NAME,
                        Key = ConfigS3.ROOT_DIRECTORY + "/" +
                              ((carpetaPais != "") ? carpetaPais + "/" : "") +
                              fileName,
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
            if (fileName.Trim() == "") return fileName;

            var client = Amazon.AWSClientFactory.CreateAmazonS3Client(
                ConfigS3.MY_AWS_ACCESS_KEY_ID,
                ConfigS3.MY_AWS_SECRET_KEY,
                Amazon.RegionEndpoint.USEast1);

            var s3FileInfo = new Amazon.S3.IO.S3FileInfo(client,
                ConfigS3.BUCKET_NAME,
                ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName);

            string url;

            if (s3FileInfo.Exists)
            {
                var expiryUrlRequest = new GetPreSignedUrlRequest
                {
                    BucketName = ConfigS3.BUCKET_NAME,
                    Key = ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName,
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