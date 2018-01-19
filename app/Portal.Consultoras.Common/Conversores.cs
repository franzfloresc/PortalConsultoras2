using System;

namespace Portal.Consultoras.Common
{
    public static class Conversores
    {
        public static string NumeroALetras(this decimal numberAsString)
        {
            var entero = Convert.ToInt64(Math.Truncate(numberAsString));
            var res = NumeroALetras(Convert.ToDouble(entero));
            return res;
        }

        private static string NumeroALetras(double value)
        {
            string num2Text;
            value = Math.Truncate(value);
            var ivalue = Convert.ToInt64(Math.Truncate(value));

            if (ivalue == 0) num2Text = "CERO";
            else if (ivalue == 1) num2Text = "UNO";
            else if (ivalue == 2) num2Text = "DOS";
            else if (ivalue == 3) num2Text = "TRES";
            else if (ivalue == 4) num2Text = "CUATRO";
            else if (ivalue == 5) num2Text = "CINCO";
            else if (ivalue == 6) num2Text = "SEIS";
            else if (ivalue == 7) num2Text = "SIETE";
            else if (ivalue == 8) num2Text = "OCHO";
            else if (ivalue == 9) num2Text = "NUEVE";
            else if (ivalue == 10) num2Text = "DIEZ";
            else if (ivalue == 11) num2Text = "ONCE";
            else if (ivalue == 12) num2Text = "DOCE";
            else if (ivalue == 13) num2Text = "TRECE";
            else if (ivalue == 14) num2Text = "CATORCE";
            else if (ivalue == 15) num2Text = "QUINCE";
            else if (value < 20) num2Text = "DIECI" + NumeroALetras(value - 10);
            else if (ivalue == 20) num2Text = "VEINTE";
            else if (value < 30) num2Text = "VEINTI" + NumeroALetras(value - 20);
            else if (ivalue == 30) num2Text = "TREINTA";
            else if (ivalue == 40) num2Text = "CUARENTA";
            else if (ivalue == 50) num2Text = "CINCUENTA";
            else if (ivalue == 60) num2Text = "SESENTA";
            else if (ivalue == 70) num2Text = "SETENTA";
            else if (ivalue == 80) num2Text = "OCHENTA";
            else if (ivalue == 90) num2Text = "NOVENTA";
            else if (value < 100) num2Text = NumeroALetras(Math.Truncate(value / 10) * 10) + " Y " + NumeroALetras(value % 10);
            else if (ivalue == 100) num2Text = "CIEN";
            else if (value < 200) num2Text = "CIENTO " + NumeroALetras(value - 100);
            else if ((ivalue == 200) || (ivalue == 300) || (ivalue == 400) || (ivalue == 600) || (ivalue == 800)) num2Text = NumeroALetras(Math.Truncate(value / 100)) + "CIENTOS";
            else if (ivalue == 500) num2Text = "QUINIENTOS";
            else if (ivalue == 700) num2Text = "SETECIENTOS";
            else if (ivalue == 900) num2Text = "NOVECIENTOS";
            else if (value < 1000) num2Text = NumeroALetras(Math.Truncate(value / 100) * 100) + " " + NumeroALetras(value % 100);
            else if (ivalue == 1000) num2Text = "MIL";
            else if (value < 2000) num2Text = "MIL " + NumeroALetras(value % 1000);
            else if (value < 1000000)
            {
                num2Text = NumeroALetras(Math.Truncate(value / 1000)) + " MIL";
                if ((value % 1000) > 0)
                {
                    num2Text = num2Text + " " + NumeroALetras(value % 1000);
                }
            }
            else if (ivalue == 1000000)
            {
                num2Text = "UN MILLON";
            }
            else if (value < 2000000)
            {
                num2Text = "UN MILLON " + NumeroALetras(value % 1000000);
            }
            else if (value < 1000000000000)
            {
                num2Text = NumeroALetras(Math.Truncate(value / 1000000)) + " MILLONES ";
                if ((value - Math.Truncate(value / 1000000) * 1000000) > 0)
                {
                    num2Text = num2Text + " " + NumeroALetras(value - Math.Truncate(value / 1000000) * 1000000);
                }
            }
            else if (ivalue == 1000000000000) num2Text = "UN BILLON";
            else if (value < 2000000000000) num2Text = "UN BILLON " + NumeroALetras(value - Math.Truncate(value / 1000000000000) * 1000000000000);
            else
            {
                num2Text = NumeroALetras(Math.Truncate(value / 1000000000000)) + " BILLONES";
                if ((value - Math.Truncate(value / 1000000000000) * 1000000000000) > 0)
                {
                    num2Text = num2Text + " " + NumeroALetras(value - Math.Truncate(value / 1000000000000) * 1000000000000);
                }
            }
            return num2Text;
        }
    }
}
