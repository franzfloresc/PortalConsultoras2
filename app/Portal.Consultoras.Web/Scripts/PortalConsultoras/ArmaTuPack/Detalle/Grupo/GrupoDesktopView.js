var GrupoDesktopView = function () {

    var _config = {

    };

    var _grupos = null;
    var _renderGrupos = function(grupos) {
        if(typeof grupos === undefined){
            return _grupos;
        }else{
            //todo:implement render method.
        }
    };

    return {
        renderGrupos : _renderGrupos,
    };
};