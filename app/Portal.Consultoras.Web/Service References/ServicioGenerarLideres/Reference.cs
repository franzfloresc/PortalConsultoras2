﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.17929
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Portal.Consultoras.Web.ServicioGenerarLideres {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServicioGenerarLideres.WS_GenerarLideresSoap")]
    public interface WS_GenerarLideresSoap {
        
        // CODEGEN: Se está generando un contrato de mensaje, ya que el nombre de elemento isoPais del espacio de nombres http://tempuri.org/ no está marcado para aceptar valores nil.
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/GenerarLideres", ReplyAction="*")]
        Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponse GenerarLideres(Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest request);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/GenerarLideres", ReplyAction="*")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponse> GenerarLideresAsync(Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest request);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class GenerarLideresRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="GenerarLideres", Namespace="http://tempuri.org/", Order=0)]
        public Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequestBody Body;
        
        public GenerarLideresRequest() {
        }
        
        public GenerarLideresRequest(Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class GenerarLideresRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string isoPais;
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=1)]
        public string fechaProceso;
        
        public GenerarLideresRequestBody() {
        }
        
        public GenerarLideresRequestBody(string isoPais, string fechaProceso) {
            this.isoPais = isoPais;
            this.fechaProceso = fechaProceso;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class GenerarLideresResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="GenerarLideresResponse", Namespace="http://tempuri.org/", Order=0)]
        public Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponseBody Body;
        
        public GenerarLideresResponse() {
        }
        
        public GenerarLideresResponse(Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class GenerarLideresResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=0)]
        public int GenerarLideresResult;
        
        public GenerarLideresResponseBody() {
        }
        
        public GenerarLideresResponseBody(int GenerarLideresResult) {
            this.GenerarLideresResult = GenerarLideresResult;
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface WS_GenerarLideresSoapChannel : Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class WS_GenerarLideresSoapClient : System.ServiceModel.ClientBase<Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap>, Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap {
        
        public WS_GenerarLideresSoapClient() {
        }
        
        public WS_GenerarLideresSoapClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public WS_GenerarLideresSoapClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public WS_GenerarLideresSoapClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public WS_GenerarLideresSoapClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponse Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap.GenerarLideres(Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest request) {
            return base.Channel.GenerarLideres(request);
        }
        
        public int GenerarLideres(string isoPais, string fechaProceso) {
            Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest inValue = new Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest();
            inValue.Body = new Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequestBody();
            inValue.Body.isoPais = isoPais;
            inValue.Body.fechaProceso = fechaProceso;
            Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponse retVal = ((Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap)(this)).GenerarLideres(inValue);
            return retVal.Body.GenerarLideresResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponse> Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap.GenerarLideresAsync(Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest request) {
            return base.Channel.GenerarLideresAsync(request);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresResponse> GenerarLideresAsync(string isoPais, string fechaProceso) {
            Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest inValue = new Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequest();
            inValue.Body = new Portal.Consultoras.Web.ServicioGenerarLideres.GenerarLideresRequestBody();
            inValue.Body.isoPais = isoPais;
            inValue.Body.fechaProceso = fechaProceso;
            return ((Portal.Consultoras.Web.ServicioGenerarLideres.WS_GenerarLideresSoap)(this)).GenerarLideresAsync(inValue);
        }
    }
}
