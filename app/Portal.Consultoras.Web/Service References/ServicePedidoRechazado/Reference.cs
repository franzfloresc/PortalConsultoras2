﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Portal.Consultoras.Web.ServicePedidoRechazado {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="BEPedidoRechazadoSicc", Namespace="http://schemas.datacontract.org/2004/07/Portal.Consultoras.Entities")]
    [System.SerializableAttribute()]
    public partial class BEPedidoRechazadoSicc : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CampaniaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CodigoConsultoraField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MotivoRechazoField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ValorField;
        
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
        public string Campania {
            get {
                return this.CampaniaField;
            }
            set {
                if ((object.ReferenceEquals(this.CampaniaField, value) != true)) {
                    this.CampaniaField = value;
                    this.RaisePropertyChanged("Campania");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string CodigoConsultora {
            get {
                return this.CodigoConsultoraField;
            }
            set {
                if ((object.ReferenceEquals(this.CodigoConsultoraField, value) != true)) {
                    this.CodigoConsultoraField = value;
                    this.RaisePropertyChanged("CodigoConsultora");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string MotivoRechazo {
            get {
                return this.MotivoRechazoField;
            }
            set {
                if ((object.ReferenceEquals(this.MotivoRechazoField, value) != true)) {
                    this.MotivoRechazoField = value;
                    this.RaisePropertyChanged("MotivoRechazo");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Valor {
            get {
                return this.ValorField;
            }
            set {
                if ((object.ReferenceEquals(this.ValorField, value) != true)) {
                    this.ValorField = value;
                    this.RaisePropertyChanged("Valor");
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
    [System.Runtime.Serialization.DataContractAttribute(Name="BELogGPRValidacion", Namespace="http://schemas.datacontract.org/2004/07/Portal.Consultoras.Entities")]
    [System.SerializableAttribute()]
    public partial class BELogGPRValidacion : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CampaniaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CodigoUsuarioField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private long ConsultoraIDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string DescripcionRechazoField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal DescuentoField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool EstadoSimplificacionCUVField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.DateTime FechaFinValidacionField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private long LogGPRValidacionIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MotivoRechazoField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal SubTotalField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ValorField;
        
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
        public string Campania {
            get {
                return this.CampaniaField;
            }
            set {
                if ((object.ReferenceEquals(this.CampaniaField, value) != true)) {
                    this.CampaniaField = value;
                    this.RaisePropertyChanged("Campania");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string CodigoUsuario {
            get {
                return this.CodigoUsuarioField;
            }
            set {
                if ((object.ReferenceEquals(this.CodigoUsuarioField, value) != true)) {
                    this.CodigoUsuarioField = value;
                    this.RaisePropertyChanged("CodigoUsuario");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public long ConsultoraID {
            get {
                return this.ConsultoraIDField;
            }
            set {
                if ((this.ConsultoraIDField.Equals(value) != true)) {
                    this.ConsultoraIDField = value;
                    this.RaisePropertyChanged("ConsultoraID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string DescripcionRechazo {
            get {
                return this.DescripcionRechazoField;
            }
            set {
                if ((object.ReferenceEquals(this.DescripcionRechazoField, value) != true)) {
                    this.DescripcionRechazoField = value;
                    this.RaisePropertyChanged("DescripcionRechazo");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal Descuento {
            get {
                return this.DescuentoField;
            }
            set {
                if ((this.DescuentoField.Equals(value) != true)) {
                    this.DescuentoField = value;
                    this.RaisePropertyChanged("Descuento");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool EstadoSimplificacionCUV {
            get {
                return this.EstadoSimplificacionCUVField;
            }
            set {
                if ((this.EstadoSimplificacionCUVField.Equals(value) != true)) {
                    this.EstadoSimplificacionCUVField = value;
                    this.RaisePropertyChanged("EstadoSimplificacionCUV");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.DateTime FechaFinValidacion {
            get {
                return this.FechaFinValidacionField;
            }
            set {
                if ((this.FechaFinValidacionField.Equals(value) != true)) {
                    this.FechaFinValidacionField = value;
                    this.RaisePropertyChanged("FechaFinValidacion");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public long LogGPRValidacionId {
            get {
                return this.LogGPRValidacionIdField;
            }
            set {
                if ((this.LogGPRValidacionIdField.Equals(value) != true)) {
                    this.LogGPRValidacionIdField = value;
                    this.RaisePropertyChanged("LogGPRValidacionId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string MotivoRechazo {
            get {
                return this.MotivoRechazoField;
            }
            set {
                if ((object.ReferenceEquals(this.MotivoRechazoField, value) != true)) {
                    this.MotivoRechazoField = value;
                    this.RaisePropertyChanged("MotivoRechazo");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal SubTotal {
            get {
                return this.SubTotalField;
            }
            set {
                if ((this.SubTotalField.Equals(value) != true)) {
                    this.SubTotalField = value;
                    this.RaisePropertyChanged("SubTotal");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Valor {
            get {
                return this.ValorField;
            }
            set {
                if ((object.ReferenceEquals(this.ValorField, value) != true)) {
                    this.ValorField = value;
                    this.RaisePropertyChanged("Valor");
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
    [System.Runtime.Serialization.DataContractAttribute(Name="BELogGPRValidacionDetalle", Namespace="http://schemas.datacontract.org/2004/07/Portal.Consultoras.Entities")]
    [System.SerializableAttribute()]
    public partial class BELogGPRValidacionDetalle : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CUVField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private int CantidadField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string DescripcionField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal ImporteTotalField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool IndicadorOfertaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private long LogGPRValidacionDetalleIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private long LogGPRValidacionIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal PrecioUnidadField;
        
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
        public string CUV {
            get {
                return this.CUVField;
            }
            set {
                if ((object.ReferenceEquals(this.CUVField, value) != true)) {
                    this.CUVField = value;
                    this.RaisePropertyChanged("CUV");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public int Cantidad {
            get {
                return this.CantidadField;
            }
            set {
                if ((this.CantidadField.Equals(value) != true)) {
                    this.CantidadField = value;
                    this.RaisePropertyChanged("Cantidad");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Descripcion {
            get {
                return this.DescripcionField;
            }
            set {
                if ((object.ReferenceEquals(this.DescripcionField, value) != true)) {
                    this.DescripcionField = value;
                    this.RaisePropertyChanged("Descripcion");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal ImporteTotal {
            get {
                return this.ImporteTotalField;
            }
            set {
                if ((this.ImporteTotalField.Equals(value) != true)) {
                    this.ImporteTotalField = value;
                    this.RaisePropertyChanged("ImporteTotal");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool IndicadorOferta {
            get {
                return this.IndicadorOfertaField;
            }
            set {
                if ((this.IndicadorOfertaField.Equals(value) != true)) {
                    this.IndicadorOfertaField = value;
                    this.RaisePropertyChanged("IndicadorOferta");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public long LogGPRValidacionDetalleId {
            get {
                return this.LogGPRValidacionDetalleIdField;
            }
            set {
                if ((this.LogGPRValidacionDetalleIdField.Equals(value) != true)) {
                    this.LogGPRValidacionDetalleIdField = value;
                    this.RaisePropertyChanged("LogGPRValidacionDetalleId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public long LogGPRValidacionId {
            get {
                return this.LogGPRValidacionIdField;
            }
            set {
                if ((this.LogGPRValidacionIdField.Equals(value) != true)) {
                    this.LogGPRValidacionIdField = value;
                    this.RaisePropertyChanged("LogGPRValidacionId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal PrecioUnidad {
            get {
                return this.PrecioUnidadField;
            }
            set {
                if ((this.PrecioUnidadField.Equals(value) != true)) {
                    this.PrecioUnidadField = value;
                    this.RaisePropertyChanged("PrecioUnidad");
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
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServicePedidoRechazado.IPedidoRechazadoService")]
    public interface IPedidoRechazadoService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPedidoRechazadoService/SetPedidoRechazado", ReplyAction="http://tempuri.org/IPedidoRechazadoService/SetPedidoRechazadoResponse")]
        int SetPedidoRechazado(string PaisISO, Portal.Consultoras.Web.ServicePedidoRechazado.BEPedidoRechazadoSicc[] lista);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPedidoRechazadoService/SetPedidoRechazado", ReplyAction="http://tempuri.org/IPedidoRechazadoService/SetPedidoRechazadoResponse")]
        System.Threading.Tasks.Task<int> SetPedidoRechazadoAsync(string PaisISO, Portal.Consultoras.Web.ServicePedidoRechazado.BEPedidoRechazadoSicc[] lista);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPedidoRechazadoService/GetBELogGPRValidacionByGetLogGPRValida" +
            "cionId", ReplyAction="http://tempuri.org/IPedidoRechazadoService/GetBELogGPRValidacionByGetLogGPRValida" +
            "cionIdResponse")]
        Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacion GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPedidoRechazadoService/GetBELogGPRValidacionByGetLogGPRValida" +
            "cionId", ReplyAction="http://tempuri.org/IPedidoRechazadoService/GetBELogGPRValidacionByGetLogGPRValida" +
            "cionIdResponse")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionIdAsync(int paisID, long logGPRValidacionId);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPedidoRechazadoService/GetListBELogGPRValidacionDetalleBELogG" +
            "PRValidacionByLogGPRValidacionId", ReplyAction="http://tempuri.org/IPedidoRechazadoService/GetListBELogGPRValidacionDetalleBELogG" +
            "PRValidacionByLogGPRValidacionIdResponse")]
        Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacionDetalle[] GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IPedidoRechazadoService/GetListBELogGPRValidacionDetalleBELogG" +
            "PRValidacionByLogGPRValidacionId", ReplyAction="http://tempuri.org/IPedidoRechazadoService/GetListBELogGPRValidacionDetalleBELogG" +
            "PRValidacionByLogGPRValidacionIdResponse")]
        System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacionDetalle[]> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionIdAsync(int paisID, long logGPRValidacionId);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IPedidoRechazadoServiceChannel : Portal.Consultoras.Web.ServicePedidoRechazado.IPedidoRechazadoService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class PedidoRechazadoServiceClient : System.ServiceModel.ClientBase<Portal.Consultoras.Web.ServicePedidoRechazado.IPedidoRechazadoService>, Portal.Consultoras.Web.ServicePedidoRechazado.IPedidoRechazadoService {
        
        public PedidoRechazadoServiceClient() {
        }
        
        public PedidoRechazadoServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public PedidoRechazadoServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public PedidoRechazadoServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public PedidoRechazadoServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public int SetPedidoRechazado(string PaisISO, Portal.Consultoras.Web.ServicePedidoRechazado.BEPedidoRechazadoSicc[] lista) {
            return base.Channel.SetPedidoRechazado(PaisISO, lista);
        }
        
        public System.Threading.Tasks.Task<int> SetPedidoRechazadoAsync(string PaisISO, Portal.Consultoras.Web.ServicePedidoRechazado.BEPedidoRechazadoSicc[] lista) {
            return base.Channel.SetPedidoRechazadoAsync(PaisISO, lista);
        }
        
        public Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacion GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId) {
            return base.Channel.GetBELogGPRValidacionByGetLogGPRValidacionId(paisID, logGPRValidacionId);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionIdAsync(int paisID, long logGPRValidacionId) {
            return base.Channel.GetBELogGPRValidacionByGetLogGPRValidacionIdAsync(paisID, logGPRValidacionId);
        }
        
        public Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacionDetalle[] GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId) {
            return base.Channel.GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(paisID, logGPRValidacionId);
        }
        
        public System.Threading.Tasks.Task<Portal.Consultoras.Web.ServicePedidoRechazado.BELogGPRValidacionDetalle[]> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionIdAsync(int paisID, long logGPRValidacionId) {
            return base.Channel.GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionIdAsync(paisID, logGPRValidacionId);
        }
    }
}
