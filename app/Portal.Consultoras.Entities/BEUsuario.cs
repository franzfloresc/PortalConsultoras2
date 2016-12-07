using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuario
    {
        private string msCodigoConsultora;
        private string msCodigoUsuario;
        private int miPaisID;
        private string msNombre;
        private string msClaveSecreta;
        private string msActualizarClave;
        private string msConfirmarClave;
        private string msEMail;
        private bool mbEMailActivo;
        private string msTelefono;
        private string msTelefonoTrabajo;
        private string msCelular;
        private string msSobrenombre;
        private bool mbCompartirDatos;
        private bool mbActivo;
        private byte miTipoUsuario;
        private bool mbCambioClave;
        //Campos dispuestos para la sesión de Usuario
        private string msCodigoISO;
        private int miRegionID;
        private string msCodigorRegion;
        private int miZonaID;
        private string msCodigoZona;
        private long miConsultoraID;
        private short miRolID;
        private int miCampaniaID;
        private DateTime mdFechaInicioFacturacion;
        private DateTime mdFechaFinFacturacion;
        private DateTime mdFechaFinFIC;//1501
        private string msCampaniaDescripcion;
        private TimeSpan tsHoraInicio;
        private TimeSpan tsHoraFin;
        private bool mbZonaValida;
        private string msSimbolo;
        private int miTerritorioID;
        private string msCodigoTerritorio;
        private decimal mmMontoMinimoPedido;
        private decimal mmMontoMaximoPedido;
        private TimeSpan tsHoraInicioNoFacturable;
        private TimeSpan tsHoraCierreNoFacturable;
        private int miDiasAntes;
        private string mCodigoFuente;
        private string mBanderaImagen;
        private string mNombrePais;
        private int mConsultoraNueva;
        private string mSegmento;
        private int miDiasDuracionCronograma;
        private bool mHabilitarRestriccionHoraria;
        private string mAnoCampaniaIngreso;
        private string mPrimerNombre;
        private string mPrimerApellido;
        private int mHorasDuracionRestriccion;
        private bool mostrarAyudaWebTraking;
        private bool mPROLSinStock; //1510
        private DateTime mdFechaModificacion;
        private string mdRol;
        private string mSegmentoConstancia;//R2469(CSR)
        private string mSeccionAnalytics;//R2469(CSR)
        private string mDescripcionNivel; //R2469(CSR)
        private bool mesConsultoraLider;//R2469(CSR)
        private bool bEstadoSimplificacionCUV { get; set; }
        private bool bEsquemaDAConsultora;
        private int digitoVerificador;

        public BEUsuario()
        {
        }

        public BEUsuario(IDataRecord row)
        {
            msCodigoConsultora = row["CodigoConsultora"].ToString();
            msCodigoUsuario = row["CodigoUsuario"].ToString();
            miPaisID = Convert.ToInt32(row["PaisID"]);
            msNombre = row["Nombre"].ToString();
            msClaveSecreta = row["ClaveSecreta"].ToString();
            msEMail = row["EMail"].ToString();
            mbEMailActivo = Convert.ToBoolean(row["EMailActivo"]);
            msTelefono = row["Telefono"].ToString();
            msCelular = row["Celular"].ToString();
            msSobrenombre = row["Sobrenombre"].ToString();
            mbCompartirDatos = Convert.ToBoolean(row["CompartirDatos"]);
            mbActivo = Convert.ToBoolean(row["Activo"]);
            miTipoUsuario = (byte)row["TipoUsuario"];
            mbCambioClave = Convert.ToBoolean(row["CambioClave"]);

            if (DataRecord.HasColumn(row, "TelefonoTrabajo") && row["TelefonoTrabajo"] != DBNull.Value)
                msTelefonoTrabajo = Convert.ToString(row["TelefonoTrabajo"]);
            if (DataRecord.HasColumn(row, "AceptoContrato") && row["AceptoContrato"] != DBNull.Value)
                this.AceptoContrato = Convert.ToBoolean(row["AceptoContrato"]);
            if (DataRecord.HasColumn(row, "MostrarAyudaWebTraking") && row["MostrarAyudaWebTraking"] != DBNull.Value)
                MostrarAyudaWebTraking = Convert.ToBoolean(row["MostrarAyudaWebTraking"]);
            if (DataRecord.HasColumn(row, "CodigoISO") && row["CodigoISO"] != DBNull.Value)
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "NombrePais") && row["NombrePais"] != DBNull.Value)
                NombrePais = Convert.ToString(row["NombrePais"]);
            if (DataRecord.HasColumn(row, "RolID") && row["RolID"] != DBNull.Value)
                RolID = Convert.ToByte(row["RolID"]);
            if (DataRecord.HasColumn(row, "BanderaImagen") && row["BanderaImagen"] != DBNull.Value)
                BanderaImagen = Convert.ToString(row["BanderaImagen"]);
            if (DataRecord.HasColumn(row, "Simbolo") && row["Simbolo"] != DBNull.Value)
                msSimbolo = Convert.ToString(row["Simbolo"]);
            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "Rol") && row["Rol"] != DBNull.Value)
                Rol = Convert.ToString(row["Rol"]);
            /* 2155 - Inicio */
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"].ToString());
            /* 2155 - Fin */
            /*2469 - Inicio */
            if (DataRecord.HasColumn(row, "SegmentoConstancia") && row["SegmentoConstancia"] != DBNull.Value)
                SegmentoConstancia = Convert.ToString(row["SegmentoConstancia"]);
            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                SeccionAnalytics = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "DescripcionNivel") && row["DescripcionNivel"] != DBNull.Value)
                DescripcionNivel = Convert.ToString(row["DescripcionNivel"]);
            if (DataRecord.HasColumn(row, "esConsultoraLider") && row["esConsultoraLider"] != DBNull.Value)//1485
                esConsultoraLider = Convert.ToBoolean(row["esConsultoraLider"]); // Correccion 2469
            /* 2469 - Fin*/

            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV") && row["EstadoSimplificacionCUV"] != DBNull.Value)
                bEstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]); /*R20150701*/
            if (DataRecord.HasColumn(row, "EsquemaDAConsultora") && row["EsquemaDAConsultora"] != DBNull.Value)
                bEsquemaDAConsultora = Convert.ToBoolean(row["EsquemaDAConsultora"]);
            /*EPD-1068*/
            if (DataRecord.HasColumn(row, "DigitoVerificador") && row["DigitoVerificador"] != DBNull.Value)
                digitoVerificador = Convert.ToInt32(row["DigitoVerificador"]);


        }

        public BEUsuario(IDataRecord row, bool Tipo)
        {
            miPaisID = Convert.ToInt32(row["PaisID"]);
            msCodigoISO = Convert.ToString(row["CodigoISO"]);
            miRegionID = row["RegionID"] == DBNull.Value ? 0 : Convert.ToInt32(row["RegionID"]);
            msCodigorRegion = Convert.ToString(row["CodigorRegion"]);
            miZonaID = row["ZonaID"] == DBNull.Value ? 0 : Convert.ToInt32(row["ZonaID"]);
            msCodigoZona = Convert.ToString(row["CodigoZona"]);
            miConsultoraID = row["ConsultoraID"] == DBNull.Value ? 0 : Convert.ToInt64(row["ConsultoraID"]);
            msCodigoConsultora = row["CodigoConsultora"].ToString();
            msCodigoUsuario = row["CodigoUsuario"].ToString();
            msNombre = Convert.ToString(row["NombreCompleto"]);
            miRolID = Convert.ToInt16(row["RolID"]);
            msEMail = Convert.ToString(row["EMail"]);
            msSimbolo = Convert.ToString(row["Simbolo"]);
            miTerritorioID = row["TerritorioID"] == DBNull.Value ? 0 : Convert.ToInt32(row["TerritorioID"]);
            msCodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
            mmMontoMinimoPedido = row["MontoMinimoPedido"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoMinimoPedido"]);
            mmMontoMaximoPedido = row["MontoMaximoPedido"] == DBNull.Value ? 0 : Convert.ToDecimal(row["MontoMaximoPedido"]);
            mBanderaImagen = Convert.ToString(row["BanderaImagen"]);
            mCodigoFuente = Convert.ToString(row["CodigoFuente"]);
            mNombrePais = Convert.ToString(row["NombrePais"]);
            mbCambioClave = Convert.ToBoolean(row["CambioClave"]);
            mConsultoraNueva = Convert.ToInt32(row["ConsultoraNueva"]);
            msCodigoUsuario = row["CodigoUsuario"].ToString();
            msTelefono = Convert.ToString(row["Telefono"]);
            msCelular = Convert.ToString(row["Celular"]);
            mSegmento = Convert.ToString(row["Segmento"]);
            msSobrenombre = Convert.ToString(row["Sobrenombre"]) == string.Empty ? Convert.ToString(row["PrimerNombre"]) : Convert.ToString(row["Sobrenombre"]);
            //EMailActivo = Convert.ToBoolean(row["EMailActivo"]);//2532 EGL

            if (DataRecord.HasColumn(row, "IndicadorDupla") && row["IndicadorDupla"] != DBNull.Value)
                IndicadorDupla = Convert.ToInt32(row["IndicadorDupla"]);
            if (DataRecord.HasColumn(row, "UsuarioPrueba") && row["UsuarioPrueba"] != DBNull.Value)
                UsuarioPrueba = Convert.ToInt32(row["UsuarioPrueba"]);
            if (DataRecord.HasColumn(row, "PasePedidoWeb") && row["PasePedidoWeb"] != DBNull.Value)
                PasePedidoWeb = Convert.ToInt32(row["PasePedidoWeb"]);
            if (DataRecord.HasColumn(row, "TipoOferta2") && row["TipoOferta2"] != DBNull.Value)
                TipoOferta2 = Convert.ToInt32(row["TipoOferta2"]);
            if (DataRecord.HasColumn(row, "CompraKitDupla") && row["CompraKitDupla"] != DBNull.Value)
                CompraKitDupla = Convert.ToInt32(row["CompraKitDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaDupla") && row["CompraOfertaDupla"] != DBNull.Value)
                CompraOfertaDupla = Convert.ToInt32(row["CompraOfertaDupla"]);
            if (DataRecord.HasColumn(row, "CompraOfertaEspecial") && row["CompraOfertaEspecial"] != DBNull.Value)
                CompraOfertaEspecial = Convert.ToInt32(row["CompraOfertaEspecial"]);
            if (DataRecord.HasColumn(row, "IndicadorMeta") && row["IndicadorMeta"] != DBNull.Value)
                IndicadorMeta = Convert.ToInt32(row["IndicadorMeta"]);
            if (DataRecord.HasColumn(row, "ProgramaReconocimiento") && row["ProgramaReconocimiento"] != DBNull.Value)
                ProgramaReconocimiento = Convert.ToInt32(row["ProgramaReconocimiento"]);
            if (DataRecord.HasColumn(row, "NivelEducacion") && row["NivelEducacion"] != DBNull.Value)
                NivelEducacion = Convert.ToInt32(row["NivelEducacion"]);
            if (DataRecord.HasColumn(row, "SegmentoID") && row["SegmentoID"] != DBNull.Value)
                SegmentoID = Convert.ToInt32(row["SegmentoID"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento") && row["FechaNacimiento"] != DBNull.Value)
                FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "FechaLimitePago") && row["FechaLimitePago"] != DBNull.Value)
                FechaLimPago = Convert.ToDateTime(row["FechaLimitePago"]);
            if (DataRecord.HasColumn(row, "VioVideo") && row["VioVideo"] != DBNull.Value) // SB20-344
                VioVideo = Convert.ToInt32(row["VioVideo"]);
            if (DataRecord.HasColumn(row, "VioTutorial") && row["VioTutorial"] != DBNull.Value) // SB20-344
                VioTutorial = Convert.ToInt32(row["VioTutorial"]);
            if (DataRecord.HasColumn(row, "VioTutorialDesktop") && row["VioTutorialDesktop"] != DBNull.Value)
                VioTutorialDesktop = Convert.ToInt32(row["VioTutorialDesktop"]);
            if (DataRecord.HasColumn(row, "Nivel") && row["Nivel"] != DBNull.Value)
                Nivel = Convert.ToString(row["Nivel"]);
            if (DataRecord.HasColumn(row, "Direccion") && row["Direccion"] != DBNull.Value)
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "TelefonoTrabajo") && row["TelefonoTrabajo"] != DBNull.Value)
                msTelefonoTrabajo = Convert.ToString(row["TelefonoTrabajo"]);
            if (DataRecord.HasColumn(row, "AnoCampanaIngreso") && row["AnoCampanaIngreso"] != DBNull.Value)
                AnoCampaniaIngreso = Convert.ToString(row["AnoCampanaIngreso"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "PrimerApellido") && row["PrimerApellido"] != DBNull.Value)
                PrimerApellido = Convert.ToString(row["PrimerApellido"]);
            if (DataRecord.HasColumn(row, "IndicadorFlexiPago") && row["IndicadorFlexiPago"] != DBNull.Value)
                IndicadorFlexiPago = Convert.ToInt32(row["IndicadorFlexiPago"]);
            if (DataRecord.HasColumn(row, "IndicadorPermisoFIC") && row["IndicadorPermisoFIC"] != DBNull.Value)
                IndicadorPermisoFIC = Convert.ToInt32(row["IndicadorPermisoFIC"]);
            else
                IndicadorPermisoFIC = 0;
            if (DataRecord.HasColumn(row, "MostrarAyudaWebTraking") && row["MostrarAyudaWebTraking"] != DBNull.Value)
                MostrarAyudaWebTraking = Convert.ToBoolean(row["MostrarAyudaWebTraking"]);
            if (DataRecord.HasColumn(row, "RolDescripcion") && row["RolDescripcion"] != DBNull.Value)
                RolDescripcion = Convert.ToString(row["RolDescripcion"]);
            if (DataRecord.HasColumn(row, "IndicadorOfertaFIC") && row["IndicadorOfertaFIC"] != DBNull.Value)//SSAP CGI(Id Solicitud=1402) begin
                IndicadorOfertaFIC = Convert.ToInt32(row["IndicadorOfertaFIC"]);
            else
                IndicadorOfertaFIC = 0;
            if (DataRecord.HasColumn(row, "ImagenUrlOfertaFIC") && row["ImagenUrlOfertaFIC"] != DBNull.Value)
                ImagenURLOfertaFIC = Convert.ToString(row["ImagenUrlOfertaFIC"]);
            else
                ImagenURLOfertaFIC = string.Empty;//SSAP CGI(Id Solicitud=1402)end

            if (DataRecord.HasColumn(row, "NroCampanias") && row["NroCampanias"] != DBNull.Value)//SSAP CGI(Id Solicitud=1402) begin
                NroCampanias = Convert.ToInt32(row["NroCampanias"]);
            else
                NroCampanias = 0;

            if (DataRecord.HasColumn(row, "Lider") && row["Lider"] != DBNull.Value)//1485
                Lider = Convert.ToInt32(row["Lider"]);
            else
                Lider = 0;

            if (DataRecord.HasColumn(row, "ConsultoraAsociada") && row["ConsultoraAsociada"] != DBNull.Value)//1688
                ConsultoraAsociada = Convert.ToString(row["ConsultoraAsociada"]);
            else
                ConsultoraAsociada = string.Empty;

            if (DataRecord.HasColumn(row, "CampaniaInicioLider") && row["CampaniaInicioLider"] != DBNull.Value)//1485
                CampaniaInicioLider = Convert.ToString(row["CampaniaInicioLider"]);
            else
                CampaniaInicioLider = string.Empty;

            if (DataRecord.HasColumn(row, "SeccionGestionLider") && row["SeccionGestionLider"] != DBNull.Value)//1485
                SeccionGestionLider = Convert.ToString(row["SeccionGestionLider"]);
            else
                SeccionGestionLider = string.Empty;


            if (DataRecord.HasColumn(row, "NivelLider") && row["NivelLider"] != DBNull.Value)//1485
                NivelLider = Convert.ToInt32(row["NivelLider"]);
            else
                NivelLider = 0;

            if (DataRecord.HasColumn(row, "PortalLideres") && row["PortalLideres"] != DBNull.Value)//1485
                PortalLideres = Convert.ToBoolean(row["PortalLideres"]);
            else
                PortalLideres = false;

            if (DataRecord.HasColumn(row, "LogoLideres") && row["LogoLideres"] != DBNull.Value)//1485
                LogoLideres = Convert.ToString(row["LogoLideres"]);
            else
                LogoLideres = string.Empty;

            if (DataRecord.HasColumn(row, "IndicadorContrato") && row["IndicadorContrato"] != DBNull.Value)//1485
                IndicadorContrato = Convert.ToInt32(row["IndicadorContrato"]);
            else
                IndicadorContrato = 0;

            if (DataRecord.HasColumn(row, "EsJoven") && row["EsJoven"] != DBNull.Value)//1530
                EsJoven = Convert.ToInt32(row["EsJoven"]);

            if (DataRecord.HasColumn(row, "CodigoISO") && row["CodigoISO"] != DBNull.Value)
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "NombrePais") && row["NombrePais"] != DBNull.Value)
                NombrePais = Convert.ToString(row["NombrePais"]);
            if (DataRecord.HasColumn(row, "RolID") && row["RolID"] != DBNull.Value)
                RolID = Convert.ToByte(row["RolID"]);
            if (DataRecord.HasColumn(row, "BanderaImagen") && row["BanderaImagen"] != DBNull.Value)
                BanderaImagen = Convert.ToString(row["BanderaImagen"]);
            if (DataRecord.HasColumn(row, "Simbolo") && row["Simbolo"] != DBNull.Value)
                msSimbolo = Convert.ToString(row["Simbolo"]);

            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "Rol") && row["Rol"] != DBNull.Value)
                Rol = Convert.ToString(row["Rol"]);
            //1796
            if (DataRecord.HasColumn(row, "CampanaInvitada") && row["CampanaInvitada"] != DBNull.Value)
                CampanaInvitada = Convert.ToString(row["CampanaInvitada"]);
            if (DataRecord.HasColumn(row, "InscritaFlexipago") && row["InscritaFlexipago"] != DBNull.Value)
                InscritaFlexipago = Convert.ToString(row["InscritaFlexipago"]);
            if (DataRecord.HasColumn(row, "InvitacionRechazada") && row["InvitacionRechazada"] != DBNull.Value)
                InvitacionRechazada = Convert.ToString(row["InvitacionRechazada"]);
            //1796 Fin
            //R2469
            if (DataRecord.HasColumn(row, "SegmentoConstancia") && row["SegmentoConstancia"] != DBNull.Value)
                SegmentoConstancia = Convert.ToString(row["SegmentoConstancia"]);
            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                SeccionAnalytics = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "DescripcionNivel") && row["DescripcionNivel"] != DBNull.Value)
                DescripcionNivel = Convert.ToString(row["DescripcionNivel"]);
            if (DataRecord.HasColumn(row, "esConsultoraLider") && row["esConsultoraLider"] != DBNull.Value)//1485
                esConsultoraLider = Convert.ToBoolean(row["esConsultoraLider"]); // Correccion 2469
            //2469 Fin
            if (DataRecord.HasColumn(row, "EMailActivo") && row["EMailActivo"] != DBNull.Value)//2532
                EMailActivo = Convert.ToBoolean(row["EMailActivo"]);
            /*RE2544 - CS*/
            if (DataRecord.HasColumn(row, "SegmentoInternoId") && row["SegmentoInternoId"] != DBNull.Value)
                SegmentoInternoID = Convert.ToInt32(row["SegmentoInternoId"]);

            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV") && row["EstadoSimplificacionCUV"] != DBNull.Value)
                EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]); /*R20150701*/
            if (DataRecord.HasColumn(row, "EsquemaDAConsultora") && row["EsquemaDAConsultora"] != DBNull.Value)
                bEsquemaDAConsultora = Convert.ToBoolean(row["EsquemaDAConsultora"]);
            if (DataRecord.HasColumn(row, "OfertaFinal") && row["OfertaFinal"] != DBNull.Value)
                OfertaFinal = Convert.ToInt32(row["OfertaFinal"]);
            if (DataRecord.HasColumn(row, "EsOfertaFinalZonaValida") && row["EsOfertaFinalZonaValida"] != DBNull.Value)
                EsOfertaFinalZonaValida = Convert.ToBoolean(row["EsOfertaFinalZonaValida"]);

            if (DataRecord.HasColumn(row, "OfertaFinalGanaMas") && row["OfertaFinalGanaMas"] != DBNull.Value)
                OfertaFinalGanaMas = Convert.ToInt32(row["OfertaFinalGanaMas"]);

            if (DataRecord.HasColumn(row, "EsOFGanaMasZonaValida") && row["EsOFGanaMasZonaValida"] != DBNull.Value)
                EsOFGanaMasZonaValida = Convert.ToBoolean(row["EsOFGanaMasZonaValida"]);

            if (DataRecord.HasColumn(row, "CatalogoPersonalizado") && row["CatalogoPersonalizado"] != DBNull.Value)
                CatalogoPersonalizado = Convert.ToInt32(row["CatalogoPersonalizado"]);
            if (DataRecord.HasColumn(row, "EsCatalogoPersonalizadoZonaValida") && row["EsCatalogoPersonalizadoZonaValida"] != DBNull.Value)

                EsCatalogoPersonalizadoZonaValida = Convert.ToBoolean(row["EsCatalogoPersonalizadoZonaValida"]);
            if (DataRecord.HasColumn(row, "VioTutorialSalvavidas") && row["VioTutorialSalvavidas"] != DBNull.Value)
                VioTutorialSalvavidas = Convert.ToInt32(row["VioTutorialSalvavidas"]);
            if (DataRecord.HasColumn(row, "TieneHana") && row["TieneHana"] != DBNull.Value)
                TieneHana = Convert.ToInt32(row["TieneHana"]);
            if (DataRecord.HasColumn(row, "IndicadorBloqueoCDR") && row["IndicadorBloqueoCDR"] != DBNull.Value)
                IndicadorBloqueoCDR = Convert.ToInt32(row["IndicadorBloqueoCDR"]);
            
            if (DataRecord.HasColumn(row, "IndicadorEnviado") && row["IndicadorEnviado"] != DBNull.Value)
                IndicadorEnviado = Convert.ToInt32(row["IndicadorEnviado"]);
            if (DataRecord.HasColumn(row, "IndicadorRechazado") && row["IndicadorRechazado"] != DBNull.Value)
                IndicadorRechazado = Convert.ToInt32(row["IndicadorRechazado"]);

            // SB20-907
            if (DataRecord.HasColumn(row, "GerenteZona") && row["GerenteZona"] != DBNull.Value)
                NombreGerenteZona = Convert.ToString(row["GerenteZona"]);
            /*EPD-1068*/
            if (DataRecord.HasColumn(row, "DigitoVerificador") && row["DigitoVerificador"] != DBNull.Value)
                digitoVerificador = Convert.ToInt32(row["DigitoVerificador"]);

            

        }

        [DataMember]
        public string RolDescripcion { get; set; }
        [DataMember]
        public int NroCampanias { get; set; }
        [DataMember]
        public int IndicadorDupla { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaNormal { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAnti { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
        [DataMember]
        public int EsZonaDemAnti { get; set; }
        [DataMember]
        public int UsuarioPrueba { get; set; }
        [DataMember]
        public int PasePedidoWeb { get; set; }
        [DataMember]
        public int TipoOferta2 { get; set; }
        [DataMember]
        public int CompraKitDupla { get; set; }
        [DataMember]
        public int CompraOfertaDupla { get; set; }
        [DataMember]
        public int CompraOfertaEspecial { get; set; }
        [DataMember]
        public int IndicadorMeta { get; set; }
        [DataMember]
        public int ProgramaReconocimiento { get; set; }
        [DataMember]
        public int NivelEducacion { get; set; }
        [DataMember]
        public int SegmentoID { get; set; }
        [DataMember]
        public DateTime FechaNacimiento { get; set; }
        [DataMember]
        public DateTime FechaLimPago { get; set; }
        [DataMember]
        public int VioVideo { get; set; }
        [DataMember]
        public int VioTutorial { get; set; }
        [DataMember]
        public int VioTutorialDesktop { get; set; }
        [DataMember]
        public String Nivel { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public int IndicadorFlexiPago { get; set; }
        [DataMember]
        public int IndicadorPermisoFIC { get; set; }
        //1796
        [DataMember]
        public string CampanaInvitada { get; set; }
        [DataMember]
        public string InscritaFlexipago { get; set; }
        [DataMember]
        public string InvitacionRechazada { get; set; }
        //1796 fin
        [DataMember]
        public int EsJoven { get; set; }
        [DataMember] //R20151126
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; }//R20151126

        [DataMember]// R20150306
        public bool ValidacionInteractiva { get; set; } // R20150306
        [DataMember]// R20150306
        public string MensajeValidacionInteractiva { get; set; } // R20150306

        [DataMember]
        public int ConsultoraNueva
        {
            get { return mConsultoraNueva; }
            set { mConsultoraNueva = value; }
        }

        [DataMember]
        public string NombrePais
        {
            get { return mNombrePais; }
            set { mNombrePais = value; }
        }

        [DataMember]
        public string BanderaImagen
        {
            get { return mBanderaImagen; }
            set { mBanderaImagen = value; }
        }

        [DataMember]
        public string CodigoFuente
        {
            get { return mCodigoFuente; }
            set { mCodigoFuente = value; }
        }

        [DataMember]
        public string CodigoUsuario
        {
            get { return msCodigoUsuario; }
            set { msCodigoUsuario = value; }
        }

        [DataMember]
        public string CodigoConsultora
        {
            get { return msCodigoConsultora; }
            set { msCodigoConsultora = value; }
        }
        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
        [DataMember]
        public string Nombre
        {
            get { return msNombre; }
            set { msNombre = value; }
        }
        [DataMember]
        public string ClaveSecreta
        {
            get { return msClaveSecreta; }
            set { msClaveSecreta = value; }
        }
        [DataMember]
        public string ActualizarClave
        {
            get { return msActualizarClave; }
            set { msActualizarClave = value; }
        }
        [DataMember]
        public string ConfirmarClave
        {
            get { return msConfirmarClave; }
            set { msConfirmarClave = value; }
        }
        [DataMember]
        public string EMail
        {
            get { return msEMail; }
            set { msEMail = value; }
        }
        [DataMember]
        public bool EMailActivo
        {
            get { return mbEMailActivo; }
            set { mbEMailActivo = value; }
        }
        [DataMember]
        public string Telefono
        {
            get { return msTelefono; }
            set { msTelefono = value; }
        }
        [DataMember]
        public string TelefonoTrabajo
        {
            get { return msTelefonoTrabajo; }
            set { msTelefonoTrabajo = value; }
        }
        [DataMember]
        public string Celular
        {
            get { return msCelular; }
            set { msCelular = value; }
        }
        [DataMember]
        public string Sobrenombre
        {
            get { return msSobrenombre; }
            set { msSobrenombre = value; }
        }
        [DataMember]
        public bool CompartirDatos
        {
            get { return mbCompartirDatos; }
            set { mbCompartirDatos = value; }
        }
        [DataMember]
        public bool AceptoContrato { get; set; }
        [DataMember]
        public bool Activo
        {
            get { return mbActivo; }
            set { mbActivo = value; }
        }
        [DataMember]
        public byte TipoUsuario
        {
            get { return miTipoUsuario; }
            set { miTipoUsuario = value; }
        }
        [DataMember]
        public bool CambioClave
        {
            get { return mbCambioClave; }
            set { mbCambioClave = value; }
        }

        [DataMember]
        public string CodigoISO
        {
            get { return msCodigoISO; }
            set { msCodigoISO = value; }
        }

        [DataMember]
        public int RegionID
        {
            get { return miRegionID; }
            set { miRegionID = value; }
        }

        [DataMember]
        public string CodigorRegion
        {
            get { return msCodigorRegion; }
            set { msCodigorRegion = value; }
        }

        [DataMember]
        public int ZonaID
        {
            get { return miZonaID; }
            set { miZonaID = value; }
        }

        [DataMember]
        public string CodigoZona
        {
            get { return msCodigoZona; }
            set { msCodigoZona = value; }
        }

        [DataMember]
        public long ConsultoraID
        {
            get { return miConsultoraID; }
            set { miConsultoraID = value; }
        }

        [DataMember]
        public short RolID
        {
            get { return miRolID; }
            set { miRolID = value; }
        }

        [DataMember]
        public int CampaniaID
        {
            get { return miCampaniaID; }
            set { miCampaniaID = value; }
        }

        [DataMember]
        public DateTime FechaInicioFacturacion
        {
            get { return mdFechaInicioFacturacion; }
            set { mdFechaInicioFacturacion = value; }
        }

        [DataMember]
        public DateTime FechaFinFacturacion
        {
            get { return mdFechaFinFacturacion; }
            set { mdFechaFinFacturacion = value; }
        }

        [DataMember]
        public string CampaniaDescripcion
        {
            get { return msCampaniaDescripcion; }
            set { msCampaniaDescripcion = value; }
        }

        [DataMember]
        public TimeSpan HoraInicio
        {
            get { return tsHoraInicio; }
            set { tsHoraInicio = value; }
        }

        [DataMember]
        public TimeSpan HoraFin
        {
            get { return tsHoraFin; }
            set { tsHoraFin = value; }
        }

        [DataMember]
        public bool ZonaValida
        {
            get { return mbZonaValida; }
            set { mbZonaValida = value; }
        }

        [DataMember]
        public string Simbolo
        {
            get { return msSimbolo; }
            set { msSimbolo = value; }
        }

        [DataMember]
        public int TerritorioID
        {
            get { return miTerritorioID; }
            set { miTerritorioID = value; }
        }

        [DataMember]
        public string CodigoTerritorio
        {
            get { return msCodigoTerritorio; }
            set { msCodigoTerritorio = value; }
        }

        [DataMember]
        public decimal MontoMinimoPedido
        {
            get { return mmMontoMinimoPedido; }
            set { mmMontoMinimoPedido = value; }
        }

        [DataMember]
        public decimal MontoMaximoPedido
        {
            get { return mmMontoMaximoPedido; }
            set { mmMontoMaximoPedido = value; }
        }

        [DataMember]
        public TimeSpan HoraInicioNoFacturable
        {
            get { return tsHoraInicioNoFacturable; }
            set { tsHoraInicioNoFacturable = value; }
        }

        [DataMember]
        public TimeSpan HoraCierreNoFacturable
        {
            get { return tsHoraCierreNoFacturable; }
            set { tsHoraCierreNoFacturable = value; }
        }

        [DataMember]
        public int DiasAntes
        {
            get { return miDiasAntes; }
            set { miDiasAntes = value; }
        }

        [DataMember]
        public string Segmento
        {
            get { return mSegmento; }
            set { mSegmento = value; }
        }

        [DataMember]
        public int DiasDuracionCronograma
        {
            get { return miDiasDuracionCronograma; }
            set { miDiasDuracionCronograma = value; }
        }

        [DataMember]
        public bool HabilitarRestriccionHoraria
        {
            get { return mHabilitarRestriccionHoraria; }
            set { mHabilitarRestriccionHoraria = value; }
        }

        [DataMember]
        public int HorasDuracionRestriccion
        {
            get { return mHorasDuracionRestriccion; }
            set { mHorasDuracionRestriccion = value; }
        }

        [DataMember]
        public string AnoCampaniaIngreso
        {
            get { return mAnoCampaniaIngreso; }
            set { mAnoCampaniaIngreso = value; }
        }

        [DataMember]
        public string PrimerNombre
        {
            get { return mPrimerNombre; }
            set { mPrimerNombre = value; }
        }

        [DataMember]
        public string PrimerApellido
        {
            get { return mPrimerApellido; }
            set { mPrimerApellido = value; }
        }

        [DataMember]
        public bool MostrarAyudaWebTraking
        {
            get { return mostrarAyudaWebTraking; }
            set { mostrarAyudaWebTraking = value; }
        }
        [DataMember]
        public int IndicadorOfertaFIC { get; set; }//SSAP CGI(Id Solicitud=1402)

        [DataMember]
        public string ImagenURLOfertaFIC { get; set; }//SSAP CGI(Id Solicitud=1402)

        [DataMember]
        public int Lider { get; set; }

        [DataMember]
        public string ConsultoraAsociada { get; set; }

        [DataMember]
        public string CampaniaInicioLider { get; set; }

        [DataMember]
        public string SeccionGestionLider { get; set; }

        [DataMember]
        public int NivelLider { get; set; }

        [DataMember]
        public bool PortalLideres { get; set; }

        [DataMember]
        public string LogoLideres { get; set; }

        [DataMember]
        public int IndicadorContrato { get; set; }

        [DataMember]
        public DateTime FechaFinFIC
        {
            get { return mdFechaFinFIC; }
            set { mdFechaFinFIC = value; }
        }

        //1510
        [DataMember]
        public bool PROLSinStock
        {
            get { return mPROLSinStock; }
            set { mPROLSinStock = value; }
        }

        [DataMember]
        public DateTime FechaModificacion
        {
            get { return mdFechaModificacion; }
            set { mdFechaModificacion = value; }
        }

        [DataMember]
        public string Rol
        {
            get { return mdRol; }
            set { mdRol = value; }
        }

        //R2469 - CSR
        [DataMember]
        public string SegmentoConstancia
        {
            get { return mSegmentoConstancia; }
            set { mSegmentoConstancia = value; }
        }
        [DataMember]
        public string SeccionAnalytics
        {
            get { return mSeccionAnalytics; }
            set { mSeccionAnalytics = value; }
        }
        [DataMember]
        public string DescripcionNivel
        {
            get { return mDescripcionNivel; }
            set { mDescripcionNivel = value; }
        }
        [DataMember]
        public bool esConsultoraLider
        {
            get { return mesConsultoraLider; }
            set { mesConsultoraLider = value; }
        }
        [DataMember]
        public int DigitoVerificador
        {
            get { return digitoVerificador; }
            set { digitoVerificador = value; }
        }
        //RQ_NP - R2133
        [DataMember]
        public bool NuevoPROL { get; set; }

        //RQ_NP - R2133
        [DataMember]
        public bool ZonaNuevoPROL { get; set; }

        /* R2392 - AHAA - LIDERES - INICIO */
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string Pais { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public DateTime? FechaActualizacionEmail { get; set; }
        [DataMember]
        public DateTime? FechaActivacionSuscripcion { get; set; }
        [DataMember]
        public string FlagActivacionSuscripcion { get; set; }
        [DataMember]
        public DateTime? FechaCancelacionSuscripcion { get; set; }

        /*re2544 - cs*/
        [DataMember]
        public int? SegmentoInternoID
        {
            get;
            set;
        }

        [DataMember]
        public bool EstadoSimplificacionCUV
        {
            get { return bEstadoSimplificacionCUV; }
            set { bEstadoSimplificacionCUV = value; }
        } /*R20150701*/

        [DataMember]
        public bool EsquemaDAConsultora { get; set; }

        [DataMember]
        public int OfertaFinal { get; set; }

        [DataMember]
        public bool EsOfertaFinalZonaValida { get; set; }

        [DataMember]
        public int OfertaFinalGanaMas { get; set; }

        [DataMember]
        public bool EsOFGanaMasZonaValida { get; set; }

        [DataMember]
        public int CatalogoPersonalizado { get; set; }

        [DataMember]
        public bool EsCatalogoPersonalizadoZonaValida { get; set; }

        [DataMember]
        public int VioTutorialSalvavidas { get; set; }

        [DataMember]
        public int TieneHana { get; set; }

        [DataMember]
        public int IndicadorBloqueoCDR { get; set; }

        [DataMember]
        public decimal MontoDeuda { get; set; }

        [DataMember]
        public decimal MontoMinimoFlexipago { get; set; }

        public BEUsuario(IDataRecord row, string Lider)
        {
            if (DataRecord.HasColumn(row, "Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "DocIdentidad") && row["DocIdentidad"] != DBNull.Value)
                NumeroDocumento = Convert.ToString(row["DocIdentidad"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                Seccion = Convert.ToString(row["Seccion"]);

            if (DataRecord.HasColumn(row, "SeccionGestionLider") && row["SeccionGestionLider"] != DBNull.Value)
                SeccionGestionLider = Convert.ToString(row["SeccionGestionLider"]);

            if (DataRecord.HasColumn(row, "Telefono") && row["Telefono"] != DBNull.Value)
                Telefono = Convert.ToString(row["Telefono"]);

            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                Celular = Convert.ToString(row["Celular"]);

            if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
                EMail = Convert.ToString(row["Email"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Pais") && row["Pais"] != DBNull.Value)
                Pais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "Region") && row["Region"] != DBNull.Value)
                Region = Convert.ToString(row["Region"]);

            if (DataRecord.HasColumn(row, "Zona") && row["Zona"] != DBNull.Value)
                Zona = Convert.ToString(row["Zona"]);

            if (DataRecord.HasColumn(row, "FechaActualizacionEmail") && row["FechaActualizacionEmail"] != DBNull.Value)
                FechaActualizacionEmail = Convert.ToDateTime(row["FechaActualizacionEmail"]);

            if (DataRecord.HasColumn(row, "FechaActivacionSuscripcion") && row["FechaActivacionSuscripcion"] != DBNull.Value)
                FechaActivacionSuscripcion = Convert.ToDateTime(row["FechaActivacionSuscripcion"]);

            if (DataRecord.HasColumn(row, "FechaCancelacionSuscripcion") && row["FechaCancelacionSuscripcion"] != DBNull.Value)
                FechaCancelacionSuscripcion = Convert.ToDateTime(row["FechaCancelacionSuscripcion"]);

            if (DataRecord.HasColumn(row, "FlagActivacionSuscripcion") && row["FlagActivacionSuscripcion"] != DBNull.Value)
                FlagActivacionSuscripcion = Convert.ToString(row["FlagActivacionSuscripcion"]);
            //R2469
            if (DataRecord.HasColumn(row, "SegmentoConstancia") && row["SegmentoConstancia"] != DBNull.Value)
                SegmentoConstancia = Convert.ToString(row["SegmentoConstancia"]);
            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                SeccionAnalytics = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "DescripcionNivel") && row["DescripcionNivel"] != DBNull.Value)
                DescripcionNivel = Convert.ToString(row["DescripcionNivel"]);
            if (DataRecord.HasColumn(row, "esConsultoraLider") && row["esConsultoraLider"] != DBNull.Value)//1485
                esConsultoraLider = Convert.ToBoolean(row["esConsultoraLider"]); // Correccion 2469
            //2469 Fin
            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV") && row["EstadoSimplificacionCUV"] != DBNull.Value)
                EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]); /*R20150701*/

            if (DataRecord.HasColumn(row, "EsquemaDAConsultora") && row["EsquemaDAConsultora"] != DBNull.Value)
                bEsquemaDAConsultora = Convert.ToBoolean(row["EsquemaDAConsultora"]);
            /*EPD-1068*/
            if (DataRecord.HasColumn(row, "DigitoVerificador") && row["DigitoVerificador"] != DBNull.Value)
                digitoVerificador = Convert.ToInt32(row["DigitoVerificador"]);

        }
        /* R2392 - AHAA - LIDERES - FIN */

        /*R2520 - JICM - LIDERES - INI*/
        [DataMember]
        private string msSeccion { get; set; }
        [DataMember]
        private string msCampaniaEncuesta { get; set; }
        [DataMember]
        private DateTime mdFechaEncuesta { get; set; }
        [DataMember]
        private string msCampaniaIngreso { get; set; }
        [DataMember]
        private string msRpta1 { get; set; }
        [DataMember]
        private string msRpta2 { get; set; }
        [DataMember]
        private string msRpta3 { get; set; }
        [DataMember]
        private string msRpta4 { get; set; }

        [DataMember]
        public int IndicadorEnviado { get; set; }
        [DataMember]
        public int IndicadorRechazado { get; set; }
        [DataMember]
        public string NombreGerenteZona { get; set; }
        [DataMember]
        public DateTime FechaActualPais { get; set; }

        public BEUsuario(IDataRecord row, string tipo1, string tipo2)
        {
            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "Pais") && row["Pais"] != DBNull.Value)
                CodigoISO = Convert.ToString(row["Pais"]);
            if (DataRecord.HasColumn(row, "Region") && row["Region"] != DBNull.Value)
                Region = Convert.ToString(row["Region"]);
            if (DataRecord.HasColumn(row, "Zona") && row["Zona"] != DBNull.Value)
                Zona = Convert.ToString(row["Zona"]);
            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                msSeccion = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "CampaniaEncuesta") && row["CampaniaEncuesta"] != DBNull.Value)
                msCampaniaEncuesta = Convert.ToString(row["CampaniaEncuesta"]);
            if (DataRecord.HasColumn(row, "FechaRespuesta") && row["FechaRespuesta"] != DBNull.Value)
                mdFechaEncuesta = Convert.ToDateTime(row["FechaRespuesta"]);
            if (DataRecord.HasColumn(row, "CampaniaIngreso") && row["CampaniaIngreso"] != DBNull.Value)
                msCampaniaIngreso = Convert.ToString(row["CampaniaIngreso"]);  //R2520                
            if (DataRecord.HasColumn(row, "Rpta1") && row["Rpta1"] != DBNull.Value)
                msRpta1 = Convert.ToString(row["Rpta1"]);
            if (DataRecord.HasColumn(row, "Rpta2") && row["Rpta2"] != DBNull.Value)
                msRpta2 = Convert.ToString(row["Rpta2"]);
            if (DataRecord.HasColumn(row, "Rpta3") && row["Rpta3"] != DBNull.Value)
                msRpta3 = Convert.ToString(row["Rpta3"]);
            if (DataRecord.HasColumn(row, "Rpta4") && row["Rpta4"] != DBNull.Value)
                msRpta4 = Convert.ToString(row["Rpta4"]);
            if (DataRecord.HasColumn(row, "FechaActualPais"))
                FechaActualPais = Convert.ToDateTime(row["FechaActualPais"]);
        }
        /*R2520 - JICM - LIDERES - FIN*/
    }
}
