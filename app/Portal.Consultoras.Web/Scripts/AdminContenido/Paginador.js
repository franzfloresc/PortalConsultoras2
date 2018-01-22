//depende de jquery.paging
var Paginador = function (config) {
    var _config = {
        elementId: config.elementId || '',
        elementClick: config.elementClick,
        numeroImagenesPorPagina: config.numeroImagenesPorPagina || 10
    };

    var _pageClick = function (link, ev, pagerControl) {
        ev.preventDefault();
        var page = link.data('page');
        pagerControl.setPage(page);
        waitingDialog({});

        if (_config.elementClick) {
            _config.elementClick(page);
        }
    };

    var _getItemBlock = function (disabled, current, label) {
        var classes = disabled ? 'item-disabled' : '';
        classes = classes += (current ? ' current' : '');
        return '<div class="item ' + classes + '"><a href= "#">' + label + '</a></div>';
    };

    var _getLabelElement = function (obj) {
        var start = obj.slice[0] + 1;
        var end = obj.slice[1];
        return '<span>{0}-{1} de {2} registros.</span>'.replace('{0}', start).replace('{1}', end).replace('{2}', obj.number);
    };

    var _itemOnSelect = function (page) {
        $('#' + _config.elementId + ' .item').last().after(_getLabelElement(this));
    };

    var _onFormat = function (type) {
        switch (type) {
            case 'block': // n and c
                if (this.value != this.page) {
                    return _getItemBlock(false, false, this.value);
                }
                return _getItemBlock(false, true, this.value);
            case 'next': // >
                if (this.active) {
                    return _getItemBlock(false, false, '&gt;');
                }
                return _getItemBlock(true, false, '&gt;');
            case 'prev': // <
                if (this.active) {
                    return _getItemBlock(false, false, '&lt;');
                }
                return _getItemBlock(true, false, '&lt;');
            case 'first': // [
                if (this.active) {
                    return _getItemBlock(false, false, '&lt;&lt;');
                }
                return _getItemBlock(true, false, '&lt;&lt;');
            case 'last': // ]
                if (this.active) {
                    return _getItemBlock(false, false, '&gt;&gt;');
                }
                return _getItemBlock(true, false, '&gt;&gt;');
        }
    };

    var _paginar = function (numRegistros) {
        if (numRegistros > _config.numeroImagenesPorPagina) {
            var pagerObj = $("#" + _config.elementId).paging(numRegistros, {
                format: '[< ncnnn >]',
                onClick: function (ev) {
                    _pageClick($(this), ev, pagerObj)
                },
                onSelect: _itemOnSelect,
                onFormat: _onFormat
            });
        }
    };

    return {
        paginar: _paginar
    };
}