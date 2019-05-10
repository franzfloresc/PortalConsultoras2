using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Portal.Consultoras.Common.Cryptography
{
    public static class DesAlgorithm
    {
        public struct DesKeyPack
        {
            public byte[] Key, IV;

            public DesKeyPack(byte[] data)
            {
                Key = new byte[8];
                Buffer.BlockCopy(data, 0, Key, 0, 8);
                IV = new byte[8];
                Buffer.BlockCopy(data, 8, IV, 0, 8);
            }
        }

        private static DesKeyPack GenKeyPack(string keyString)
        {
            const string salt = "SALT";

            using (var md5 = new MD5CryptoServiceProvider())
            {
                byte[] data = md5.ComputeHash(Encoding.UTF8.GetBytes(keyString + salt));
                md5.Clear();
                var dkp = new DesKeyPack(data);

                return dkp;
            }
        }

        /// <summary>
        /// Encrypt
        /// </summary>
        /// <param name="rawString"></param>
        /// <param name="keyString"></param>
        /// <returns></returns>
        public static string Encrypt(string rawString, string keyString)
        {
            DesKeyPack dkp = GenKeyPack(keyString);
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            ICryptoTransform trans = des.CreateEncryptor(dkp.Key, dkp.IV);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, trans, CryptoStreamMode.Write);
            byte[] rawData = Encoding.UTF8.GetBytes(rawString);
            cs.Write(rawData, 0, rawData.Length);
            cs.Close();
            return Convert.ToBase64String(ms.ToArray());
        }

        /// <summary>
        /// Decrypt
        /// </summary>
        /// <param name="encString"></param>
        /// <param name="keyString"></param>
        /// <returns></returns>
        public static string Decrypt(string encString, string keyString)
        {
            var dkp = GenKeyPack(keyString);
            using (var des = new DESCryptoServiceProvider())
            {
                ICryptoTransform trans = des.CreateDecryptor(dkp.Key, dkp.IV);

                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, trans, CryptoStreamMode.Write))
                    {
                        byte[] rawData = Convert.FromBase64String(encString);
                        cs.Write(rawData, 0, rawData.Length);
                        cs.Close();
                    }
                    return Encoding.UTF8.GetString(ms.ToArray());
                } 
            }
        }
    }
}
