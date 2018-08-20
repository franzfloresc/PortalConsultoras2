using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Annotations
{
    public sealed class LuhnCardAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            var card = value as string;
            
            return card != null && CheckLuhn(card);
        }

        private static bool CheckLuhn(string data) {
            int sum = 0;
            int len = data.Length;
            for(int i = 0; i < len; i++) {
                int add = (data[i] - '0') * (2 - (i + len) % 2);
                add -= add > 9 ? 9 : 0;
                sum += add;
            }
            return sum % 10 == 0;
        }
    }
}