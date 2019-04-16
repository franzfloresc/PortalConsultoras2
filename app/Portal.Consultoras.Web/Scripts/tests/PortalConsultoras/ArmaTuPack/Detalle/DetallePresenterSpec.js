﻿/// <reference path="../../../../tests/TestHelpersModule.js" />

/// <reference path="../../../../General.js" />
/// <reference path="../../../../PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../../PortalConsultoras/DetalleEstrategia/DetalleEstrategiaProvider.js" />

/// <reference path="../../../../PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposView.js" />
/// <reference path="../../../../PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposPresenter.js" />

/// <reference path="../../../../PortalConsultoras/ArmaTuPack/Detalle/DetallePresenter.js" />

describe("ArmaTuPack - Detalle - DetallePresenter", function () {
    describe("Constructor", function () {
        var errorMsg = '';

        beforeEach(function () {
            errorMsg = '';
        });

        it("throw an exception when config is undefined", function () {

            try {
                DetallePresenter(undefined);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config is null", function () {

            try {
                DetallePresenter(null);
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config is null or undefined");
        });

        it("throw an exception when config.armaTuPackProvider is undefined", function () {

            try {
                DetallePresenter({
                    armaTuPackProvider: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackProvider is null or undefined");
        });

        it("throw an exception when config.armaTuPackProvider is null", function () {

            try {
                DetallePresenter({
                    armaTuPackProvider: null
                });
            } catch (error) {
                errorMsg = error;
            }

            // grupoView : {},
            expect(errorMsg).to.have.string("config.armaTuPackProvider is null or undefined");
        });

        it("throw an exception when config.generalModule is undefined", function () {

            try {
                DetallePresenter({
                    armaTuPackProvider: {},
                    generalModule: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        it("throw an exception when config.generalModule is null", function () {

            try {
                DetallePresenter({
                    armaTuPackProvider: {},
                    generalModule: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.generalModule is null or undefined");
        });

        it("throw an exception when config.armaTuPackDetalleEvents is undefined", function () {

            try {
                DetallePresenter({
                    armaTuPackProvider: {},
                    generalModule: {},
                    armaTuPackDetalleEvents: undefined
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        });

        it("throw an exception when config.armaTuPackDetalleEvents is null", function () {

            try {
                DetallePresenter({
                    armaTuPackProvider: {},
                    generalModule: {},
                    armaTuPackDetalleEvents: null
                });
            } catch (error) {
                errorMsg = error;
            }

            expect(errorMsg).to.have.string("config.armaTuPackDetalleEvents is null or undefined");
        });
    });

    describe("init", function () {
        var errorMsg = '';
        //
        var armaTuPackDetalleEvents = null;
        var detallePresenter = null;
        var armaTuPackProvider = null;
        var generalModule = null;

        var fakeData = function () {
            return {
                "success": true,
                "esMultimarca": true,
                "componentes": [
                    {
                        "Cantidad": 1,
                        "CodigoProducto": null,
                        "Cuv": "30379",
                        "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                        "DescripcionComercial": null,
                        "DescripcionMarca": "Ésika",
                        "Digitable": 1,
                        "FactorCuadre": 4,
                        "Grupo": "1",
                        "Id": 0,
                        "IdMarca": 2,
                        "Imagen": null,
                        "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084550_B.jpg",
                        "ImagenProductoSugerido": null,
                        "NombreBulk": "Miel glacé",
                        "NombreComercial": "Labial de Máxima duración.   2 g / .07 oz.",
                        "DescripcionPlural": "Labiales",
                        "DescripcionSingular": "Labial",
                        "Orden": 26,
                        "PrecioCatalogo": 2975,
                        "PrecioCatalogoString": "2.975",
                        "Volumen": "2 g / .07 oz.",
                        "Hermanos": [
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30405",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085007_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rosado nude",
                                "NombreComercial": "Labial de Máxima duración. Rosado nude 2 g / .07 oz.",
                                "Orden": 7,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30387",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084554_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rosa light",
                                "NombreComercial": "Labial de Máxima duración. Rosa light 2 g / .07 oz.",
                                "Orden": 8,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30445",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200087962_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rosa glamour",
                                "NombreComercial": "Labial de Máxima duración. Rosa glamour 2 g / .07 oz.",
                                "Orden": 9,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30644",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con efecto metalizado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200095344_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Naranja candela",
                                "NombreComercial": "Labial de Máxima duración. Naranja candela 2 g / .07 oz.",
                                "Orden": 10,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30450",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200087964_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Fucsia night",
                                "NombreComercial": "Labial de Máxima duración. Fucsia night 2 g / .07 oz.",
                                "Orden": 11,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30648",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con efecto metalizado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200095346_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Dorado tostado",
                                "NombreComercial": "Labial de Máxima duración. Dorado tostado 2 g / .07 oz.",
                                "Orden": 12,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30385",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084552_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Candelit",
                                "NombreComercial": "Labial de Máxima duración. Candelit 2 g / .07 oz.",
                                "Orden": 13,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30403",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085006_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rojo extravaganza",
                                "NombreComercial": "Labial de Máxima duración. Rojo extravaganza 2 g / .07 oz.",
                                "Orden": 14,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30425",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085015_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Vino seductor",
                                "NombreComercial": "Labial de Máxima duración. Vino seductor 2 g / .07 oz.",
                                "Orden": 15,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30375",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084549_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Caoba",
                                "NombreComercial": "Labial de Máxima duración. Caoba 2 g / .07 oz.",
                                "Orden": 16,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30399",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085005_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Fucsia express",
                                "NombreComercial": "Labial de Máxima duración. Fucsia express 2 g / .07 oz.",
                                "Orden": 17,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30408",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085008_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rojo seductor",
                                "NombreComercial": "Labial de Máxima duración. Rojo seductor 2 g / .07 oz.",
                                "Orden": 18,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30641",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con efecto metalizado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200095343_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Uva volcánica",
                                "NombreComercial": "Labial de Máxima duración. Uva volcánica 2 g / .07 oz.",
                                "Orden": 19,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30392",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085003_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Cherry",
                                "NombreComercial": "Labial de Máxima duración. Cherry 2 g / .07 oz.",
                                "Orden": 20,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30413",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085010_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Vino chic",
                                "NombreComercial": "Labial de Máxima duración. Vino chic 2 g / .07 oz.",
                                "Orden": 21,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30419",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085013_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Fucsia seductor",
                                "NombreComercial": "Labial de Máxima duración. Fucsia seductor 2 g / .07 oz.",
                                "Orden": 22,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30638",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con efecto metalizado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200095342_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Granate candente",
                                "NombreComercial": "Labial de Máxima duración. Granate candente 2 g / .07 oz.",
                                "Orden": 23,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30454",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200087965_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rojo atracción",
                                "NombreComercial": "Labial de Máxima duración. Rojo atracción 2 g / .07 oz.",
                                "Orden": 24,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30646",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con efecto metalizado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200095345_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rojo lava",
                                "NombreComercial": "Labial de Máxima duración. Rojo lava 2 g / .07 oz.",
                                "Orden": 25,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30379",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084550_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Miel glacé",
                                "NombreComercial": "Labial de Máxima duración. Miel glacé 2 g / .07 oz.",
                                "Orden": 26,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30410",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085009_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Fucsia pink",
                                "NombreComercial": "Labial de Máxima duración. Fucsia pink 2 g / .07 oz.",
                                "Orden": 27,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30416",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085012_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Naranja vibrante",
                                "NombreComercial": "Labial de Máxima duración. Naranja vibrante 2 g / .07 oz.",
                                "Orden": 28,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30422",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085014_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Coral seductor",
                                "NombreComercial": "Labial de Máxima duración. Coral seductor 2 g / .07 oz.",
                                "Orden": 29,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30381",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200084551_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Oporto",
                                "NombreComercial": "Labial de Máxima duración. Oporto 2 g / .07 oz.",
                                "Orden": 30,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30446",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200087963_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Cobre chic",
                                "NombreComercial": "Labial de Máxima duración. Cobre chic 2 g / .07 oz.",
                                "Orden": 31,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30395",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado perlado.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085004_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Vino golden",
                                "NombreComercial": "Labial de Máxima duración. Vino golden 2 g / .07 oz.",
                                "Orden": 32,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30428",
                                "Descripcion": "Color intenso y suavidad por mucho más tiempo con acabado mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 4,
                                "Grupo": "1",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200085016_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Pimienta caliente",
                                "NombreComercial": "Labial de Máxima duración. Pimienta caliente 2 g / .07 oz.",
                                "Orden": 33,
                                "PrecioCatalogo": 2975,
                                "PrecioCatalogoString": "2.975",
                                "Volumen": "2 g / .07 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            }
                        ],
                        "TieneStock": true,
                        "EstrategiaGrupoId": 0
                    },
                    {
                        "Cantidad": 1,
                        "CodigoProducto": null,
                        "Cuv": "30577",
                        "Descripcion": "Labial liquido hidratante mate.",
                        "DescripcionComercial": null,
                        "DescripcionMarca": "Ésika",
                        "Digitable": 1,
                        "FactorCuadre": 2,
                        "Grupo": "3",
                        "Id": 0,
                        "IdMarca": 2,
                        "Imagen": null,
                        "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093966_B.jpg",
                        "ImagenProductoSugerido": null,
                        "NombreBulk": "Rojo carmin",
                        "NombreComercial": "Hidracolor Mate.   6 ml / .21 fl.oz.",
                        "Orden": 54,
                        "PrecioCatalogo": 3308,
                        "PrecioCatalogoString": "3.308",
                        "Volumen": "6 ml / .21 fl.oz.",
                        "Hermanos": [
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30583",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201903/E/productos/bulk/CL_200093969_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Chocolate intenso",
                                "NombreComercial": "Hidracolor Mate. Chocolate intenso 6 ml / .21 fl.oz.",
                                "Orden": 46,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30571",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093963_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Vino misterio",
                                "NombreComercial": "Hidracolor Mate. Vino misterio 6 ml / .21 fl.oz.",
                                "Orden": 47,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30582",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201903/E/productos/bulk/CL_200093968_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Violeta chic",
                                "NombreComercial": "Hidracolor Mate. Violeta chic 6 ml / .21 fl.oz.",
                                "Orden": 48,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30569",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201903/E/productos/bulk/CL_200093962_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Nude rose",
                                "NombreComercial": "Hidracolor Mate. Nude rose 6 ml / .21 fl.oz.",
                                "Orden": 49,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30576",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093965_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Pimienta caliente",
                                "NombreComercial": "Hidracolor Mate. Pimienta caliente 6 ml / .21 fl.oz.",
                                "Orden": 50,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30595",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200094534_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Almendra rosé",
                                "NombreComercial": "Hidracolor Mate. Almendra rosé 6 ml / .21 fl.oz.",
                                "Orden": 51,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30580",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093967_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Fucsia pop",
                                "NombreComercial": "Hidracolor Mate. Fucsia pop 6 ml / .21 fl.oz.",
                                "Orden": 52,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30566",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201903/E/productos/bulk/CL_200093960_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rosa audaz",
                                "NombreComercial": "Hidracolor Mate. Rosa audaz 6 ml / .21 fl.oz.",
                                "Orden": 53,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30577",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093966_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rojo carmin",
                                "NombreComercial": "Hidracolor Mate. Rojo carmin 6 ml / .21 fl.oz.",
                                "Orden": 54,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30567",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093961_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Nude café",
                                "NombreComercial": "Hidracolor Mate. Nude café 6 ml / .21 fl.oz.",
                                "Orden": 55,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30574",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200093964_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Vino cerezo",
                                "NombreComercial": "Hidracolor Mate. Vino cerezo 6 ml / .21 fl.oz.",
                                "Orden": 56,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30597",
                                "Descripcion": "Labial liquido hidratante mate.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Ésika",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "3",
                                "Id": 0,
                                "IdMarca": 2,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/E/productos/bulk/CL_200094535_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Morado mistico",
                                "NombreComercial": "Hidracolor Mate. Morado mistico 6 ml / .21 fl.oz.",
                                "Orden": 57,
                                "PrecioCatalogo": 3308,
                                "PrecioCatalogoString": "3.308",
                                "Volumen": "6 ml / .21 fl.oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            }
                        ],
                        "TieneStock": true,
                        "EstrategiaGrupoId": 0
                    },
                    {
                        "Cantidad": 1,
                        "CodigoProducto": null,
                        "Cuv": "30622",
                        "Descripcion": "Lápiz Labial Color Puro e intenso.",
                        "DescripcionComercial": null,
                        "DescripcionMarca": "L'Bel",
                        "Digitable": 1,
                        "FactorCuadre": 3,
                        "Grupo": "4",
                        "Id": 0,
                        "IdMarca": 1,
                        "Imagen": null,
                        "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094807_B.jpg",
                        "ImagenProductoSugerido": null,
                        "NombreBulk": "Ultra Mandarine",
                        "NombreComercial": "Pure Color.   4 g e .14 oz.",
                        "DescripcionPlural": "Perfumes",
                        "DescripcionSingular": "Perfume",
                        "Orden": 1,
                        "PrecioCatalogo": 3718,
                        "PrecioCatalogoString": "3.718",
                        "Volumen": "4 g e .14 oz.",
                        "Hermanos": [
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30622",
                                "Descripcion": "Lápiz Labial Color Puro e intenso.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "L'Bel",
                                "Digitable": 1,
                                "FactorCuadre": 3,
                                "Grupo": "4",
                                "Id": 0,
                                "IdMarca": 1,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094807_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Ultra Mandarine",
                                "NombreComercial": "Pure Color. Ultra Mandarine 4 g e .14 oz.",
                                "Orden": 1,
                                "PrecioCatalogo": 3718,
                                "PrecioCatalogoString": "3.718",
                                "Volumen": "4 g e .14 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30628",
                                "Descripcion": "Lápiz Labial Color Puro e intenso.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "L'Bel",
                                "Digitable": 1,
                                "FactorCuadre": 3,
                                "Grupo": "4",
                                "Id": 0,
                                "IdMarca": 1,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094809_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Violet Bold",
                                "NombreComercial": "Pure Color. Violet Bold 4 g e .14 oz.",
                                "Orden": 2,
                                "PrecioCatalogo": 3718,
                                "PrecioCatalogoString": "3.718",
                                "Volumen": "4 g e .14 oz.",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30620",
                                "Descripcion": "Lápiz Labial Color Puro e intenso.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "L'Bel",
                                "Digitable": 1,
                                "FactorCuadre": 3,
                                "Grupo": "4",
                                "Id": 0,
                                "IdMarca": 1,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094806_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Vivid Fucsia",
                                "NombreComercial": "Pure Color. Vivid Fucsia  4 g e .14 oz.",
                                "Orden": 3,
                                "PrecioCatalogo": 3718,
                                "PrecioCatalogoString": "3.718",
                                "Volumen": "4 g e .14 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30626",
                                "Descripcion": "Lápiz Labial Color Puro e intenso.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "L'Bel",
                                "Digitable": 1,
                                "FactorCuadre": 3,
                                "Grupo": "4",
                                "Id": 0,
                                "IdMarca": 1,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094808_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Wild Rouge",
                                "NombreComercial": "Pure Color. Wild Rouge 4 g e .14 oz.",
                                "Orden": 4,
                                "PrecioCatalogo": 3718,
                                "PrecioCatalogoString": "3.718",
                                "Volumen": "4 g e .14 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30618",
                                "Descripcion": "Lápiz Labial Color Puro e intenso.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "L'Bel",
                                "Digitable": 1,
                                "FactorCuadre": 3,
                                "Grupo": "4",
                                "Id": 0,
                                "IdMarca": 1,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094805_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Cocoa Vibrant",
                                "NombreComercial": "Pure Color. Cocoa Vibrant 4 g e .14 oz.",
                                "Orden": 5,
                                "PrecioCatalogo": 3718,
                                "PrecioCatalogoString": "3.718",
                                "Volumen": "4 g e .14 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30613",
                                "Descripcion": "Lápiz Labial Color Puro e intenso.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "L'Bel",
                                "Digitable": 1,
                                "FactorCuadre": 3,
                                "Grupo": "4",
                                "Id": 0,
                                "IdMarca": 1,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/L/productos/bulk/CL_200094804_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Deep Nude",
                                "NombreComercial": "Pure Color. Deep Nude 4 g e .14 oz.",
                                "Orden": 6,
                                "PrecioCatalogo": 3718,
                                "PrecioCatalogoString": "3.718",
                                "Volumen": "4 g e .14 oz.",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            }
                        ],
                        "TieneStock": true,
                        "EstrategiaGrupoId": 0
                    },
                    {
                        "Cantidad": 1,
                        "CodigoProducto": null,
                        "Cuv": "30668",
                        "Descripcion": "Labial líquido brillante full color.",
                        "DescripcionComercial": null,
                        "DescripcionMarca": "Cyzone",
                        "Digitable": 1,
                        "FactorCuadre": 2,
                        "Grupo": "2",
                        "Id": 0,
                        "IdMarca": 3,
                        "Imagen": null,
                        "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095884_B.jpg",
                        "ImagenProductoSugerido": null,
                        "NombreBulk": "Rose nude",
                        "NombreComercial": "Cy Glaze.   5.5 ml",
                        "DescripcionPlural": "Talcos",
                        "DescripcionSingular": "Talco",
                        "Orden": 41,
                        "PrecioCatalogo": 3160,
                        "PrecioCatalogoString": "3.160",
                        "Volumen": "5.5 ml",
                        "Hermanos": [
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30665",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095883_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Deep red",
                                "NombreComercial": "Cy Glaze. Deep red 5.5 ml",
                                "Orden": 34,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30657",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095881_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Chocolate",
                                "NombreComercial": "Cy Glaze. Chocolate 5.5 ml",
                                "Orden": 35,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30681",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095889_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Violet",
                                "NombreComercial": "Cy Glaze. Violet 5.5 ml",
                                "Orden": 36,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30675",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095887_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Mauve",
                                "NombreComercial": "Cy Glaze. Mauve 5.5 ml",
                                "Orden": 37,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30678",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095888_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Magenta",
                                "NombreComercial": "Cy Glaze. Magenta 5.5 ml",
                                "Orden": 38,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30660",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095882_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Wine",
                                "NombreComercial": "Cy Glaze. Wine 5.5 ml",
                                "Orden": 39,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30654",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095880_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Deep rose",
                                "NombreComercial": "Cy Glaze. Deep rose 5.5 ml",
                                "Orden": 40,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30668",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095884_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Rose nude",
                                "NombreComercial": "Cy Glaze. Rose nude 5.5 ml",
                                "Orden": 41,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30674",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095886_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Burgundy",
                                "NombreComercial": "Cy Glaze. Burgundy 5.5 ml",
                                "Orden": 42,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": true,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30671",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095885_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Deep brown",
                                "NombreComercial": "Cy Glaze. Deep brown 5.5 ml",
                                "Orden": 43,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30685",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095890_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Purple",
                                "NombreComercial": "Cy Glaze. Purple 5.5 ml",
                                "Orden": 44,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            },
                            {
                                "Cantidad": 1,
                                "CodigoProducto": null,
                                "Cuv": "30688",
                                "Descripcion": "Labial líquido brillante full color.",
                                "DescripcionComercial": null,
                                "DescripcionMarca": "Cyzone",
                                "Digitable": 1,
                                "FactorCuadre": 2,
                                "Grupo": "2",
                                "Id": 0,
                                "IdMarca": 3,
                                "Imagen": null,
                                "ImagenBulk": "https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/201904/C/productos/bulk/CL_200095891_B.jpg",
                                "ImagenProductoSugerido": null,
                                "NombreBulk": "Deep grape",
                                "NombreComercial": "Cy Glaze. Deep grape 5.5 ml",
                                "Orden": 45,
                                "PrecioCatalogo": 3160,
                                "PrecioCatalogoString": "3.160",
                                "Volumen": "5.5 ml",
                                "Hermanos": null,
                                "TieneStock": false,
                                "EstrategiaGrupoId": 0
                            }
                        ],
                        "TieneStock": false,
                        "EstrategiaGrupoId": 0
                    }
                ],
                "mensaje": "SiMongo|GetEstrategiaProductos = 57|GetEstrategiaDetalleCompuesta = 4|OrdenarComponentesPorMarca = 4|"
            };
        };

        beforeEach(function () {
            errorMsg = '';
            //
            armaTuPackProvider = sinon.stub(ArmaTuPackProvider());
            armaTuPackProvider
                .getPackComponentsPromise
                .returns(
                TestHelpersModule.getResolvedPromiseWithData(fakeData())
                );
            generalModule = sinon.stub(GeneralModule);
            armaTuPackDetalleEvents = sinon.stub(ArmaTuPackDetalleEvents());
            //
            detallePresenter = DetallePresenter({
                armaTuPackProvider: armaTuPackProvider,
                generalModule: generalModule,
                armaTuPackDetalleEvents: armaTuPackDetalleEvents
            });
        });

        afterEach(function () {
            sinon.restore();
        });


        it("should return to /Ofertas when client can't get data", function () {
            armaTuPackProvider
                .getPackComponentsPromise
                .returns(
                TestHelpersModule
                    .getRejectedPromiseWithData({})
                );

            detallePresenter.init();

            expect(generalModule.redirectTo.calledOnce).to.equals(true);
        });

        it("should return to /Ofertas when client get a null data object ", function () {
            armaTuPackProvider
                .getPackComponentsPromise
                .returns(
                TestHelpersModule
                    .getResolvedPromiseWithData(null)
                );

            detallePresenter.init();

            expect(generalModule.redirectTo.calledOnce).to.equals(true);
        });

        it("should return to /Ofertas when client get a data object with null groups", function () {
            armaTuPackProvider
                .getPackComponentsPromise
                .returns(
                TestHelpersModule
                    .getResolvedPromiseWithData({
                        Grupos: null
                    })
                );

            detallePresenter.init();

            expect(generalModule.redirectTo.calledOnce).to.equals(true);
        });

        it("should return to /Ofertas when client get data object with no groups", function () {
            armaTuPackProvider
                .getPackComponentsPromise
                .returns(
                TestHelpersModule
                    .getRejectedPromiseWithData({
                        Grupos: []
                    })
                );

            detallePresenter.init();

            expect(generalModule.redirectTo.calledOnce).to.equals(true);
        });

        it("should fire an event when client get a data object", function () {
            armaTuPackProvider
                .getPackComponentsPromise
                .returns(
                TestHelpersModule
                    .getResolvedPromiseWithData({
                        componentes: [
                            {},
                            {}
                        ]
                    })
                );

            detallePresenter.init();

            var firstCall = 0;
            var firstParam = 0;
            var secondParam = 1;
            expect(armaTuPackDetalleEvents.applyChanges.calledOnce).to.equals(true);
            expect(armaTuPackDetalleEvents.applyChanges.args[firstCall][firstParam]).to.equals(armaTuPackDetalleEvents.eventName.onGruposLoaded);
            expect(armaTuPackDetalleEvents.applyChanges.args[firstCall][secondParam]).to.not.equal(null);

        });
    });
});