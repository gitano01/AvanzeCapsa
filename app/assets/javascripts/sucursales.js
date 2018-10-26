// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function validarFormularioSucursal() {
    if(!document.getElementById('btnGuardar').classList.contains("disabled")){
        var message, x;
        var band = 0;
        var campos = ["nombre","telefonos","iniciales","direccion"];
        var msgs = ["msg_nombre","msg_telefonos","msg_iniciales","msg_direccion"];
        var primerCampo;
        for (i=0;i<4;i++)
        {
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                x = document.getElementById(campos[i]).value;
                x=x.trim();
                if(x == "")  throw "no puede estar vacío";
                if(x.length !=4 && i==2 ) throw "debe tener 4 caracteres";
            }
            catch(err) {
                message.innerHTML = "* Este campo " + err;
                document.getElementById(msgs[i]).style.color = "red";
                document.getElementById(campos[i]).style.border="solid .5px red";
                if (band==0)
                    primerCampo = campos[i];
                band = 1;
            }
        }
        if (band==0){
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else{
            document.getElementById(primerCampo).focus();
            return false;
        }
    }
    else
        return false
}

function validarIniciales(e) {
    var tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8) return true;
    let patron = /^[0-9A-Z\s\-\_]$/i;
    var te = String.fromCharCode(tecla);
    return patron.test(te);
}