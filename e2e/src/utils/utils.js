//const configLocator= require('./configLocator')
let fs = require("fs");

function fnGetFiles(dir, filter = "", files_) {
  files_ = files_ || [];
  var files = fs.readdirSync(dir);
  for (var i in files) {
    var name = dir + "/" + files[i];
    if (fs.statSync(name).isDirectory()) {
      fnGetFiles(name, filter, files_);
    } else if (name.indexOf(filter) >= 0) {
      files_.push(name);
    }
  }
  return files_;
}

function fechaFormateada(){

  var fecha=new Date().toLocaleString();
  var find='[: ]';
  var re=new RegExp(find,'g');
  fecha=fecha.replace(re,'-');

  return fecha;
}

function nomFichero(seccion){
  var nombre="";
  nombre=nombre.concat(seccion,"-", this.fechaFormateada(), ".png");

  return nombre;
}

module.exports.fnGetFiles = fnGetFiles;
module.exports.fechaFormateada=fechaFormateada;
module.exports.nomFichero=nomFichero;
