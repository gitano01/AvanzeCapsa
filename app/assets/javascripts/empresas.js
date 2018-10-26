// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function nombre(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /[0-9A-Za-zñÑ-áéíóúÁÉÍÓÚ.&\s\t-]/;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}
function validaRFC(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /[0-9A-ZñÑ.&\s\t-]/;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}


function validarFormularioEmpresa() {
    if(!document.getElementById('btnGuardar').classList.contains("disabled")) {
        let pattern = /^([A-Z,Ñ,&]{2,3}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[A-Z|\d]{3})$/;
        let rfc = document.getElementById('rfcE').value;
        var message, x;
        var band = 0;
        var campos = ["nombreE", "rfcE", "ivaE"];
        var msgs = ["msg_nombreE", "msg_rfcE", "msg_ivaE"];
        // RFC
        var n = pattern.test(rfc);
        var primerCampo;
        for (i = 0; i < 3; i++) {

            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                if (x === "" && i != 1) throw "Este campo no puede estar vacío";
                if (isNaN(x) && i == 2) throw "Este campo no es un número";
                if (n == false && x !== "" && i == 1) throw "RFC no es válido, formato correcto ABC180812XXX (letras en mayúscula)";
                if (i == 2) {
                    if (x > 99 || x < 0) throw "El valor debe estar entre 0 y 100"
                }
            }
            catch (err) {
                message.innerHTML = err;
                document.getElementById(msgs[i]).style.color = "red";
                document.getElementById(campos[i]).style.border = "solid .5px red";
                if (band == 0)
                    primerCampo = campos[i];
                band = 1;
            }
        }
        if (band == 0) {
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else {
            document.getElementById(primerCampo).focus();
            return false;
        }
    }
    else
        return false;
}

function validar_iva(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
    patron =/\d/; // 4
    te = String.fromCharCode(tecla); // 5
    return patron.test(te); // 6
}

