var _switch = '.toggle-switch'
var _switchControl = '.toggle-header'
var _profit = '.toggle-content'
var _earning = '.ganancia-estimada'
if ($(_switchControl).length > 0) {
    document.querySelector(_switchControl).addEventListener('click', function () {
        toggle(_switch)
    })
}


var toggle = function (_switch) {
    // Activa la animación del + a - y viceversa
    document.querySelector(_switch).classList.toggle('opened')
    // Activa la informacion
    document.querySelector(_profit).classList.toggle('opened')
    document.querySelector(_earning).classList.toggle('opened')


}

var isToggleOpen = function (_switch) {
    var _isOpen = document.querySelector(_switch).classList.contains('opened')
    return _isOpen
}