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
    internal class PedidoInsertMessages {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal PedidoInsertMessages() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Portal.Consultoras.BizLogic.Resources.PedidoInsertMessages", typeof(PedidoInsertMessages).Assembly);
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
        ///   Looks up a localized string similar to El producto solicitado no existe..
        /// </summary>
        internal static string ValidacionProductoByCUVNoEncontrado {
            get {
                return ResourceManager.GetString("ValidacionProductoByCUVNoEncontrado", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to La cantidad solicitada sobrepasa el máximo de Unidades Permitidas de Venta({0}) del producto.
        /// </summary>
        internal static string ValidacionUnidadesPermitidas {
            get {
                return ResourceManager.GetString("ValidacionUnidadesPermitidas", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to La cantidad solicitada sobrepasa el máximo de Unidades Permitidas de Venta({0}) del producto.
        /// </summary>
        internal static string ValidacionUnidadesPermitidasSaldoCero {
            get {
                return ResourceManager.GetString("ValidacionUnidadesPermitidasSaldoCero", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Sólo puedes adicionar ({0}), ya que el máximo de Unidades Permitidas de Venta del producto es {1}.
        /// </summary>
        internal static string ValidacionUnidadesPermitidasSaldoPermitido {
            get {
                return ResourceManager.GetString("ValidacionUnidadesPermitidasSaldoPermitido", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to La cantidad solicitada sobrepasa el stock actual({0}) del producto.
        /// </summary>
        internal static string ValidacionUnidadesPermitidasStockSobrepasado {
            get {
                return ResourceManager.GetString("ValidacionUnidadesPermitidasStockSobrepasado", resourceCulture);
            }
        }
    }
}