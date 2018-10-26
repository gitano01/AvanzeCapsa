// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require_tree .

function cambiarId(id,controlador) {
    document.getElementById("btnAceptarEliminacion").href="/"+controlador+"/"+id;
    document.getElementById("ModalBodyIndex").innerHTML = "¿Desea eliminar el "+ controlador+ id;
}
function cambiarIdYNombre(id,controlador,controladorSingular,nombre) {
    document.getElementById("btnAceptarEliminacion").href="/"+controlador+"/"+id;
    document.getElementById("ModalBodyIndex").innerHTML = "¿Desea eliminar "+ controladorSingular +" "+ nombre+"?" ;
}
function nombre(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /[A-Za-zñÑ-áéíóúÁÉÍÓÚ.\s\t-]/;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}

// función para validar código postal
function validar_cp(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
    patron =/\d/; // 4
    te = String.fromCharCode(tecla); // 5
    return patron.test(te); // 6
}

function validarNombre(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /^[0-9a-zA-ZñÑáéíóúÁÉÍÓÚ()\s\-\_]{1,255}$/i;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}

function validarTelefono(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /^[0-9a-zA-Z().\s\-\_]{1,50}$/i;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}
