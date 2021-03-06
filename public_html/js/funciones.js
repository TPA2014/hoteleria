/* Función que encapsula todo el desarrollo */
$(function() {
    /* Variable global con el nombre del proyecto. Método de proyección */
    var Hoteleria = {};
    
    /* Función .app, dentro de ésta van las funciones autoejecutables */
    (function(app) {
        app.init = function() {
            app.loader(); // Carga el loader
            app.bindings(); // Función donde se colocan las llamadas para el desarrollo
            var listado = app.crearlista(); // Fuerza la carga de lista en el index. Auto-ejecutable
        
        // Complemento del Loading. app.loader
            window.onload = function() {
                $.mobile.loading('hide');
            };
        };
        
        //Carga del Loading
        app.loader = function() {
            $(document).bind('mobileinit', function() {
                $.mobile.loader.prototype.options.text = "Cargando...";
                $.mobile.loader.prototype.options.textVisible = true;
                $.mobile.loader.prototype.options.theme = "a";
                $.mobile.loader.prototype.options.html = "";
            });
            $.mobile.loading('show', {
                text: 'Cargando...',
                textVisible: true,
                theme: 'a',
                html: ""
            });
        };

        // Dentro de la funcion Bindings van las llamadas a las funciones del desarrollo integro
        app.bindings = function() {
            //Cargo todos los eventos posibles. Importante.
            $(document).on("pagecontainerbeforeload pagecontainerload pagecontainerloadfailed pagebeforechange pagechange pagecontainerchangefailed pagecontainerbeforeshow pagebeforehide pagecontainershow pagecontainerhide pagebeforecreate pagecreate pageinit pageremove updatelayout", function(e) {
                console.log(e.type);
            });
            
            // Manejo de parámetros en página #listado (listado de hoteles)
            $.mobile.paramsHandler.addPage(
                'listado',               // ID de la página
                ['categoria'],           // Parámetros obligatorios
                [],                      // Parámetros opcionales

                // Función callback a ejecutar antes de mostrar la página
                function (urlParams) {
                    app.crearListado(urlParams.categoria);
                }
            );

            // Manejo de parámetros en página #ficha (ficha de hotel)
            $.mobile.paramsHandler.addPage(
                'ficha',                 // ID de la página
                ['id'],                  // Parámetros obligatorios
                [],                      // Parámetros opcionales

                // Función callback a ejecutar antes de mostrar la página
                function (urlParams) {
                    app.limpiarSlider();
                    app.crearFichas(urlParams.id);
                    app.generarSlider();
                }
            );

            // Manejo de parámetros en página #ficha (ficha de hotel)
            $.mobile.paramsHandler.addPage(
                'mapa',                  // ID de la página
                ['id'],                  // Parámetros obligatorios
                [],                      // Parámetros opcionales

                // Función callback a ejecutar antes de mostrar la página
                function (urlParams) {
                    app.crearMapa(urlParams.id);
                }
            );

            // Inicialización de paramsHandler
            $.mobile.paramsHandler.init();
        };


        $('#formulario').submit(function() {
            // recolecta los valores que inserto el usuario
            var datosUsuario = $("#nombredeusuario").val();
            var datosPassword = $("#clave").val();

            archivoValidacion = "servidorValidacion.php?jsoncallback=?";

            $.getJSON(archivoValidacion, {usuario: datosUsuario,
                                          password: datosPassword})
                .done(function(respuestaServer) {
                    if (respuestaServer.validacion == "ok") {
                        /// si la validacion es correcta, muestra la pantalla "home"
                        swal({
                          title: respuestaServer.mensaje,
                          text: "Generado en: " + respuestaServer.hora,
                          type: "success",
                          allowOutsideClick: true
                        });
                        
                        $.mobile.changePage("#index");
                    } else {
                        /// ejecutar una conducta cuando la validacion falla
                        swal({
                          title: respuestaServer.mensaje,
                          text: "Generado en: " + respuestaServer.hora,
                          type: "error",
                          allowOutsideClick: true
                        });
                    }
                });
            return false;
        });


        /******************************** Desarrollo de Funciones */
        //Lista del index
        app.crearlista = function() {
            $.getJSON("json/categorias.json", function(data) {
                var contenidoLista = '';
                var cantidadHoteles = 0;
                $.each(data, function(index, item) {
                    $.ajax({
                        url: 'json/hoteles.json',
                        async: false,
                        dataType: 'json',
                        success: function(data) {
                            cantidadHoteles = 0;
                            $.each(data, function(index, hotel) {
                                if (hotel.categoria == item.id) {
                                    cantidadHoteles = cantidadHoteles + 1;
                                }
                            });

                        }
                    });

                    contenidoLista += '<li class="ui-li-has-count ui-li-has-thumb">' +
                                      '<a href="#listado?categoria=' + item.id + '">' +
                                      '<div class="ui-li-thumb">' +
                                      '<img src="' + item.enlace_imagen + '" class="thumb" alt="' + item.nombre + '">' +
                                      '</div>' +
                                      '<h5>' + item.nombre + '</h5>' +
                                      '<span class="ui-li-count ui-body-inherit">' + cantidadHoteles + '</span>' +
                                      '</a></li>';
                });

                $('#lista').html(contenidoLista).listview('refresh');

            });
        };

        //Lista de la pagina #listado
        app.crearListado = function(id_categoria) {
            $.post('json/hoteles.json', function(data) {
                var listado = '';
                var categoria = id_categoria;
                $.each(data, function(index, item) {
                    if (item.categoria == categoria) {
                        listado += '<li><a href="#ficha?id=' + item.id + '"><h5>' + item.nombre + '</h5></a></li>';                        
                    }
                });
                $('#listaHoteles').html(listado).listview('refresh');
            });
        };

        //Fichas de la pagina #fichas
        app.crearFichas = function(id_hotel) {
            $.ajax({
                url: 'json/hoteles.json',
                async: false,
                dataType: 'json',
                success: function(data) {
                    var cabecera = '';
                    var info     = '';
                    var botones  = '';
                    var hotel    = null;

                    $.each(data, function(index, item) {
                        if (item.id == id_hotel) {
                            hotel = item;
                            return false;
                        }
                    });

                    cabecera += '<div style="width: 100%; text-align: center;">' +
                                '<img src="' + hotel.enlace_imagen + '" style="max-width: 100%;" />' +
                                '</div>' +
                                '<h1 style="text-align: center">' + hotel.nombre + '</h2>';

                    if (hotel.info_resumen) {
                        info += '<div data-role="collapsible" id="info-resumen">' +
                                '<h3>Resumen</h3>' +
                                '<p>' + hotel.info_resumen + '</p>' +
                                '</div>';
                    }

                    if (hotel.info_habitaciones) {
                        info += '<div data-role="collapsible" id="info-habitaciones">' +
                                '<h3>Habitaciones</h3>' +
                                '<p>' + hotel.info_habitaciones + '</p>' +
                                '</div>';
                    }

                    if (hotel.info_restaurant) {
                        info += '<div data-role="collapsible" id="info-restaurant">' +
                                '<h3>Restaurant</h3>' +
                                '<p>' + hotel.info_restaurant + '</p>' +
                                '</div>';
                    }

                    botones += '<a href="#mapa?id=' + hotel.id + '" class="ui-btn ui-corner-all">Ver ubicación</a>';
                    
                    var directorio = hotel.directorio_galeria;
                    var extensionArchivo = '.jpg';

                    $.ajax({
                        url: directorio,
                        async: false,
                        success: function (data) {
                            var galeriaImagenes = '';

                            $(data).find("a:contains(" + extensionArchivo + ")").each(function () {
                                var archivo = this.href.substring(this.href.lastIndexOf('/')+1);
                                galeriaImagenes += '<div class="item">' +
                                                   '<img src="' + directorio + archivo + '" alt="' + archivo +'">' +
                                                   '</div>';
                            });

                            $('#galeria').html(galeriaImagenes);
                        }
                    });
        
                    $('#cabeceraFicha').html(cabecera);
                    $('#botonesFicha').html(botones);
                    if (info) {
                        $('#infoFicha').html(info).collapsibleset('refresh');
                    }
                }
            });
        };
        
        app.crearMapa = function(id_hotel) {
            var hotel = null;
            var map = null;
            var centroMapa = new google.maps.LatLng(
                                 -32.8887817,
                                 -68.8463026
                             );

            function obtenerHotel(id) {
                $.ajax({
                    url: 'json/hoteles.json',
                    async: false,
                    dataType: 'json',
                    success: function(data) {
                        $.each(data, function(index, item) {
                            if (item.id == id_hotel) {
                                hotel = item;
                                return false;
                            }
                        });
                    }
                });

                var solicitudBusquedaLugar = {
                    // Límite de búsqueda: Provincia de Mendoza
                    bounds: new google.maps.LatLngBounds(
                                new google.maps.LatLng(-32.212801,-67.609863),
                                new google.maps.LatLng(-37.195331,-69.433594)
                            ),
                    query: 'Hotel ' + hotel.nombre + ', Mendoza'
                };

                var service = new google.maps.places.PlacesService(map);
                service.textSearch(solicitudBusquedaLugar, function(results, status) {
                    if (status == google.maps.places.PlacesServiceStatus.OK) {
                        var placeHotel = results[0];

                        var solicitudDetalleLugar = {
                            reference: placeHotel.reference
                        }

                        var infowindow = new google.maps.InfoWindow();
                        service.getDetails(solicitudDetalleLugar, function(place, status) {
                            if (status == google.maps.places.PlacesServiceStatus.OK) {
                                var marcadorHotel = new google.maps.Marker({
                                                        map: map,
                                                        position: place.geometry.location,
                                                        icon: 'img/iconos/marcador_hotel.png'
                                                    });
                                google.maps.event.addListener(marcadorHotel, 'click', function() {
                                    infowindow.setContent(place.name);
                                    infowindow.open(map, this);
                                });

                                map.setCenter(marcadorHotel.getPosition());
                            }
                        });
                    }
                });
            }

            function generarMapa(centro) {
                var mapOptions = {
                    center: centro,
                    zoom: 18,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                map = new google.maps.Map(document.getElementById("mapaCanvas"), mapOptions);
            }

            generarMapa(centroMapa);
            obtenerHotel(id_hotel);
        };

        app.limpiarSlider = function() {
             var galeria = $('#galeria').data('owlCarousel');

             if (galeria) {
                 galeria.destroy();
             }
        };

        app.generarSlider = function() {
            $('#galeria').owlCarousel({
                autoPlay: 3000,
                items: 2
            });
        };

        app.init();
    })(Hoteleria);
});
