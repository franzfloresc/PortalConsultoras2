﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.34209
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// Microsoft.VSDesigner generó automáticamente este código fuente, versión=4.0.30319.34209.
// 
#pragma warning disable 1591

namespace Portal.Consultoras.Web.ServicesCalculosPROL {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    using System.Data;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="ServicesCalculoPrecioNivelesSoap", Namespace="http://tempuri.org/")]
    public partial class ServicesCalculoPrecioNiveles : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback CalculoOfertasNivelesOperationCompleted;
        
        private System.Threading.SendOrPostCallback CalculoMontosProlOperationCompleted;
        
        private System.Threading.SendOrPostCallback Ofertas_catalogoOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public ServicesCalculoPrecioNiveles() {
            this.Url = global::Portal.Consultoras.Web.Properties.Settings.Default.Portal_Consultoras_Web_ServicesCalculosPROL_ServicesCalculoPrecioNiveles;
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
        public event CalculoOfertasNivelesCompletedEventHandler CalculoOfertasNivelesCompleted;
        
        /// <remarks/>
        public event CalculoMontosProlCompletedEventHandler CalculoMontosProlCompleted;
        
        /// <remarks/>
        public event Ofertas_catalogoCompletedEventHandler Ofertas_catalogoCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/CalculoOfertasNiveles", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public ObjProductosNiveles[] CalculoOfertasNiveles(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos) {
            object[] results = this.Invoke("CalculoOfertasNiveles", new object[] {
                        pais,
                        periodo,
                        codigoconsultora,
                        zona,
                        lstProductos});
            return ((ObjProductosNiveles[])(results[0]));
        }
        
        /// <remarks/>
        public void CalculoOfertasNivelesAsync(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos) {
            this.CalculoOfertasNivelesAsync(pais, periodo, codigoconsultora, zona, lstProductos, null);
        }
        
        /// <remarks/>
        public void CalculoOfertasNivelesAsync(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos, object userState) {
            if ((this.CalculoOfertasNivelesOperationCompleted == null)) {
                this.CalculoOfertasNivelesOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCalculoOfertasNivelesOperationCompleted);
            }
            this.InvokeAsync("CalculoOfertasNiveles", new object[] {
                        pais,
                        periodo,
                        codigoconsultora,
                        zona,
                        lstProductos}, this.CalculoOfertasNivelesOperationCompleted, userState);
        }
        
        private void OnCalculoOfertasNivelesOperationCompleted(object arg) {
            if ((this.CalculoOfertasNivelesCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.CalculoOfertasNivelesCompleted(this, new CalculoOfertasNivelesCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/CalculoMontosProl", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public ObjMontosProl[] CalculoMontosProl(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos) {
            object[] results = this.Invoke("CalculoMontosProl", new object[] {
                        pais,
                        periodo,
                        codigoconsultora,
                        zona,
                        lstProductos});
            return ((ObjMontosProl[])(results[0]));
        }
        
        /// <remarks/>
        public void CalculoMontosProlAsync(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos) {
            this.CalculoMontosProlAsync(pais, periodo, codigoconsultora, zona, lstProductos, null);
        }
        
        /// <remarks/>
        public void CalculoMontosProlAsync(string pais, string periodo, string codigoconsultora, string zona, System.Data.DataTable lstProductos, object userState) {
            if ((this.CalculoMontosProlOperationCompleted == null)) {
                this.CalculoMontosProlOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCalculoMontosProlOperationCompleted);
            }
            this.InvokeAsync("CalculoMontosProl", new object[] {
                        pais,
                        periodo,
                        codigoconsultora,
                        zona,
                        lstProductos}, this.CalculoMontosProlOperationCompleted, userState);
        }
        
        private void OnCalculoMontosProlOperationCompleted(object arg) {
            if ((this.CalculoMontosProlCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.CalculoMontosProlCompleted(this, new CalculoMontosProlCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/Ofertas_catalogo", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public ObjOfertaCatalogos Ofertas_catalogo(string pais, string periodo, string codvta, string codigoconsultora, string zona, string tipo_oferta) {
            object[] results = this.Invoke("Ofertas_catalogo", new object[] {
                        pais,
                        periodo,
                        codvta,
                        codigoconsultora,
                        zona,
                        tipo_oferta});
            return ((ObjOfertaCatalogos)(results[0]));
        }
        
        /// <remarks/>
        public void Ofertas_catalogoAsync(string pais, string periodo, string codvta, string codigoconsultora, string zona, string tipo_oferta) {
            this.Ofertas_catalogoAsync(pais, periodo, codvta, codigoconsultora, zona, tipo_oferta, null);
        }
        
        /// <remarks/>
        public void Ofertas_catalogoAsync(string pais, string periodo, string codvta, string codigoconsultora, string zona, string tipo_oferta, object userState) {
            if ((this.Ofertas_catalogoOperationCompleted == null)) {
                this.Ofertas_catalogoOperationCompleted = new System.Threading.SendOrPostCallback(this.OnOfertas_catalogoOperationCompleted);
            }
            this.InvokeAsync("Ofertas_catalogo", new object[] {
                        pais,
                        periodo,
                        codvta,
                        codigoconsultora,
                        zona,
                        tipo_oferta}, this.Ofertas_catalogoOperationCompleted, userState);
        }
        
        private void OnOfertas_catalogoOperationCompleted(object arg) {
            if ((this.Ofertas_catalogoCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.Ofertas_catalogoCompleted(this, new Ofertas_catalogoCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
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
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjProductosNiveles {
        
        private string cuvField;
        
        private string idnivelField;
        
        private decimal precioField;
        
        /// <comentarios/>
        public string cuv {
            get {
                return this.cuvField;
            }
            set {
                this.cuvField = value;
            }
        }
        
        /// <comentarios/>
        public string idnivel {
            get {
                return this.idnivelField;
            }
            set {
                this.idnivelField = value;
            }
        }
        
        /// <comentarios/>
        public decimal precio {
            get {
                return this.precioField;
            }
            set {
                this.precioField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjItemPack {
        
        private string cuv_pack_itemField;
        
        private string cuv_itemField;
        
        private string descripcion_item_packField;
        
        private string cantidad_item_packField;
        
        private string codsap_item_packField;
        
        private string imagen_item_packField;
        
        /// <comentarios/>
        public string cuv_pack_item {
            get {
                return this.cuv_pack_itemField;
            }
            set {
                this.cuv_pack_itemField = value;
            }
        }
        
        /// <comentarios/>
        public string cuv_item {
            get {
                return this.cuv_itemField;
            }
            set {
                this.cuv_itemField = value;
            }
        }
        
        /// <comentarios/>
        public string descripcion_item_pack {
            get {
                return this.descripcion_item_packField;
            }
            set {
                this.descripcion_item_packField = value;
            }
        }
        
        /// <comentarios/>
        public string cantidad_item_pack {
            get {
                return this.cantidad_item_packField;
            }
            set {
                this.cantidad_item_packField = value;
            }
        }
        
        /// <comentarios/>
        public string codsap_item_pack {
            get {
                return this.codsap_item_packField;
            }
            set {
                this.codsap_item_packField = value;
            }
        }
        
        /// <comentarios/>
        public string imagen_item_pack {
            get {
                return this.imagen_item_packField;
            }
            set {
                this.imagen_item_packField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjPack {
        
        private string cuv_packField;
        
        private string nombre_packField;
        
        private string precio_packField;
        
        private string valorizadoField;
        
        private string ganancia_packField;
        
        /// <comentarios/>
        public string cuv_pack {
            get {
                return this.cuv_packField;
            }
            set {
                this.cuv_packField = value;
            }
        }
        
        /// <comentarios/>
        public string nombre_pack {
            get {
                return this.nombre_packField;
            }
            set {
                this.nombre_packField = value;
            }
        }
        
        /// <comentarios/>
        public string precio_pack {
            get {
                return this.precio_packField;
            }
            set {
                this.precio_packField = value;
            }
        }
        
        /// <comentarios/>
        public string valorizado {
            get {
                return this.valorizadoField;
            }
            set {
                this.valorizadoField = value;
            }
        }
        
        /// <comentarios/>
        public string ganancia_pack {
            get {
                return this.ganancia_packField;
            }
            set {
                this.ganancia_packField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjGratis {
        
        private string escala_nivel_gratisField;
        
        private int cantidadField;
        
        private string codsap_nivel_gratisField;
        
        private string descripcion_gratisField;
        
        private string imagen_gratisField;
        
        /// <comentarios/>
        public string escala_nivel_gratis {
            get {
                return this.escala_nivel_gratisField;
            }
            set {
                this.escala_nivel_gratisField = value;
            }
        }
        
        /// <comentarios/>
        public int cantidad {
            get {
                return this.cantidadField;
            }
            set {
                this.cantidadField = value;
            }
        }
        
        /// <comentarios/>
        public string codsap_nivel_gratis {
            get {
                return this.codsap_nivel_gratisField;
            }
            set {
                this.codsap_nivel_gratisField = value;
            }
        }
        
        /// <comentarios/>
        public string descripcion_gratis {
            get {
                return this.descripcion_gratisField;
            }
            set {
                this.descripcion_gratisField = value;
            }
        }
        
        /// <comentarios/>
        public string imagen_gratis {
            get {
                return this.imagen_gratisField;
            }
            set {
                this.imagen_gratisField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjNivel {
        
        private string escala_nivelField;
        
        private string nombre_nivelField;
        
        private string precio_nivelField;
        
        private string ganancia_nivelField;
        
        /// <comentarios/>
        public string escala_nivel {
            get {
                return this.escala_nivelField;
            }
            set {
                this.escala_nivelField = value;
            }
        }
        
        /// <comentarios/>
        public string nombre_nivel {
            get {
                return this.nombre_nivelField;
            }
            set {
                this.nombre_nivelField = value;
            }
        }
        
        /// <comentarios/>
        public string precio_nivel {
            get {
                return this.precio_nivelField;
            }
            set {
                this.precio_nivelField = value;
            }
        }
        
        /// <comentarios/>
        public string ganancia_nivel {
            get {
                return this.ganancia_nivelField;
            }
            set {
                this.ganancia_nivelField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjOfertaCatalogos {
        
        private ObjNivel[] lista_ObjNivelField;
        
        private ObjGratis[] lista_oObjGratisField;
        
        private ObjPack[] lista_oObjPackField;
        
        private ObjItemPack[] lista_oObjItemPackField;
        
        private string tipo_ofertaField;
        
        private string cuv_catalogoField;
        
        private string sap_catalogoField;
        
        private string precio_catalogoField;
        
        private string cuv_revistaField;
        
        private string sap_revistaField;
        
        private string precio_revistaField;
        
        private string gananciaField;
        
        /// <comentarios/>
        public ObjNivel[] lista_ObjNivel {
            get {
                return this.lista_ObjNivelField;
            }
            set {
                this.lista_ObjNivelField = value;
            }
        }
        
        /// <comentarios/>
        public ObjGratis[] lista_oObjGratis {
            get {
                return this.lista_oObjGratisField;
            }
            set {
                this.lista_oObjGratisField = value;
            }
        }
        
        /// <comentarios/>
        public ObjPack[] lista_oObjPack {
            get {
                return this.lista_oObjPackField;
            }
            set {
                this.lista_oObjPackField = value;
            }
        }
        
        /// <comentarios/>
        public ObjItemPack[] lista_oObjItemPack {
            get {
                return this.lista_oObjItemPackField;
            }
            set {
                this.lista_oObjItemPackField = value;
            }
        }
        
        /// <comentarios/>
        public string tipo_oferta {
            get {
                return this.tipo_ofertaField;
            }
            set {
                this.tipo_ofertaField = value;
            }
        }
        
        /// <comentarios/>
        public string cuv_catalogo {
            get {
                return this.cuv_catalogoField;
            }
            set {
                this.cuv_catalogoField = value;
            }
        }
        
        /// <comentarios/>
        public string sap_catalogo {
            get {
                return this.sap_catalogoField;
            }
            set {
                this.sap_catalogoField = value;
            }
        }
        
        /// <comentarios/>
        public string precio_catalogo {
            get {
                return this.precio_catalogoField;
            }
            set {
                this.precio_catalogoField = value;
            }
        }
        
        /// <comentarios/>
        public string cuv_revista {
            get {
                return this.cuv_revistaField;
            }
            set {
                this.cuv_revistaField = value;
            }
        }
        
        /// <comentarios/>
        public string sap_revista {
            get {
                return this.sap_revistaField;
            }
            set {
                this.sap_revistaField = value;
            }
        }
        
        /// <comentarios/>
        public string precio_revista {
            get {
                return this.precio_revistaField;
            }
            set {
                this.precio_revistaField = value;
            }
        }
        
        /// <comentarios/>
        public string ganancia {
            get {
                return this.gananciaField;
            }
            set {
                this.gananciaField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.34281")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://tempuri.org/")]
    public partial class ObjMontosProl {
        
        private string montoTotalDescuentoField;
        
        private string montoEscalaField;
        
        private string ahorroCatalogoField;
        
        private string ahorroRevistaField;
        
        /// <comentarios/>
        public string MontoTotalDescuento {
            get {
                return this.montoTotalDescuentoField;
            }
            set {
                this.montoTotalDescuentoField = value;
            }
        }
        
        /// <comentarios/>
        public string MontoEscala {
            get {
                return this.montoEscalaField;
            }
            set {
                this.montoEscalaField = value;
            }
        }
        
        /// <comentarios/>
        public string AhorroCatalogo {
            get {
                return this.ahorroCatalogoField;
            }
            set {
                this.ahorroCatalogoField = value;
            }
        }
        
        /// <comentarios/>
        public string AhorroRevista {
            get {
                return this.ahorroRevistaField;
            }
            set {
                this.ahorroRevistaField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    public delegate void CalculoOfertasNivelesCompletedEventHandler(object sender, CalculoOfertasNivelesCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class CalculoOfertasNivelesCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal CalculoOfertasNivelesCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public ObjProductosNiveles[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((ObjProductosNiveles[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    public delegate void CalculoMontosProlCompletedEventHandler(object sender, CalculoMontosProlCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class CalculoMontosProlCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal CalculoMontosProlCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public ObjMontosProl[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((ObjMontosProl[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    public delegate void Ofertas_catalogoCompletedEventHandler(object sender, Ofertas_catalogoCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.34209")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class Ofertas_catalogoCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal Ofertas_catalogoCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public ObjOfertaCatalogos Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((ObjOfertaCatalogos)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591