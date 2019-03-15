$(document).ready(function () {
    var _nivel = 5;
    $("#indicadorNivel").addClass("medal-" + _nivel);
    for (var i = 1; i <= _nivel; i++)
        $(".pt" + i).addClass("activo");
    $(".pt" + _nivel).addClass("brillante");
});