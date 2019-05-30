var _switch = '.toggle-switch'
var _profit = '.toggle-content'
document.querySelector(_switch).addEventListener('click', function () {
    toggle(_switch)
})

var toggle = function (_switch) {
    // Activa la animación del + a - y viceversa
    document.querySelector(_switch).classList.toggle('opened')
    // Activa la informacion
    document.querySelector(_profit).classList.toggle('opened')


}

var isToggleOpen = function (_switch) {
    var _isOpen = document.querySelector(_switch).classList.contains('opened')
    return _isOpen
}