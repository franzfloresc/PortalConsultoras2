﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Portal.Consultoras.BizLogic.Resources {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class MotivoRechazoMessages {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal MotivoRechazoMessages() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Portal.Consultoras.BizLogic.Resources.MotivoRechazoMessages", typeof(MotivoRechazoMessages).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Tienes una deuda de {0}.
        /// </summary>
        internal static string DeudaMensaje {
            get {
                return ResourceManager.GetString("DeudaMensaje", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Te notificaremos en caso tu pedido tenga observaciones..
        /// </summary>
        internal static string FacturadoMensaje {
            get {
                return ResourceManager.GetString("FacturadoMensaje", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ESTAMOS FACTURANDO TU PEDIDO DE C{0}.
        /// </summary>
        internal static string FacturadoTitulo {
            get {
                return ResourceManager.GetString("FacturadoTitulo", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Superaste tu línea de crédito de {0} {1}.
        /// </summary>
        internal static string MontoMaximoMensaje {
            get {
                return ResourceManager.GetString("MontoMaximoMensaje", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to No llegaste al monto mínimo de {0} {1}.
        /// </summary>
        internal static string MontoMinimoMensaje {
            get {
                return ResourceManager.GetString("MontoMinimoMensaje", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to TU PEDIDO HA SIDO RECHAZADO.
        /// </summary>
        internal static string RechazadoTitulo {
            get {
                return ResourceManager.GetString("RechazadoTitulo", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to No llegaste al monto mínimo.
        /// </summary>
        internal static string StockMontoMinimo {
            get {
                return ResourceManager.GetString("StockMontoMinimo", resourceCulture);
            }
        }
    }
}
