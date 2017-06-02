using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebResult
    {
        [DataMember]
        public bool Result { get; set; }

        [DataMember]
        public string Code { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public BEPedidoWebDetalle Data { get; set; }

        /// <summary>
        /// Return an instance of BEPedidoWebResult with Result True
        /// </summary>
        /// <param name="code"></param>
        /// <param name="message"></param>
        /// <param name="Data"></param>
        /// <returns></returns>
        public static BEPedidoWebResult BuildOk(string code = null, string message = null, BEPedidoWebDetalle Data = null)
        {
            return new BEPedidoWebResult()
            {
                Result = true,
                Code = code,
                Message = message,
                Data = Data
            };
        }

        /// <summary>
        /// Return an instance of BEPedidoWebResult with Result False
        /// </summary>
        /// <param name="code"></param>
        /// <param name="message"></param>
        /// <param name="Data"></param>
        /// <returns></returns>
        public static BEPedidoWebResult BuildError(string code = null, string message = null, BEPedidoWebDetalle Data = null)
        {
            return new BEPedidoWebResult()
            {
                Result = false,
                Code = code,
                Message = message,
                Data = Data
            };
        }
    }
}
