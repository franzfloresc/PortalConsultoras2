﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Portal.Consultoras.Web.ServicePaqueteDocumentario {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="ResultObject2", Namespace="http://schemas.datacontract.org/2004/07/BEL.RVDigital.DC")]
    [System.SerializableAttribute()]
    public partial class ResultObject2 : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string errorCodeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string errorMessageField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Portal.Consultoras.Web.ServicePaqueteDocumentario.Pedido[] listaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Portal.Consultoras.Web.ServicePaqueteDocumentario.PaqueteDocumentario[] objetoField;
        
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
        public string errorCode {
            get {
                return this.errorCodeField;
            }
            set {
                if ((object.ReferenceEquals(this.errorCodeField, value) != true)) {
                    this.errorCodeField = value;
                    this.RaisePropertyChanged("errorCode");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string errorMessage {
            get {
                return this.errorMessageField;
            }
            set {
                if ((object.ReferenceEquals(this.errorMessageField, value) != true)) {
                    this.errorMessageField = value;
                    this.RaisePropertyChanged("errorMessage");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Portal.Consultoras.Web.ServicePaqueteDocumentario.Pedido[] lista {
            get {
                return this.listaField;
            }
            set {
                if ((object.ReferenceEquals(this.listaField, value) != true)) {
                    this.listaField = value;
                    this.RaisePropertyChanged("lista");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Portal.Consultoras.Web.ServicePaqueteDocumentario.PaqueteDocumentario[] objeto {
            get {
                return this.objetoField;
            }
            set {
                if ((object.ReferenceEquals(this.objetoField, value) != true)) {
                    this.objetoField = value;
                    this.RaisePropertyChanged("objeto");
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
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Pedido", Namespace="http://schemas.datacontract.org/2004/07/BEL.RVDigital.DC")]
    [System.SerializableAttribute()]
    public partial class Pedido : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string campanaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string pedidoField;
        
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
        public string campana {
            get {
                return this.campanaField;
            }
            set {
                if ((object.ReferenceEquals(this.campanaField, value) != true)) {
                    this.campanaField = value;
                    this.RaisePropertyChanged("campana");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string pedido {
            get {
                return this.pedidoField;
            }
            set {
                if ((object.ReferenceEquals(this.pedidoField, value) != true)) {
                    this.pedidoField = value;
                    this.RaisePropertyChanged("pedido");
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
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="PaqueteDocumentario", Namespace="http://schemas.datacontract.org/2004/07/BEL.RVDigital.DC")]
    [System.SerializableAttribute()]
    public partial class PaqueteDocumentario : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string fechaFacturacionField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string urlField;
        
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
        public string fechaFacturacion {
            get {
                return this.fechaFacturacionField;
            }
            set {
                if ((object.ReferenceEquals(this.fechaFacturacionField, value) != true)) {
                    this.fechaFacturacionField = value;
                    this.RaisePropertyChanged("fechaFacturacion");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string url {
            get {
                return this.urlField;
            }
            set {
                if ((object.ReferenceEquals(this.urlField, value) != true)) {
                    this.urlField = value;
                    this.RaisePropertyChanged("url");
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
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="ResultObject", Namespace="http://schemas.datacontract.org/2004/07/BEL.RVDigital.DC")]
    [System.SerializableAttribute()]
    public partial class ResultObject : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string errorCodeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string errorMessageField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string[] listaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Portal.Consultoras.Web.ServicePaqueteDocumentario.PaqueteDocumentario[] objetoField;
        
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
        public string errorCode {
            get {
                return this.errorCodeField;
            }
            set {
                if ((object.ReferenceEquals(this.errorCodeField, value) != true)) {
                    this.errorCodeField = value;
                    this.RaisePropertyChanged("errorCode");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string errorMessage {
            get {
                return this.errorMessageField;
            }
            set {
                if ((object.ReferenceEquals(this.errorMessageField, value) != true)) {
                    this.errorMessageField = value;
                    this.RaisePropertyChanged("errorMessage");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string[] lista {
            get {
                return this.listaField;
            }
            set {
                if ((object.ReferenceEquals(this.listaField, value) != true)) {
                    this.listaField = value;
                    this.RaisePropertyChanged("lista");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Portal.Consultoras.Web.ServicePaqueteDocumentario.PaqueteDocumentario[] objeto {
            get {
                return this.objetoField;
            }
            set {
                if ((object.ReferenceEquals(this.objetoField, value) != true)) {
                    this.objetoField = value;
                    this.RaisePropertyChanged("objeto");
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
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServicePaqueteDocumentario.IPdfService")]
    public interface IPdfService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPdfService/LIS_Campana", ReplyAction="http://tempuri.org/IPdfService/LIS_CampanaResponse")]
        Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject2 LIS_Campana(string Pais, string Tipo, string CodigoConsultora);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPdfService/LIS_Campana", ReplyAction="http://tempuri.org/IPdfService/LIS_CampanaResponse")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject2> LIS_CampanaAsync(string Pais, string Tipo, string CodigoConsultora);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPdfService/GET_URL", ReplyAction="http://tempuri.org/IPdfService/GET_URLResponse")]
        Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject GET_URL(string Pais, string Campana, string Tipo, string CodigoConsultora, string NumeroPedido);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPdfService/GET_URL", ReplyAction="http://tempuri.org/IPdfService/GET_URLResponse")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject> GET_URLAsync(string Pais, string Campana, string Tipo, string CodigoConsultora, string NumeroPedido);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IPdfServiceChannel : Portal.Consultoras.Web.ServicePaqueteDocumentario.IPdfService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class PdfServiceClient : System.ServiceModel.ClientBase<Portal.Consultoras.Web.ServicePaqueteDocumentario.IPdfService>, Portal.Consultoras.Web.ServicePaqueteDocumentario.IPdfService {
        
        public PdfServiceClient() {
        }
        
        public PdfServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public PdfServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public PdfServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public PdfServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject2 LIS_Campana(string Pais, string Tipo, string CodigoConsultora) {
            return base.Channel.LIS_Campana(Pais, Tipo, CodigoConsultora);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject2> LIS_CampanaAsync(string Pais, string Tipo, string CodigoConsultora) {
            return base.Channel.LIS_CampanaAsync(Pais, Tipo, CodigoConsultora);
        }
        
        public Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject GET_URL(string Pais, string Campana, string Tipo, string CodigoConsultora, string NumeroPedido) {
            return base.Channel.GET_URL(Pais, Campana, Tipo, CodigoConsultora, NumeroPedido);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePaqueteDocumentario.ResultObject> GET_URLAsync(string Pais, string Campana, string Tipo, string CodigoConsultora, string NumeroPedido) {
            return base.Channel.GET_URLAsync(Pais, Campana, Tipo, CodigoConsultora, NumeroPedido);
        }
    }
}
