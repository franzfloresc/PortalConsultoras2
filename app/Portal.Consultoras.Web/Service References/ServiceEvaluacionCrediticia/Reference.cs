﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Portal.Consultoras.Web.ServiceEvaluacionCrediticia {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="EvaluacionCrediticiaBE", Namespace="http://schemas.datacontract.org/2004/07/CORP.BEL.Unete.BL.BE")]
    [System.SerializableAttribute()]
    public partial class EvaluacionCrediticiaBE : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EnumsEstadoBurocrediticio EnumEstadoCrediticioField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MensajeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string RespuestaServicioField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EnumsEstadoBurocrediticio EnumEstadoCrediticio {
            get {
                return this.EnumEstadoCrediticioField;
            }
            set {
                if ((this.EnumEstadoCrediticioField.Equals(value) != true)) {
                    this.EnumEstadoCrediticioField = value;
                    this.RaisePropertyChanged("EnumEstadoCrediticio");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Mensaje {
            get {
                return this.MensajeField;
            }
            set {
                if ((object.ReferenceEquals(this.MensajeField, value) != true)) {
                    this.MensajeField = value;
                    this.RaisePropertyChanged("Mensaje");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string RespuestaServicio {
            get {
                return this.RespuestaServicioField;
            }
            set {
                if ((object.ReferenceEquals(this.RespuestaServicioField, value) != true)) {
                    this.RespuestaServicioField = value;
                    this.RaisePropertyChanged("RespuestaServicio");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Enums.EstadoBurocrediticio", Namespace="http://schemas.datacontract.org/2004/07/CORP.BEL.Unete.Utils")]
    public enum EnumsEstadoBurocrediticio : int {
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        SinConsultar = 1,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        PuedeSerConsultora = 2,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        NoPuedeSerConsultora = 3,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        PodriaSerConsultoraCuandoTengaAval = 4,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ErrorConsumoIntegracion = 5,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        Reactivada = 6,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        CodigoDeSuscriptorNoExiste = 7,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ClaveErrada = 8,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        NumeroTerminalNoExiste = 9,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        TipoDeDocumentoErrado = 10,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        NumeroDeDocumentoErrado = 11,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        PrimerApellidoErrado = 12,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        FinConsultaTipo2 = 13,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        FinConsultaTipo4 = 14,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        FinConsultatipo7 = 15,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        FinConsultaTipo6 = 16,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        Terminaldesactivada = 17,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ClaveDeConsultaBloqueada = 18,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        FinConsultaTipo1 = 19,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        FinConsultaTipo5 = 20,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        IngresoCorrecto = 21,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        SuPrepagoYaEstaAgotado = 22,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ClaveVencida = 23,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ClaveNoHabilitada = 24,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ModalidadDePrepagoBloqueada = 25,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ModalidadDePrepagosNoabilitada = 26,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        SuPrepagoYaFueVencido = 27,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        NoSepudoRealizarLaConsulta = 28,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        ClavedeDcifraSinTabla = 29,
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServiceEvaluacionCrediticia.IEvaluacionCrediticiaService")]
    public interface IEvaluacionCrediticiaService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticio", ReplyAction="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioRespon" +
            "se")]
        Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE ConsultarServicioCrediticio(string codigoISO, string usuario, string zona, string documento);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticio", ReplyAction="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioRespon" +
            "se")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE> ConsultarServicioCrediticioAsync(string codigoISO, string usuario, string zona, string documento);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioCO", ReplyAction="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioCOResp" +
            "onse")]
        Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE ConsultarServicioCrediticioCO(string codigoISO, string TipoDocumento, string NumDocumento, string Apellido, string CodRegion, string CodZona, string Login);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioCO", ReplyAction="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioCOResp" +
            "onse")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE> ConsultarServicioCrediticioCOAsync(string codigoISO, string TipoDocumento, string NumDocumento, string Apellido, string CodRegion, string CodZona, string Login);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioPeru", ReplyAction="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioPeruRe" +
            "sponse")]
        Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE ConsultarServicioCrediticioPeru(string codigoIso, string tipoIdentificacion, string numeroDocumento);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioPeru", ReplyAction="http://tempuri.org/IEvaluacionCrediticiaService/ConsultarServicioCrediticioPeruRe" +
            "sponse")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE> ConsultarServicioCrediticioPeruAsync(string codigoIso, string tipoIdentificacion, string numeroDocumento);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IEvaluacionCrediticiaServiceChannel : Portal.Consultoras.Web.ServiceEvaluacionCrediticia.IEvaluacionCrediticiaService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class EvaluacionCrediticiaServiceClient : System.ServiceModel.ClientBase<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.IEvaluacionCrediticiaService>, Portal.Consultoras.Web.ServiceEvaluacionCrediticia.IEvaluacionCrediticiaService {
        
        public EvaluacionCrediticiaServiceClient() {
        }
        
        public EvaluacionCrediticiaServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public EvaluacionCrediticiaServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public EvaluacionCrediticiaServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public EvaluacionCrediticiaServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE ConsultarServicioCrediticio(string codigoISO, string usuario, string zona, string documento) {
            return base.Channel.ConsultarServicioCrediticio(codigoISO, usuario, zona, documento);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE> ConsultarServicioCrediticioAsync(string codigoISO, string usuario, string zona, string documento) {
            return base.Channel.ConsultarServicioCrediticioAsync(codigoISO, usuario, zona, documento);
        }
        
        public Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE ConsultarServicioCrediticioCO(string codigoISO, string TipoDocumento, string NumDocumento, string Apellido, string CodRegion, string CodZona, string Login) {
            return base.Channel.ConsultarServicioCrediticioCO(codigoISO, TipoDocumento, NumDocumento, Apellido, CodRegion, CodZona, Login);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE> ConsultarServicioCrediticioCOAsync(string codigoISO, string TipoDocumento, string NumDocumento, string Apellido, string CodRegion, string CodZona, string Login) {
            return base.Channel.ConsultarServicioCrediticioCOAsync(codigoISO, TipoDocumento, NumDocumento, Apellido, CodRegion, CodZona, Login);
        }
        
        public Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE ConsultarServicioCrediticioPeru(string codigoIso, string tipoIdentificacion, string numeroDocumento) {
            return base.Channel.ConsultarServicioCrediticioPeru(codigoIso, tipoIdentificacion, numeroDocumento);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServiceEvaluacionCrediticia.EvaluacionCrediticiaBE> ConsultarServicioCrediticioPeruAsync(string codigoIso, string tipoIdentificacion, string numeroDocumento) {
            return base.Channel.ConsultarServicioCrediticioPeruAsync(codigoIso, tipoIdentificacion, numeroDocumento);
        }
    }
}
