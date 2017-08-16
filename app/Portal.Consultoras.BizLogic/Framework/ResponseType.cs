using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Framework
{
    public class ResponseType<T>
    {
        public bool Success { get; set; }
        public string Code { get; set; }
        public string Message { get; set; }
        public T Data { get; set; }

        private ResponseType()
        { }

        /// <summary>
        /// Construye una instancia de ResponseType, default success = true, code = 000, message = "", data = default(T)
        /// </summary>
        /// <param name="success">Satisfactorio o no</param>
        /// <param name="code">Codigo en caso lo tubiera</param>
        /// <param name="message">Mensaje en caso lo hubiera</param>
        /// <param name="data">Objeto respuesta</param>
        /// <returns>Por defecto crea una instancia satisfactoria</returns>
        public static ResponseType<T> Build(bool success = true, string code = "000", string message = "", T data = default(T))
        {
            return new ResponseType<T>()
            {
                Success = success,
                Code = code,
                Message = message,
                Data = data
            };
        }
    }
}
