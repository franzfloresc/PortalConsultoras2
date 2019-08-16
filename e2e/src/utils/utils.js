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


module.exports.fnGetFiles = fnGetFiles;
