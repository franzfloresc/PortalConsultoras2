using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Portal.Consultoras.Common
{
    public static class NeoGridCipher
    {
        private static String NEOGRID_KEY = "SB2zJUVlmvGDErd0";
        private static String NEOGRID_PRODUCTION_SERVER = "https://factura.neogrid.com/facturaportal/public/portal/";
        private static String NEOGRID_TEST_SERVER = "https://factura-teste.neogrid.com/facturaportal/public/portal/";

        /// <summary>
        /// Create the complete URL for NeoGrid production server.
        /// Timestamp generation is done automatically.
        /// </summary>
        /// <param name="customerCode">Customer identification number</param>
        public static String CreateProductionURL(String customerCode)
        {
            return NEOGRID_PRODUCTION_SERVER + Encrypt(NEOGRID_KEY, customerCode) + "/" + Encrypt(NEOGRID_KEY, CreateTimeStamp());
        }

        /// <summary>
        /// Create the complete URL for NeoGrid test server.
        /// Timestamp generation is done automatically.
        /// </summary>
        /// <param name="customerCode">Customer identification number</param>
        public static String CreateTestURL(String customerCode)
        {
            return NEOGRID_TEST_SERVER + Encrypt(NEOGRID_KEY, customerCode) + "/" + Encrypt(NEOGRID_KEY, CreateTimeStamp());
        }

        public static String Encrypt(String seed, String cleartext)
        {
            byte[] key = Encoding.Default.GetBytes(seed);
            byte[] bytes = Encoding.Default.GetBytes(cleartext);
            return ToHex(Encrypt(key, bytes));
        }

        public static String Decrypt(String seed, String encrypted)
        {
            byte[] enc = ToByte(encrypted);
            byte[] result = Decrypt(Encoding.Default.GetBytes(seed), enc);
            return Encoding.Default.GetString(result);
        }

        private static String CreateTimeStamp()
        {
            DateTime now = DateTime.Now;
            return now.ToString("yyyy-MM-ddTHH:mmzzz");
        }

        private static byte[] Encrypt(byte[] raw, byte[] clear)
        {
            Rijndael rijndael = Rijndael.Create();
            rijndael.Mode = CipherMode.ECB;

            MemoryStream ms = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(ms, rijndael.CreateEncryptor(raw, new byte[16]), CryptoStreamMode.Write);
            cryptoStream.Write(clear, 0, clear.Length);
            cryptoStream.FlushFinalBlock();

            return ms.ToArray();
        }

        private static byte[] Decrypt(byte[] raw, byte[] encrypted)
        {
            Rijndael rijndael = Rijndael.Create();
            rijndael.Mode = CipherMode.ECB;

            MemoryStream ms = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(ms, rijndael.CreateDecryptor(raw, new byte[16]), CryptoStreamMode.Write);
            cryptoStream.Write(encrypted, 0, encrypted.Length);
            cryptoStream.FlushFinalBlock();

            return ms.ToArray();
        }

        private static String ToHex(byte[] bytes)
        {
            StringBuilder sb = new StringBuilder(bytes.Length * 2);
            foreach (byte b in bytes)
            {
                sb.AppendFormat("{0:X2}", b);
            }
            return sb.ToString();
        }

        private static byte[] ToByte(String hexString)
        {
            int len = hexString.Length / 2;
            byte[] result = new byte[len];
            for (int i = 0; i < len; i++)
            {
                result[i] = Convert.ToByte(hexString.Substring(2 * i, 2), 16);
            }
            return result;
        }

    }
}