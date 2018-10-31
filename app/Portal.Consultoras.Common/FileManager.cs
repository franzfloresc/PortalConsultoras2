using Omu.Drawing;
using System;
using System.Drawing;
using System.IO;
using System.Text;

namespace Portal.Consultoras.Common
{
    public class FileManager
    {
        private const string Path = "\\";
        private const string TempPath = "\\";

        public static string GetContenido(string filepath)
        {
            using (StreamReader reader = new StreamReader(filepath))
            {
                return reader.ReadToEnd();
            }
        }

        public static void DeleteImages(string root, string filename)
        {
            try
            {
                var c = root + Path;
                File.Delete(c + filename);
            }
            catch (Exception) { }
        }

        public static void DeleteImagesInFolder(string root)
        {
            try
            {
                string[] files = Directory.GetFiles(root);

                foreach (string file in files)
                {
                    File.Delete(file);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void DeleteFilter(string root, string filter)
        {
            try
            {
                string[] files = Directory.GetFiles(root);

                foreach (string file in files)
                {
                    string fileName = System.IO.Path.GetFileName(file);
                    if (!fileName.ToUpper().Equals(filter.ToUpper()))
                        File.Delete(file);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void DeleteImage(string root, string image)
        {
            try
            {
                string[] files = Directory.GetFiles(root);

                foreach (string file in files)
                {
                    string fileName = System.IO.Path.GetFileName(file);
                    if (fileName.ToUpper().Equals(image.ToUpper()))
                        File.Delete(file);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static string CopyImages(string root, string filename, string temproot)
        {
            if (!File.Exists(root))
                Directory.CreateDirectory(root);
            var t = temproot + TempPath + filename;
            var r = root + Path + filename;

            var newfilename = string.Empty;

            if (File.Exists(t))
            {
                File.Copy(t, r, true);
                newfilename = filename;
            }

            return newfilename;
        }

        public static string CopyFile(string root, string filename, string temproot)
        {
            if (!File.Exists(temproot))
                Directory.CreateDirectory(temproot);
            var t = temproot + TempPath + filename;

            if (File.Exists(root))
            {
                File.Copy(root, t, true);
            }
            return filename;
        }

        public static void MakeImages(string root, string filename, int x, int y, int w, int h)
        {
            using (var image = Image.FromFile(root + TempPath + filename))
            {
                var c = root + Path;
                var img = Imager.Crop(image, new Rectangle(x, y, w, h));
                var resized = Imager.Resize(img, 200, 150, true);
                var small = Imager.Resize(img, 100, 75, true);
                var mini = Imager.Resize(img, 45, 34, true);
                Imager.SaveJpeg(c + filename, resized);
                Imager.SaveJpeg(c + "s" + filename, small);
                Imager.SaveJpeg(c + "m" + filename, mini);
            }
        }

        public static string SaveTempJpeg(string root, Stream inputStream, ref int w, ref int h)
        {
            var g = Guid.NewGuid() + ".jpg";
            var filePath = root + TempPath + g;

            using (var image = Image.FromStream(inputStream))
            {
                h = h == 0 ? 30 : h;
                w = w == 0 ? 30 : h;

                var resized = Imager.Resize(image, image.Height, image.Width, true);
                if (!File.Exists(System.IO.Path.GetDirectoryName(filePath)))
                    Directory.CreateDirectory(System.IO.Path.GetDirectoryName(filePath));
                Imager.SaveJpeg(filePath, resized);
                w = image.Width;
                h = image.Height;

                return g;
            }
        }

        public static string SaveTempPng(string root, string FileName)
        {
            try
            {
                string sPathFile = @"D:\LogError\";
                if (!Directory.Exists(sPathFile))
                    Directory.CreateDirectory(sPathFile);
                StreamWriter log = new StreamWriter(new FileStream(sPathFile + "logfile.txt", FileMode.Create));
                log.WriteLine(string.Format("root ==> {0}", root));
                log.WriteLine(string.Format("FileName ==> {0}", FileName));


                var filePath = root + TempPath + System.IO.Path.GetFileName(FileName);

                log.WriteLine(string.Format("filePath ==> {0}", filePath));
                log.WriteLine(string.Format("Globals.RutaImagenesTemp ==> {0}", Globals.RutaImagenesTemp));
                log.WriteLine(string.Format("TempPath ==> {0}", TempPath));

                File.Copy(FileName, (Globals.RutaImagenesTemp + TempPath + System.IO.Path.GetFileName(FileName)), true);
                log.Flush();
                log.Close();
                return System.IO.Path.GetFileName(filePath);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        public static string CopyImagesFondoLogo(string root, string filename, string temproot, string Pais, string CampaniaID)
        {
            if (!File.Exists(root))
                Directory.CreateDirectory(root);
            var t = temproot + TempPath + filename;
            var newfilename = Pais + "_" + CampaniaID + ".png";
            var r = root + Path + newfilename;

            if (File.Exists(t))
            {
                File.Copy(t, r, true);
            }

            return newfilename;
        }

        public static string CopyImagesOfertas(string root, string filename, string temproot, string ISO, string campania, string cuv)
        {
            if (!File.Exists(root))
                Directory.CreateDirectory(root);
            var t = temproot + TempPath + filename;
            var newfilename = ISO + "_" + campania + "_" + cuv + "_" + RandomString() + ".png";
            var r = root + Path + newfilename;

            if (File.Exists(t))
            {
                File.Copy(t, r, true);
            }

            return newfilename;
        }

        public static string CopyImagesMatriz(string root, string filename, string temproot, string ISO, string CodigoProducto, string numero)
        {

            string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            if (!File.Exists(root))
                Directory.CreateDirectory(root);
            var t = temproot + TempPath + filename;
            var newfilename = ISO + "_" + CodigoProducto + "_" + time + "_" + numero + "_" + RandomString() + ".png";
            var r = root + Path + newfilename;

            if (File.Exists(t))
            {
                File.Copy(t, r, true);
            }

            return newfilename;
        }

        public static string CopyImagesBanner(string root, string temproot, string filename)
        {

            string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            if (!File.Exists(root))
                Directory.CreateDirectory(root);
            var t = temproot + TempPath + filename;
            var newfilename = filename.Substring(0, filename.Length - 4) + "_" + time + ".png";
            var r = root + Path + newfilename;

            if (File.Exists(t))
            {
                File.Copy(t, r, true);
            }

            return newfilename;
        }

        public static string RandomString()
        {
            int size = 10;
            StringBuilder builder = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < size; i++)
            {
                var ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }
            return builder.ToString().ToLower();
        }

        public static void DeleteFileStartWhit(string rutaFisica, string nameStart)
        {
            var files = Directory.GetFiles(rutaFisica, nameStart + ".*");
            foreach (var name in files)
            {
                File.Delete(name);
            }
        }
    }
}