using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Portal.Consultoras.Common
{
    public static class NeoGridCipher
    {
        private static string NEOGRID_KEY = "SB2zJUVlmvGDErd0";
        private static string NEOGRID_PRODUCTION_SERVER = "https://e-prod.factura-core.com/facturaportal/public/portal/";

        /// <summary>
        /// Create the complete URL for NeoGrid production server.
        /// Timestamp generation is done automatically.
        /// </summary>
        /// <param name="customerCode">Customer identification number</param>
        public static string CreateProductionURL(string customerCode)
        {
            return NEOGRID_PRODUCTION_SERVER + Encrypt(NEOGRID_KEY, customerCode) + "/" + Encrypt(NEOGRID_KEY, CreateTimeStamp());
        }

        public static string Encrypt(string seed, string cleartext)
        {
            byte[] key = Encoding.Default.GetBytes(seed);
            byte[] bytes = Encoding.Default.GetBytes(cleartext);
            return ToHex(Encrypt(key, bytes));
        }

        private static string CreateTimeStamp()
        {
            var now = DateTime.Now;
            return now.ToString("yyyy-MM-ddTHH:mmzzz");
        }

        private static byte[] Encrypt(byte[] raw, byte[] clear)
        {
            var rijndael = Rijndael.Create();
            rijndael.Mode = CipherMode.ECB;

            var ms = new MemoryStream();
            var cryptoStream = new CryptoStream(ms, rijndael.CreateEncryptor(raw, new byte[16]), CryptoStreamMode.Write);
            cryptoStream.Write(clear, 0, clear.Length);
            cryptoStream.FlushFinalBlock();

            return ms.ToArray();
        }

        private static string ToHex(byte[] bytes)
        {
            var sb = new StringBuilder(bytes.Length * 2);
            foreach (byte b in bytes)
            {
                sb.AppendFormat("{0:X2}", b);
            }
            return sb.ToString();
        }
    }
}