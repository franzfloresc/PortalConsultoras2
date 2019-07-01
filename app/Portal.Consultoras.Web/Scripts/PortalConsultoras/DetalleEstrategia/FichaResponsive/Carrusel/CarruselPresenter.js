/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselModel.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselView.js" />
/// <reference path="~/Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
"use strict";

class CarruselPresenter {

    initialize(model, view) {
        this.model = model;
        this.view = view;
        this.view.fijarObjetosCarrusel(this.model.tipoCarrusell);
        this.view.setAttrHtml(this.model.origenPedidoWeb, this.model.origenAgregarCarrusel);
        this.mostrarCarrusel();
    }

    promiseObternerDataCarrusel(params){
        var dfd = $.Deferred();
        $.ajax({
            type: "POST",
            url: this.model.urlDataCarrusel,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });
        return dfd.promise();
    }

    mostrarCarrusel() {
        if (this.validarStock()) return;

        var data = {
            lista: []
        };
        if (this.model.tipoCarrusell === ConstantesModule.TipoVentaIncremental.CrossSelling ||
            this.model.tipoCarrusell === ConstantesModule.TipoVentaIncremental.Sugerido) {

            const param = {
                cuv: this.model.cuv,
                tipo: this.model.tipoCarrusell
            };
            const thisReference = this;
            this.promiseObternerDataCarrusel(param).done(function (response) {
                if (response) {
                    if (response.success) {
                        data.lista = response.result;
                        if (data.lista.length > 0) {
                            $.each(data.lista, function (i, item) { item.Posicion = i + 1; });
                            thisReference.view.crearPlantilla(data, thisReference.obtenerTitulo());
                        }
                    }

                    thisReference.view.reorderFichaCarrusel(thisReference.model);
                }
            });
        } else {

            if (this.model.palanca === ConstantesModule.TipoEstrategiaTexto.Lanzamiento) {
                data.lista = this.cargarDatos();
                if (data.lista.length > 0) {
                    $.each(data.lista, function (i, item) { item.Posicion = i + 1; });
                    this.view.crearPlantilla(data, this.obtenerTitulo());
                    this.view.reorderFichaCarrusel(this.model);
                }
            }
            else {
                const codigosProductos = this.obtenerCodigoProductos();
                const param = {
                    cuvExcluido: this.model.cuv,
                    palanca: this.model.palanca,
                    codigosProductos: codigosProductos,
                    precioProducto: this.model.precioProducto
                };
                const thisReference = this;
                this.promiseObternerDataCarrusel(param).done(function (response) {
                    if (response && response.success && response.result.length > 0) {
                        data.lista = response.result;
                        $.each(data.lista, function (i, item) { item.Posicion = i + 1; });
                        thisReference.view.crearPlantilla(data, thisReference.obtenerTitulo());
                        thisReference.view.reorderFichaCarrusel(thisReference.model);
                    }
                });
            }
        }
    }

    validarStock() {
        if (this.model.tipoCarrusell === ConstantesModule.TipoVentaIncremental.CrossSelling ||
            this.model.tipoCarrusell === ConstantesModule.TipoVentaIncremental.UpSelling) {
            if (!this.model.tieneStock) return true;
        }
        return false;
    }

    cargarDatos() {
        var setRelacionados = [];
        var cuv = this.model.cuv;

        const campaniaId = this.model.campania;
        if (cuv === "" || campaniaId === "" || campaniaId === "0") {
            return setRelacionados;
        }

        const str = LocalStorageListado(`LANLista${campaniaId}`, "", 1) || "";
        if (str === "") {
            return setRelacionados;
        }

        const lista = JSON.parse(str).response.listaLan;
        var codigoProducto = "";

        $.each(lista, function (index, lanzamiento) {
            if (cuv === lanzamiento.CUV2) {
                codigoProducto = lanzamiento.CodigoProducto;
                return setRelacionados;
            }
        });

        $.each(lista, function (index, lanzamiento) {
            if (cuv !== lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                lanzamiento.ImagenURL = "";
                setRelacionados.push(lanzamiento);
            }
        });
        return setRelacionados;
    }

    obtenerTitulo() {
        let titulo = "";
        if (this.model.tipoCarrusell === ConstantesModule.TipoVentaIncremental.CrossSelling) {
            if (this.model.productosHermanos.length > 1) {
                titulo = "Productos que complementan tu pack";
            } else {
                let componenteInicial = {};
                if (this.model.productosHermanos.length === 1) {
                    componenteInicial = this.model.productosHermanos[0];
                }
                if (componenteInicial.FactorCuadre * componenteInicial.Cantidad === 1) {
                    titulo = `Productos para acompañar <span style="text-transform:capitalize">${this.model.tituloCarrusel.toLowerCase()}</span>`;
                } else {
                    titulo = "Productos que complementan tu pack";
                }
            }
        } else if (this.model.tipoCarrusell === ConstantesModule.TipoVentaIncremental.Sugerido) {
            if (this.model.productosHermanos.length > 1) {
                titulo = "Packs parecidos al que escogiste";
            } else {
                let componenteInicial = {};
                if (this.model.productosHermanos.length === 1) {
                    componenteInicial = this.model.productosHermanos[0];
                }
                if (componenteInicial.FactorCuadre * componenteInicial.Cantidad === 1) {
                    titulo = `Productos parecidos a <span style="text-transform:capitalize">${this.model.tituloCarrusel.toLowerCase()}</span>`;
                } else {
                    titulo = "Packs parecidos al que escogiste";
                }
            }
        } else {
            if (this.model.palanca === ConstantesModule.TipoEstrategiaTexto.OfertaDelDia) {
                titulo = "Ver más ofertas ¡Solo Hoy!";
            } else {
                if (this.model.productosHermanos.length > 1) {
                    titulo = "Ofertas con alguno de estos productos";
                } else {
                    let componenteInicial = {};
                    if (this.model.productosHermanos.length === 1) {
                        componenteInicial = this.model.productosHermanos[0];
                    }
                    if (componenteInicial.FactorCuadre * componenteInicial.Cantidad === 1) {
                        titulo = `Packs que contienen <span style="text-transform:capitalize">${this.model.tituloCarrusel.toLowerCase()}</span>`;
                    } else {
                        titulo = "Ofertas que contienen este nuevo producto";
                    }
                }
            }
        }
        return titulo;
    }

    obtenerCodigoProductos() {
        const componentes = this.model.productosHermanos;
        const contarProductosHermanos = componentes.length;
        let codigosProductos = [];
        
        if (contarProductosHermanos == 0) {
            codigosProductos.push(this.model.codigoProducto);
        } else {
            if (contarProductosHermanos === 1) {
                const valores = componentes[0];
                if (valores.FactorCuadre > 1) codigosProductos.push(valores.CodigoProducto);
                else {
                    codigosProductos.push(this.model.codigoProducto);
                }
            } else {
                for (let i = 0; i < contarProductosHermanos; i++) {
                    if (componentes[i].NombreComercial.indexOf("Bolsa") === -1)
                        codigosProductos.push(componentes[i].CodigoProducto);
                }
            }
        }
        return codigosProductos;
    }

}