﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Hana
{
    public class Util
    {
        public const string RutaHana = "http://pents412:8089/Service.svc/";

        public static string GetCodigoIsoHana(int paisId)
        {
            switch (paisId)
            {
                case 2: //Bolivia
                    return "BOL";
                case 3: //Chile
                    return "CHL";
                case 4: //Colombia
                    return "COL";
                case 5: //Costa Rica
                    return "CRI";
                case 6: //Ecuador
                    return "ECU";
                case 7: //El Salvador
                    return "SLV";
                case 8: //Guatemala
                    return "GTM";
                case 9: //México
                    return "MEX";
                case 10: //Panamá
                    return "PAN";
                case 11: //Perú
                    return "PER";
                case 12: //Puerto Rico
                    return "PRI";
                case 13: //República Dominicana
                    return "DOM";
                case 14: //Venezuela
                    return "VEN";
                default:
                    return "";
            }
        }

        public static string ObtenerJsonServicioHana(string url)
        {
            System.Net.WebRequest wr = System.Net.WebRequest.Create(url);
            wr.Method = "GET";

            wr.ContentType = "application/x-www-form-urlencoded";

            System.IO.Stream newStream;
            // Obtiene la respuesta
            System.Net.WebResponse response = wr.GetResponse();
            // Stream con el contenido recibido del servidor
            newStream = response.GetResponseStream();
            System.IO.StreamReader reader = new System.IO.StreamReader(newStream);
            // Leemos el contenido
            string responseFromServer = reader.ReadToEnd();
            reader.Close();
            newStream.Close();
            response.Close();

            //json
            return responseFromServer;
        }        
    }
}
