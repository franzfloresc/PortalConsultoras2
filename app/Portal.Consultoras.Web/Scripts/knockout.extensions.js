"use strict";

(function () {
    /*options:
    {
        valueAccessor: --observable
        url: 'urlToUpload'
    }*/
    ko.bindingHandlers.upLoader = {
        init: function (element, options, allBindingsAccessor, viewModel, bindingContext) {
            uploadFile(element, options().valueAccessor, options().url);
        }
    };

    ko.bindingHandlers.fadeVisible = {
        init: function (element, valueAccessor) {
            var shouldDisplay = valueAccessor();
            $(element).toggle(shouldDisplay);
        },
        update: function (element, valueAccessor) {
            var shouldDisplay = valueAccessor();
            shouldDisplay ? $(element).fadeIn(600) : $(element).fadeOut(400);
        }
    };

    ko.extenders.trackChange = function (target, options) {
        if (options.track) {
            target.isDirty = ko.observable(false);
            var valueOfTarget = target()
            target.originalValue = options.isArray ? ko.toJSON(valueOfTarget) : valueOfTarget;
            target.setOriginalValue = function (startingValue) {
                target.originalValue = options.isArray ? ko.toJSON(startingValue) : startingValue;
                target.isDirty(false);
            }
            target.subscribe(function (newValue) {
                var invariantNewValue = options.isArray ? ko.toJSON(newValue) : newValue;

                var isDirty = !(invariantNewValue >= target.originalValue && invariantNewValue <= target.originalValue);
                if (options.cb) {
                    //console.log("type : " + typeof target.originalValue + " =>: " + typeof newValue);
                    //console.log("value : " + target.originalValue + " =>: " + invariantNewValue);
                    options.cb(isDirty);
                }


                target.isDirty(isDirty);
            });
            //note: not work for Array
            target.undoChanges = function () {
                target(target.originalValue);
                target.isDirty(false);
            }
        }

        return target;
    }

    function uploadFile(element, observableProp, urlFileUpload) {
        new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: element,
            action: urlFileUpload,
            onComplete: function (id, fileName, responseJSON) {
                if (checkTimeout(responseJSON)) {
                    if (responseJSON.success) {
                        observableProp(responseJSON.name);
                    }
                    else fail(responseJSON.message);
                }
            },
            onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
            onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
        });
    }
})();

