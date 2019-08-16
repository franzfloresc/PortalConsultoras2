const utils = require("./../utils/utils");

let steps = utils.fnGetFiles("./src/features", ".steps.js");

module.exports = [...steps];
