using System;
using System.Security.Cryptography;
using System.Text;

namespace Portal.Consultoras.Common.Cryptography
{
    /// <summary>
    /// HMAC-SHA1 Helper
    /// </summary>
    public static class HmacShaAlgorithm
    {
        public static string GetHash(string text, string key)
        {
            var myEncoder = new UTF8Encoding();
            byte[] keyBytes = myEncoder.GetBytes(key);
            byte[] textBytes = myEncoder.GetBytes(text);
            using (var hmac = new HMACSHA1(keyBytes))
            {
                byte[] hashCode = hmac.ComputeHash(textBytes);
                string hash = BitConverter.ToString(hashCode).Replace("-", "");

                return hash.ToLower();
            }
        }
    }
}