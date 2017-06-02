//depende de jquery.toast.min.js
var ToastHelper = function () {
    var _show = function (opts) {
        $.toast(opts);
    };

    var _error = function (message) {
        $.toast({
            heading: 'Error',
            text: message,
            showHideTransition: 'fade',
            position: 'top-right',
            hideAfter: 2000,
            loader: false,
            icon: 'error',
            stack: false
        });
    };

    var _success = function (message) {
        $.toast({
            heading: 'success',
            text: message,
            showHideTransition: 'fade',
            position: 'top-right',
            hideAfter: 2000,
            loader: false,
            icon: 'success',
            stack: false
        });
    };

    return {
        show: _show,
        error: _error,
        success: _success
    }
};