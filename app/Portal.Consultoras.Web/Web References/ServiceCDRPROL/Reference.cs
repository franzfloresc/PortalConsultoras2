﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by Microsoft.VSDesigner, Version 4.0.30319.42000.
// 
#pragma warning disable 1591

namespace Portal.Consultoras.Web.ServiceCDRPROL {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.6.1055.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="WsGestionWebSoap", Namespace="http://tempuri.org/")]
    public partial class WsGestionWeb : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback GetCdrWebConsultaOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public WsGestionWeb() {
            this.Url = global::Portal.Consultoras.Web.Properties.Settings.Default.Portal_Consultoras_Web_ServiceCDRPROL_WsGestionWeb;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event GetCdrWebConsultaCompletedEventHandler GetCdrWebConsultaCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/GetCdrWebConsulta", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public RptCdr[] GetCdrWebConsulta(string pais, string periodo, string codconsultora, string cuv, int cantidad, string zona) {
            object[] results = this.Invoke("GetCdrWebConsulta", new object[] {
                        pais,
                        periodo,
                        codconsultora,
                        cuv,
                        cantidad,
                        zona});
            return ((RptCdr[])(results[0]));
        }
        
        /// <remarks/>
        public void GetCdrWebConsultaAsync(string pais, string periodo, string codconsultora, string cuv, int cantidad, string zona) {
            this.GetCdrWebConsultaAsync(pais, periodo, codconsultora, cuv, cantidad, zona, null);
        }
        
        /// <remarks/>
        public void GetCdrWebConsultaAsync(string pais, string periodo, string codconsultora, string cuv, int cantidad, string zona, object userState) {
            if ((this.GetCdrWebConsultaOperationCompleted == null)) {
                this.GetCdrWebConsultaOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetCdrWebConsultaOperationCompleted);
            }
            this.InvokeAsync("GetCdrWebConsulta", new object[] {
                        pais,
                        periodo,
                        codconsultora,
                        cuv,
                        cantidad,
                        zona}, this.GetCdrWebConsultaOperationCompleted, userState);
        }
        
        private void OnGetCdrWebConsultaOperationCompleted(object arg) {
            if ((this.GetCdrWebConsultaCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.GetCdrWebConsultaCompleted(this, new GetCdrWebConsultaCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class RptCdr {
        
        private ProductosComplementos[] lProductosComplementosField;
        
        private string codigoField;
        
        private string descripcionField;
        
        /// <remarks/>
        public ProductosComplementos[] LProductosComplementos {
            get {
                return this.lProductosComplementosField;
            }
            set {
                this.lProductosComplementosField = value;
            }
        }
        
        /// <remarks/>
        public string Codigo {
            get {
                return this.codigoField;
            }
            set {
                this.codigoField = value;
            }
        }
        
        /// <remarks/>
        public string Descripcion {
            get {
                return this.descripcionField;
            }
            set {
                this.descripcionField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.6.1067.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ProductosComplementos {
        
        private string cuvField;
        
        private string descripcionField;
        
        private string precioField;
        
        private string cantidadField;
        
        /// <remarks/>
        public string cuv {
            get {
                return this.cuvField;
            }
            set {
                this.cuvField = value;
            }
        }
        
        /// <remarks/>
        public string descripcion {
            get {
                return this.descripcionField;
            }
            set {
                this.descripcionField = value;
            }
        }
        
        /// <remarks/>
        public string precio {
            get {
                return this.precioField;
            }
            set {
                this.precioField = value;
            }
        }
        
        /// <remarks/>
        public string cantidad {
            get {
                return this.cantidadField;
            }
            set {
                this.cantidadField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.6.1055.0")]
    public delegate void GetCdrWebConsultaCompletedEventHandler(object sender, GetCdrWebConsultaCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.6.1055.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class GetCdrWebConsultaCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal GetCdrWebConsultaCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public RptCdr[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((RptCdr[])(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591