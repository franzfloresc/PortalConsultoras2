//depende de jquery.paging
var Paginador = function (config) {
    var _config = {
        elementId: config.elementId || '',
        elementClick: config.elementClick
    };

    var _elementClick = function (ev) {
        ev.preventDefault();
        var page = $(this).data('page');
        pager.setPage(page);
        waitingDialog({});

        if (_config.elementClick) {
            _config.elementClick(page);
        }
    };

    var _onFormat = function (type) {
        switch (type) {
            case 'block': // n and c
                return '<div class="item"><a href="#">' + this.value + '</a></div>';
            case 'next': // >
                return '<div class="item"><a href= "#">&gt;</a></div>';
            case 'prev': // <
                return '<div class="item"><a href="#">&lt;</a></div>';
            case 'first': // [
                return '<div class="item"><a href="#">&lt;&lt;</a></div>';
            case 'last': // ]
                return '<div class="item"><a href="#">&gt;&gt;</a></div>';
        }
    };

    var _paginar = function (numRegistros) {
        $("#" + _config.elementId).paging(numRegistros, {
            format: '[< ncnnn >]',
            onClick: _elementClick,
            onFormat: _onFormat
        });
    }

    return {
        paginar: _paginar
    };
}