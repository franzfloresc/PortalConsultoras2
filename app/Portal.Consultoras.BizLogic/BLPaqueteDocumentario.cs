using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Net;

namespace Portal.Consultoras.BizLogic
{
    public class BLPaqueteDocumentario
    {
        public int ActualizarEstadoPaqueteDocumentario(int paisID, string codigo, int campania)
        {
            var daPaquete = new DAPaqueteDocumentario(paisID);
            return daPaquete.ActualizarEstadoPaqueteDocumentario(codigo, campania);
        }

        public bool ValidarInvitacionPaqueteDocumentario(int paisID, string codigo)
        {
            var daPaquete = new DAPaqueteDocumentario(paisID);
            int cant = 0;

            using (IDataReader reader = daPaquete.ValidarInvitacionPaqueteDocumentario(codigo))
                while (reader.Read())
                {
                    cant = Convert.ToInt32(reader.GetValue(0).ToString());
                }
            if (cant > 0) return true;
            else return false;
        }

        public List<BEPaqueteDocumentario> GetPaqueteDocumentario(int paisID)
        {
            List<BEPaqueteDocumentario> paqueteDocumentarioLista = new List<BEPaqueteDocumentario>();

            var daPaqueteDocumentario = new DAPaqueteDocumentario(paisID);
            using (IDataReader reader = daPaqueteDocumentario.GetPaqueteDocumentario())
                while (reader.Read())
                {
                    paqueteDocumentarioLista.Add(new BEPaqueteDocumentario(reader));
                }
            return paqueteDocumentarioLista;
        }

        public string[] GenerarPaqueteDocumentario(int paisID)
        {
            string[] resultadoOperacion = { "OK" };

            try
            {
                var paqueteDocumentarioLista = GetPaqueteDocumentario(paisID);

                string servidorFtp = ConfigurationManager.AppSettings["servidorFTP"];
                string archivo = ConfigurationManager.AppSettings["archivo"];
                string usuarioFtp = ConfigurationManager.AppSettings["usuarioFTP"];
                string claveFtp = ConfigurationManager.AppSettings["claveFTP"];

                Uri uri = new Uri(String.Format("ftp://{0}/{1}", servidorFtp, archivo));
                FtpWebRequest reqFtp = (FtpWebRequest)FtpWebRequest.Create(uri);
                reqFtp.Credentials = new NetworkCredential(usuarioFtp, claveFtp);
                reqFtp.Method = WebRequestMethods.Ftp.UploadFile;
                reqFtp.KeepAlive = false;
                reqFtp.UsePassive = false;

                MemoryStream stIn = new MemoryStream();
                using (StreamWriter sw = new StreamWriter(stIn))
                {
                    foreach (BEPaqueteDocumentario row in paqueteDocumentarioLista)
                    {
                        string codigo = row.codigoConsultora;
                        codigo = codigo.PadRight(15, ' ');
                        sw.WriteLine(codigo + row.campaniaID + row.estado);
                    }

                    sw.Flush();
                    using (Stream stOut = reqFtp.GetRequestStream())
                    {
                        stOut.Write(stIn.GetBuffer(), 0, (int)stIn.Length);
                    }
                }

                FtpWebResponse response = (FtpWebResponse)reqFtp.GetResponse();
                response.Close();

                return resultadoOperacion;
            }
            catch (Exception)
            {
                return null;
            }

        }
    }
}
