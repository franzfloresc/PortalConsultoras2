(function () {
    ko.bindingHandlers.upLoader = {
        init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
            uploadFilePalanca(element, valueAccessor, bindingContext.$root.settings().rutaFileUpload);
        }
    };

    ko.bindingHandlers.fadeVisible = {
        init: function (element, valueAccessor) {
            var shouldDisplay = valueAccessor();
            $(element).toggle(shouldDisplay);
        },
        update: function (element, valueAccessor) {
            var shouldDisplay = valueAccessor();
            shouldDisplay ? $(element).fadeIn(1000) : $(element).fadeOut(1000);
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
})();

