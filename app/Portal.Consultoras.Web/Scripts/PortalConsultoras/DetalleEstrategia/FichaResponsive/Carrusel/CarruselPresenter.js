"use strict";

class CarruselPresenter {

    initialize(model, view) {
        this.model = model;
        this.view = view;
        this.view.ocultarElementos();
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

        if (!this.model.tieneStock) return;

        var data = {
            lista: []
        };

        if (this.model.palanca === ConstantesModule.TipoEstrategiaTexto.Lanzamiento) {
            data.lista = this.cargarDatos();
            if (data.lista.length > 0) {
                $.each(data.lista, function (i, item) { item.Posicion = i + 1; });
                this.view.crearPlantilla(data, this.obtenerTitulo(), data.lista.length);
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
                if (response) {
                    if (response.success) {
                        data.lista = response.result;
                        if (data.lista.length > 0) {
                            $.each(data.lista, function (i, item) { item.Posicion = i + 1; });
                            thisReference.view.crearPlantilla(data, thisReference.obtenerTitulo(), data.lista.length);
                        }
                    }
                }
            });
        }
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
        if (this.model.palanca == ConstantesModule.TipoEstrategiaTexto.OfertaDelDia) {
            titulo = "Ver más ofertas ¡Solo Hoy!";
        } else {
            if (this.model.productosHermanos.length > 1) {
                titulo = "Packs parecidos con más productos";
            } else {
                var componenteInicial = {};
                if (this.model.productosHermanos.length === 1) {
                    componenteInicial = this.model.productosHermanos[0];
                }
                if (componenteInicial.FactorCuadre * componenteInicial.Cantidad === 1) {
                    titulo = `Packs que contienen <span style="text-transform:capitalize">${this.model.tituloCarrusel.toLowerCase()}</span>`;
                } else {
                    titulo = "Packs parecidos con más productos";
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