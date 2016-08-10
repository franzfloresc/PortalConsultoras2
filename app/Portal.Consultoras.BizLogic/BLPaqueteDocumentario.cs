using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.IO;
using System.Net;
using System.Configuration;

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
            List<BEPaqueteDocumentario> PaqueteDocumentarioLista = new List<BEPaqueteDocumentario>();

            var DAPaqueteDocumentario = new DAPaqueteDocumentario(paisID);
            using (IDataReader reader = DAPaqueteDocumentario.GetPaqueteDocumentario())
                while (reader.Read())
                {
                    PaqueteDocumentarioLista.Add(new BEPaqueteDocumentario(reader));
                }
            return PaqueteDocumentarioLista;
        }

        public string[] GenerarPaqueteDocumentario(int paisID)
        {
            string[] resultadoOperacion = {"OK"};

            try
            {
                List<BEPaqueteDocumentario> PaqueteDocumentarioLista;
                PaqueteDocumentarioLista = GetPaqueteDocumentario(paisID);

                string servidorFTP = ConfigurationManager.AppSettings["servidorFTP"];
                string archivo = ConfigurationManager.AppSettings["archivo"];
                string usuarioFTP = ConfigurationManager.AppSettings["usuarioFTP"];
                string claveFTP = ConfigurationManager.AppSettings["claveFTP"];

                Uri uri = new Uri(String.Format("ftp://{0}/{1}", servidorFTP, archivo));
                FtpWebRequest reqFTP = (FtpWebRequest)FtpWebRequest.Create(uri);
                reqFTP.Credentials = new NetworkCredential(usuarioFTP, claveFTP);
                reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
                reqFTP.KeepAlive = false;
                reqFTP.UsePassive = false;

                MemoryStream stIn = new MemoryStream();
                using (StreamWriter sw = new StreamWriter(stIn))
                {
                    foreach (BEPaqueteDocumentario row in PaqueteDocumentarioLista)
                    {
                        string codigo = row.codigoConsultora;
                        codigo = codigo.PadRight(15, ' ');
                        sw.WriteLine(codigo + row.campaniaID + row.estado);
                    }

                    sw.Flush();
                    using (Stream stOut = reqFTP.GetRequestStream())
                    {
                        stOut.Write(stIn.GetBuffer(), 0, (int)stIn.Length);
                    }
                }

                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
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
