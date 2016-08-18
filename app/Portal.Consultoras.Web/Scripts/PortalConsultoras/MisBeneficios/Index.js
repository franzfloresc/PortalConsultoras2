$(document).ready(function () {   
    CargarProgramasBelcorp();     
});

function CargarProgramasBelcorp() {
    $('#contenidoProgramasBelcorp').html('<div style="text-align: center;">Cargando Programas Belcorp<br><img src="' + urlLoad + '" /></div>');
    $.ajax({
        type: 'GET',
        url: baseUrl + 'MisBeneficios/GetJsonProgramasBelcorp',
        data: '',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (data.exito == true) {
                $.each(data.lista,
                    function(i, item) {
                        item.codigoISO = data.codigoISO;
                    });
                ArmarProgramasBelcorp(data.lista);
            }         
        },        
        error: function (data) {
            console.log(data);
        }
    });
};
function ArmarProgramasBelcorp(data) {
    data = EstructurarDataProgramasBelcorp(data);
    var htmlDiv = SetHandlebars("#ProgramasBelcorp-template", data);
    $('#contenidoProgramasBelcorp').empty().append(htmlDiv);
};
function EstructurarDataProgramasBelcorp(array) {
    return array;
};