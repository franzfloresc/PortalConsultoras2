$(document).ready(function () {
    var model = get_local_storage("data_mas_vendidos");
    //var lista = data.lista;
});

function VerDetalleProductoMasVendidos(estrategiaId) {
    debugger;
    var model = get_local_storage("data_mas_vendidos");
    var lista = model.Lista;
    var item = null;

    $.each(lista,function(index, value) {
        if (value.EstrategiaID == estrategiaId) {
            item = value;
        }
    }); 

    $.ajax({
        type: 'POST',
        url: baseUrl + 'EstrategiaProducto/DetalleProducto',
        data: JSON.stringify(item),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function(data) {            
            model.Lista = ActualizarLista(lista, data);
            set_local_storage(model, "data_mas_vendidos");            
        },
        error: function(error) {
        }
    });
    location.href = baseUrl + 'EstrategiaProducto/DetalleProducto';
    //if (res == true) {
    //    debugger;
    //    window.location.href = '/EstrategiaProducto/DetalleProducto';        
    //}
}

function ActualizarLista(lista,item) {
    var temp = [];
    $.each(lista,function(index, value) {
        if (value.EstrategiaID == item.EstrategiaID) {
            temp.push(item);
        } else {
            temp.push(value);
        }
    });
    return temp;
}
