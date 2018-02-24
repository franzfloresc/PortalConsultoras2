(function () {
    ko.bindingHandlers.upLoader = {
        init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
            uploadFilePalanca(element, valueAccessor, bindingContext.$root.settings().rutaFileUpload);
        }
    };

    function uploadFilePalanca(element, observableProp, rutaFileUpload) {
        new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: element,
            action: rutaFileUpload,
            onComplete: function (id, fileName, responseJSON) {
                if (checkTimeout(responseJSON)) {
                    if (responseJSON.success) {
                        var value = observableProp();
                        value(responseJSON.name);
                    }
                    else fail(responseJSON.message);
                }
            },
            onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
            onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
        });

        return false;
    }

    function getPropertyName(elementObservable) {
        var dataBind = elementObservable.attributes['data-bind'].nodeValue;
        return dataBind.substring(dataBind.indexOf(":") + 1).trim();
    }
})();

