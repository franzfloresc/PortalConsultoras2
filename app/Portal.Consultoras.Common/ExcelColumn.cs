using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class ExcelColumn
    {
        private static string[] alphabetArray = { string.Empty, "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
        public static IEnumerable<string> alphaList = alphabetArray.Cast<string>();

        public static string IntToAA(int value)
        {
            while (alphaList.Count() - 1 < value)
            {
                IncreaseList();
            }

            return alphaList.ElementAt(value);
        }

        private static void IncreaseList()
        {
            alphaList = alphabetArray.Take(1).Union(
                alphaList.SelectMany(currentLetter =>
                   alphabetArray.Skip(1).Select(innerLetter => currentLetter + innerLetter)
                )
            );
        }
    }
}