using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioExterno
    {
        private string _codigoUsuario;
        private string _proveedor;
        private string _idAplicacion;
        private string _login;
        private string _nombres;
        private string _apellidos;
        private string _fechaNacimiento;
        private string _correo;
        private string _genero;
        private string _ubicacion;
        private string _linkPerfil;
        private string _fotoPerfil;
        private DateTime _fechaRegistro;
        private int _estado;

        [DataMember]
        public string CodigoUsuario
        {
            get { return _codigoUsuario; }
            set { _codigoUsuario = value; }
        }

        [DataMember]
        public string Proveedor
        {
            get { return _proveedor; }
            set { _proveedor = value; }
        }

        [DataMember]
        public string IdAplicacion
        {
            get { return _idAplicacion; }
            set { _idAplicacion = value; }
        }

        [DataMember]
        public string Login
        {
            get { return _login; }
            set { _login = value; }
        }

        [DataMember]
        public string Nombres
        {
            get { return _nombres; }
            set { _nombres = value; }
        }

        [DataMember]
        public string Apellidos
        {
            get { return _apellidos; }
            set { _apellidos = value; }
        }

        [DataMember]
        public string FechaNacimiento
        {
            get { return _fechaNacimiento; }
            set { _fechaNacimiento = value; }
        }

        [DataMember]
        public string Correo
        {
            get { return _correo; }
            set { _correo = value; }
        }

        [DataMember]
        public string Genero
        {
            get { return _genero; }
            set { _genero = value; }
        }

        [DataMember]
        public string Ubicacion
        {
            get { return _ubicacion; }
            set { _ubicacion = value; }
        }

        [DataMember]
        public string LinkPerfil
        {
            get { return _linkPerfil; }
            set { _linkPerfil = value; }
        }

        [DataMember]
        public string FotoPerfil
        {
            get { return _fotoPerfil; }
            set { _fotoPerfil = value; }
        }

        [DataMember]
        public DateTime FechaRegistro
        {
            get { return _fechaRegistro; }
            set { _fechaRegistro = value; }
        }

        [DataMember]
        public int Estado
        {
            get { return _estado; }
            set { _estado = value; }
        }

        public BEUsuarioExterno()
        {
        }

        public BEUsuarioExterno(IDataRecord row)
        {
            _codigoUsuario = row["CodigoUsuario"].ToString();
            _proveedor = row["Proveedor"].ToString();
            _idAplicacion = row["IdAplicacion"].ToString();
            _login = row["Login"].ToString();

            if (DataRecord.HasColumn(row, "Nombres") && row["Nombres"] != DBNull.Value)
                _nombres = Convert.ToString(row["Nombres"]);
            if (DataRecord.HasColumn(row, "Apellidos") && row["Apellidos"] != DBNull.Value)
                _apellidos = Convert.ToString(row["Apellidos"]);
            if (DataRecord.HasColumn(row, "FechaNacimiento") && row["FechaNacimiento"] != DBNull.Value)
                _fechaNacimiento = Convert.ToString(row["FechaNacimiento"]);
            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                _correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "Genero") && row["Genero"] != DBNull.Value)
                _genero = Convert.ToString(row["Genero"]);
            if (DataRecord.HasColumn(row, "Ubicacion") && row["Ubicacion"] != DBNull.Value)
                _ubicacion = Convert.ToString(row["Ubicacion"]);
            if (DataRecord.HasColumn(row, "LinkPerfil") && row["LinkPerfil"] != DBNull.Value)
                _linkPerfil = Convert.ToString(row["LinkPerfil"]);
            if (DataRecord.HasColumn(row, "FotoPerfil") && row["FotoPerfil"] != DBNull.Value)
                _fotoPerfil = Convert.ToString(row["FotoPerfil"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                _fechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                _estado = Convert.ToInt16(row["Estado"]);

        }

    }
}
