var TestHelpersModule = function(){
    
    var _getResolvedPromiseWithData = function (data) {
        var dfd = $.Deferred();
        dfd.resolve(data);
        return dfd.promise();
    };

    var _getRejectedPromiseWithData = function (data) {
        var dfd = $.Deferred();
        dfd.reject(data);
        return dfd.promise();
    };

    return {
        getResolvedPromiseWithData : _getResolvedPromiseWithData,
        getRejectedPromiseWithData : _getRejectedPromiseWithData
    };
}();