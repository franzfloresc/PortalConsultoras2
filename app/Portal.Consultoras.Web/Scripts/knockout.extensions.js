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

    ko.bindingHandlers.imageSize = {
        init: function (element, options) {
            if (options().show) {
                $(element).on('load', function () {
                    var x = element.naturalWidth;
                    var y = element.naturalHeight;

                    if (!x || !y || x === 0 || y === 0)
                        return;

                    element.setAttribute(options().attr, x + ' x ' + y);
                });
            }
        }
    }

    ko.extenders.trackChange = function (target, options) {
        if (options.track) {
            target.isDirty = ko.observable(false);
            var valueOfTarget = target()
            target.originalValue = options.isArray ? ko.toJSON(valueOfTarget) : valueOfTarget;
            target.setOriginalValue = function (startingValue) {
                target.originalValue = options.isArray ? ko.toJSON(startingValue) : startingValue;
                target.isDirty(false);
            }
            target.setCurrentValueAsOriginal = function () {
                target.setOriginalValue(target())
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

    ko.extenders.required = function (target, overrideMessage) {
        //add some sub-observables to our observable
        target.hasError = ko.observable();
        target.validationMessage = ko.observable();

        //define a function to do validation
        function validate(newValue) {
            target.hasError(newValue ? false : true);
            target.validationMessage(newValue ? "" : overrideMessage || "This field is required");
        }

        //initial validation
        validate(target());

        //validate whenever the value changes
        target.subscribe(validate);

        //return the original observable
        return target;
    };

    ko.extenders.viewModelHasError = function (target, overrideMessage) {
        var keys = Object.keys(target);
        if (!keys || !(keys.length > 0))
            return false;

        var invalidProperties = keys.filter(function (key) {
            return (selfm.hasOwnProperty(key) && ko.isObservable(selfm[key]) && typeof selfm[key].hasError === 'function' && selfm[key].hasError());
        });

        return invalidProperties.length == 0;

        //return the original observable
        return target;
    };

    function uploadFile(element, observableProp, urlFileUpload) {
        new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
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

