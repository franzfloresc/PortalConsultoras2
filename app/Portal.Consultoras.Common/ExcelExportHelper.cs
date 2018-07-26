using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using Spire.Xls;
using System.IO;
using System.Drawing;
using System.Reflection;
using System.Text;

namespace Portal.Consultoras.Common
{
    public static class ExcelExportHelper
    {
        
        public static MemoryStream ExportarExcel<T>(string nombreDelArchivo, string nombreDeHoja,
                                             Dictionary<string, string> definicionDeColumna, IEnumerable<T> dto
                                             )
        {
            List<string> columna = new List<string>();
            //StringBuilder formatoDeNumero = new StringBuilder();

            Workbook wbToStream = new Workbook();
            Worksheet sheet = wbToStream.Worksheets[0];
            MemoryStream memoryStream = new MemoryStream();

            List<ExcelCellHeader> listHeader = new List<ExcelCellHeader>();

            wbToStream.Version = ExcelVersion.Version2013;
            wbToStream.Worksheets[2].Remove();
            wbToStream.Worksheets[1].Remove();

            sheet.Name = nombreDeHoja;

            foreach (KeyValuePair<string, string> keyvalue in definicionDeColumna)
            {

                listHeader.Add(new ExcelCellHeader(keyvalue.Value, 10, Color.Purple, Color.White, true));
                columna.Add(keyvalue.Value);
            }

            int columnIndex = 0;
            foreach (var header in listHeader)
            {
                columnIndex += 1;
                sheet.SetText(1, columnIndex, header.Nombre);
                sheet.SetColumnWidth(columnIndex, header.Ancho);
                sheet.Range[string.Format("{0}{1}", ExcelColumn.IntToAA(columnIndex), 1)].Style.Color = header.Fondo;
                sheet.Range[string.Format("{0}{1}", ExcelColumn.IntToAA(columnIndex), 1)].Style.Font.Color = header.Color;
                sheet.Range[string.Format("{0}{1}", ExcelColumn.IntToAA(columnIndex), 1)].Style.Font.IsBold = header.IsBold;
            }


            int rowIndex = 2;
            foreach (var dataItem in (System.Collections.IEnumerable)dto)
            {
                int colIndex = 1;
                foreach (string column in columna)
                {
                    string columnaSeleccionado = column;
                    foreach (PropertyInfo property in dataItem.GetType().GetProperties().Where(property => columnaSeleccionado == property.Name))
                    {
                        sheet.SetText(rowIndex, colIndex, String.IsNullOrEmpty(System.Web.UI.DataBinder.GetPropertyValue(dataItem,
                                                                                                           property.Name,
                                                                                                           null)) ? " " : System.Web.UI.DataBinder.GetPropertyValue(dataItem,
                                                                                                           property.Name,
                                                                                                           null));
                    }
                    colIndex++;
                }
                rowIndex++;
            }

            wbToStream.SaveToStream(memoryStream, FileFormat.Version2007);

            return memoryStream;

        }
    }
}
