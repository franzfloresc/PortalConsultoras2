using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Portal.Consultoras.Common.Cryptography
{
    public static class DesAlgorithm
    {
        /// <summary>
        /// Encrypt
        /// </summary>
        /// <param name="rawString"></param>
        /// <param name="keyString"></param>
        /// <returns></returns>
        public static string Encrypt(string rawString, string keyString)
        {
            var bytes = Encoding.UTF8.GetBytes(keyString);

            using (var cryptoProvider = new DESCryptoServiceProvider { Mode = CipherMode.ECB })
            {
                var memoryStream = new MemoryStream();
                var cryptoStream = new CryptoStream(memoryStream,
                                    cryptoProvider.CreateEncryptor(bytes, bytes),
                                    CryptoStreamMode.Write);

                using (cryptoStream)
                {
                    using (var writer = new StreamWriter(cryptoStream))
                    {
                        writer.Write(rawString);
                        writer.Flush();
                        cryptoStream.FlushFinalBlock();
                        writer.Flush();
                        return Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length);
                    }
                }
            }
        }

        /// <summary>
        /// Decrypt
        /// </summary>
        /// <param name="encString"></param>
        /// <param name="keyString"></param>
        /// <returns></returns>
        public static string Decrypt(string encString, string keyString)
        {
            var bytes = Encoding.UTF8.GetBytes(keyString);

            using (var cryptoProvider = new DESCryptoServiceProvider { Mode = CipherMode.ECB })
            {
                var memoryStream = new MemoryStream(Convert.FromBase64String(encString));
                var cryptoStream = new CryptoStream(memoryStream,
                                        cryptoProvider.CreateDecryptor(bytes, bytes),
                                        CryptoStreamMode.Read);
                using (var reader = new StreamReader(cryptoStream))
                {
                    return reader.ReadToEnd();
                }
            }
        }
    }
}
