// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function validarFormularioEmpleados() {
    if(!document.getElementById('btnGuardar').classList.contains("disabled")){
        var message, x;
        var primerCampo;
        var band = 0;
        var campos = ["empleado_nombre_completo","empleado_apellido_paterno","empleado_apellido_materno","empleado_rfc", "fecha_nacimiento", "fecha_registro", "usuario_usuario", "usuario_email", "usuario_contrasena_cifrado", "user_confirmar_contrasena"];
        var msgs = ["nombre","app_p","app_m","rfc","fecha_n","fecha_r","usuario","email","pass", "pass_confirm"];
        var pattern = /^([A-Z,Ñ,&]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[A-Z|\d]{3})$/;
        var pattern_email = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        var rfc = document.getElementById('empleado_rfc').value;
        var usuario = document.getElementById('usuario_usuario').value;
        var email = document.getElementById('usuario_email').value;
        var password = document.getElementById('usuario_contrasena_cifrado').value;
        var password_confirm = document.getElementById('user_confirmar_contrasena').value;
        var validar_rfc = pattern.test(rfc);
        var validar_email = pattern_email.test(email);
        for (i=0;i<10;i++){
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                document.getElementById(campos[i]).style.border="";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                if(x == "")  throw "* Este campo no puede estar vacío";
                if(campos[i] == 'empleado_rfc' && validar_rfc == false && rfc.length>0) throw "* RFC no válido. Formato correcto: VECJ880326XXX";
                if(campos[i] == 'usuario_usuario' && usuario.length < 3)  throw "* Nombre de usuario es demasiado corto (3 caracteres mínimo)";
                if(campos[i] == 'usuario_email' && validar_email == false && email.length>0) throw "* Correo electrónico no válido. Formato correcto: nombre-de-cuenta@servidor.dominio"
                if(campos[i] == 'usuario_contrasena_cifrado' && password.length < 4)  throw "* Contraseña es demasiado corto (4 caracteres mínimo)";
                if(campos[i] == 'user_confirmar_contrasena' && password_confirm.length < 4)  throw "* Confirmar contraseña es demasiado corto (4 caracteres mínimo)";
                if(campos[i] == 'user_confirmar_contrasena' && password_confirm.length >=4 && password.length >=4 && password != password_confirm) throw "* Contraseña no coincide con la confirmación"
            }catch(err) {
                message.innerHTML = err;
                document.getElementById(msgs[i]).style.color = "red"; 
                document.getElementById(campos[i]).style.border="solid .5px red";
                if (band==0)
                    primerCampo = campos[i];
                band = 1;
            }
        }
        if (band==0)
        {
            var boton = document.getElementById('btnGuardar');
            boton.classList.add('disabled');
            return true;
        }
        else
        {
            document.getElementById(primerCampo).focus();
            return false;
        }
    }else
        return false;
}

function validarUsuario(e, campo){
    key = e.keyCode ? e.keyCode : e.which;
    if (key == 32) {return false;}
}   

function mayuscula(e){
    e.value = e.value.toUpperCase();
}

$(function (){ 
    $("div.input-group-text").on("click", function(){
        $('#fecha_nacimiento').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            todayBtn: "linked",
            language:"es",
            todayHighlight: true
        });
        $('#fecha_nacimiento').datepicker("show");
    });
    $("span.input-group-text").on("click", function(){
        $('#fecha_registro').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            todayBtn: "linked",
            language:"es",
            todayHighlight: true
        });
        $('#fecha_registro').datepicker("show");
    });
});

function validar_cp(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
    patron =/\d/; // 4
    te = String.fromCharCode(tecla); // 5
    return patron.test(te); // 6
}

