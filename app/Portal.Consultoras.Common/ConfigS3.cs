using Amazon.S3.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class ConfigS3
    {
        public static string MY_AWS_ACCESS_KEY_ID = System.Configuration.ConfigurationManager.AppSettings["MY_AWS_ACCESS_KEY_ID"];
        public static string MY_AWS_SECRET_KEY = System.Configuration.ConfigurationManager.AppSettings["MY_AWS_SECRET_KEY"];
        public static string BUCKET_NAME = System.Configuration.ConfigurationManager.AppSettings["BUCKET_NAME"];
        public static string ROOT_DIRECTORY = System.Configuration.ConfigurationManager.AppSettings["ROOT_DIRECTORY"];
        //MEJORA S3
        public static string URL_S3 = System.Configuration.ConfigurationManager.AppSettings["URL_S3"];

        public static string GetUrlFileS3(string carpetaPais, string fileName, string carpetaAnterior)
        {
            if (fileName.Trim() == "") return fileName;

                var url = ConfigS3.URL_S3 + "/" + ConfigS3.BUCKET_NAME + "/" + ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName;
                return url;
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
                var deleteRequest = new DeleteObjectRequest();
                deleteRequest.BucketName = ConfigS3.BUCKET_NAME;
                deleteRequest.Key = ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName;

                client.DeleteObject(deleteRequest);
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
                if (fileName != "")
                {
                    if (System.IO.File.Exists(path))
                    {
                        var inputStream = new FileStream(path, FileMode.Open);
                        using (var client = Amazon.AWSClientFactory.CreateAmazonS3Client(ConfigS3.MY_AWS_ACCESS_KEY_ID, ConfigS3.MY_AWS_SECRET_KEY, Amazon.RegionEndpoint.USEast1))
                        {
                        var request = new PutObjectRequest();
                        request.BucketName = ConfigS3.BUCKET_NAME;
                        request.Key = ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName;
                        request.InputStream = inputStream;
                            if (archivoPublico) request.CannedACL = Amazon.S3.S3CannedACL.PublicRead;
                        client.PutObject(request);
                        }
                        if(EliminarArchivo) System.IO.File.Delete(path);
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

                if (fileName.Trim() == "")
                    return fileName;

                var client = Amazon.AWSClientFactory.CreateAmazonS3Client(
                    ConfigS3.MY_AWS_ACCESS_KEY_ID,
                    ConfigS3.MY_AWS_SECRET_KEY,
                    Amazon.RegionEndpoint.USEast1);

                var s3FileInfo = new Amazon.S3.IO.S3FileInfo(client,
                    ConfigS3.BUCKET_NAME,
                    ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName);

                var url = "";

                if (s3FileInfo.Exists)
                {
                    var expiryUrlRequest = new GetPreSignedUrlRequest();
                    expiryUrlRequest.BucketName = ConfigS3.BUCKET_NAME;
                    expiryUrlRequest.Key = ConfigS3.ROOT_DIRECTORY + "/" + ((carpetaPais != "") ? carpetaPais + "/" : "") + fileName;
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
    }
}
