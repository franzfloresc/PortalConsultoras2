using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.Framework
{
    [DataContract]
    public class ResponseType<T>
    {
        [DataMember]
        public bool Success { get; set; }

        [DataMember]
        public string Code { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public T Data { get; set; }

        private ResponseType()
        { }

        /// <summary>
        /// Construye una instancia de ResponseType, default success = true, code = 0, message = "", data = default(T)
        /// </summary>
        /// <param name="success">Satisfactorio o no</param>
        /// <param name="code">Codigo en caso lo tubiera</param>
        /// <param name="message">Mensaje en caso lo hubiera</param>
        /// <param name="data">Objeto respuesta</param>
        /// <returns>Por defecto crea una instancia satisfactoria</returns>
        public static ResponseType<T> Build(bool success = true, string code = Constantes.ClienteValidacion.Code.SUCCESS, string message = "", T data = default(T))
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
