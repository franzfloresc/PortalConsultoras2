$(document).ready(function () {
    var _nivel = 6;
    var _medalla = (_nivel === 6) ? _nivel - 1 : _nivel;
    $("#indicadorNivel").addClass("medal-" + _medalla);
    for (var i = 1; i <= _nivel; i++)
        $(".pt" + i).addClass("activo");
    $(".pt" + _nivel).addClass("brillante");
});