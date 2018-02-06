/// <reference path="loader.js" />

function isNullOrEmpty(element, index, array) {
    return element == null || element == "";
}

function IrAPaso() {
    var action = this.getAttribute('data-form-action');

    showLoader();
    $.post(action, $('form').serialize(), function (html) {
        $('#Formulario').hide();
        $('#Formulario').html(html);
        $('#Formulario').fadeIn(150);
    }).complete(function () {
        hideLoader();
    });
}

var paisID = 0;
$(function () {

    paisID = $('#ComboPais').val();
});