// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function validarFormularioDescuentos() {
    if(!document.getElementById('btnGuardar').classList.contains("disabled")){
        var message, x;
        var primerCampo;
        var band = 0;
        var campos = ["descuento_nombre", "descuento_monto"];
        var msgs = ["nombre", "monto"];
        var fecha_inicial = document.getElementById('descuento_fecha_inicial').value.split("-");
        var fecha_final = document.getElementById('descuento_fecha_final').value.split("-");
        var monto = document.getElementById('descuento_monto').value;
        var date_init = new Date();
        var date_final = new Date();
        date_init.setFullYear(fecha_inicial[2],fecha_inicial[1]-1,fecha_inicial[0]);
        date_final.setFullYear(fecha_final[2],fecha_final[1]-1,fecha_final[0]);
        var fecha_actual = new Date();
        for (i=0;i<2;i++){
            try {
                message = document.getElementById(msgs[i]);
                message.innerHTML = "";
                document.getElementById(campos[i]).style.border="";
                document.getElementById('msg_producto').innerHTML = "";
                document.getElementById('fecha_i').innerHTML = "";
                document.getElementById('fecha_f').innerHTML = "";
                x = document.getElementById(campos[i]).value;
                x = x.trim();
                if(x == "")  throw "* Este campo no puede estar vacío";
                if(campos[i] == 'descuento_monto' && (monto < 1 || monto > 100)) throw "* Monto debe ser un número entero entre 1 y 100";
            }catch(err) {
                message.innerHTML = err;
                document.getElementById(msgs[i]).style.color = "red"; 
                document.getElementById(campos[i]).style.border="solid .5px red";
                if (band==0)
                    primerCampo = campos[i];
                band = 1;
            }
        }
        p = false;
        if(productos.length < 1){
          document.getElementById('msg_producto').innerHTML = "* Lista de productos no puede estar vacía";
          document.getElementById('msg_producto').style.color = "red";
          band = 1;
        }
        if(date_final < fecha_actual){
          document.getElementById('fecha_f').innerHTML = "* Fecha final no puede ser anterior a la fecha de hoy";
          document.getElementById('fecha_f').style.color = "red";
          band = 1;
          p = true;
        }
        /*if(date_init < fecha_actual){
          document.getElementById('fecha_i').innerHTML = "* Fecha de inicio no puede ser inferior a la fecha de hoy";
          document.getElementById('fecha_i').style.color = "red";
          band = 1;
          p = true;
        }*/ 
        if (date_init > date_final && p != true){
          document.getElementById('fecha_i').innerHTML = "* Fecha de inicio no puede ser superior a la fecha final";
          document.getElementById('fecha_i').style.color = "red";
          band = 1;
        }
        if (band==0){
          var boton = document.getElementById('btnGuardar');
          boton.classList.add('disabled');
          return true;
        }else{
          if(primerCampo)
            document.getElementById(primerCampo).focus();
            return false;
        }
    }else
        return false;
}

  $(function (){

    $('#descuento_fecha_inicial').datepicker({
      format: 'dd-mm-yyyy',
      autoclose: true,
      todayBtn: "linked",
      language:"es",
      todayHighlight: true
    }).datepicker("setDate", new Date());

    $('#descuento_fecha_final').datepicker({
      format: 'dd-mm-yyyy',
      autoclose: true,
      todayBtn: "linked",
      language:"es",
      todayHighlight: true
    }).datepicker("setDate", new Date());

    $("#fecha_inicial").on("click", function(){
      $('#descuento_fecha_inicial').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        todayBtn: "linked",
        language:"es",
        todayHighlight: true
      });
      $('#descuento_fecha_inicial').datepicker("show");
    });

    $("#fecha_final").on("click", function(){
      $('#descuento_fecha_final').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        todayBtn: "linked",
        language:"es",
        todayHighlight: true
      });
      $('#descuento_fecha_final').datepicker("show");
    });

  });

  function validar_numero(e) { // 1
      tecla = (document.all) ? e.keyCode : e.which; // 2
      if (tecla==8) return true; // 3
    patron =/\d/; // 4
      te = String.fromCharCode(tecla); // 5
      return patron.test(te); // 6
  }

  // Script para Agregar categorías y Productos //
  
  var productos = [];
  var categorias = [];

  $(document).ready(function() {
    $('#categoria_id').on('change', function() {
      $.ajax({
        url:  "/descuentos/opciones",
        type: "POST",
        data: { categoria_id: $(this).val() }
      });
    });
    
    //Script para agregar un producto en la lista
    $('#btnProducto').click(function(){
      var producto_seleccionada = $('#producto_id').val();
      var categoria_seleccionada = $('#categoria_id').val();
      $('#msg_categoria').html('');
      $('#msg_producto').html('');
      if(producto_seleccionada!=""){
        $.ajax({
          dataType: "json",
          url: "/descuentos/agregar_producto",
          type: "POST", 
          data: { producto_id: producto_seleccionada },
          success: function(data){
            var producto = new Object();
            producto.id = data.id;
            producto.nombre = data.nombre;
            producto.codigo = data.codigo;
            producto.categoria = categoria_seleccionada;
            agregado = false;
            for(var i=0; i<productos.length; i++){
              if(productos[i].id == producto.id){
                agregado = true;
                break;
              }
            }
            if(agregado){
              $("#msg_producto").html('El producto a ingresar ya se encuentra en la lista de productos');
              $("#msg_producto").css("color","#2F92C3");
            }else{
              productos.push(producto);
              listarProductos();
              $.ajax({
                url:  "/descuentos/total_producto",
                type: "POST",
                data: { categoria_id: categoria_seleccionada },
                success: function(data){
                  cont = 0;
                  for(var k=0; k<productos.length; k++){
                    if(productos[k].categoria == categoria_seleccionada){
                      cont++;
                    }
                  }
                  if(data == cont){
                    var categoria = new Object();
                    categoria.id = categoria_seleccionada;
                    categoria.nombre = $('#categoria_id option:selected').text();
                    categorias.push(categoria);
                    listarCategorias();
                  }
                }
              });
            }
          }
        });
      }else{
        $("#msg_producto").html('Producto no válido. Revise el producto a ingresar');
        $("#msg_producto").css("color","#2F92C3");
      }
    });

    //Script para agregar una Categoría en la lista y todos sus productos
    $('#btnCategoria').click(function(){
      var categoria_seleccionada = $('#categoria_id');
      $('#msg_categoria').html('');
      $('#msg_producto').html('');
      if(categoria_seleccionada.val()!=""){
        $.ajax({
          url: "/descuentos/agregar_productos",
          type: "POST", 
          data: { categoria_id: categoria_seleccionada.val() },
          success: function(data){
            if(data.length > 0){
              $.each(data, function(i, item){
                agregado = false;
                for(var k=0; k<productos.length; k++){
                  if(productos[k].id == item.id){
                    agregado = true;
                    break;
                  }
                }
                if(agregado==false){
                  var producto = new Object();
                  producto.id = item.id;
                  producto.nombre = item.nombre;
                  producto.codigo = item.codigo;
                  producto.categoria = categoria_seleccionada.val();
                  productos.push(producto);
                  listarProductos();
                }
              });
              var categoria = new Object();
              categoria.id = categoria_seleccionada.val();
              categoria.nombre = $('#categoria_id option:selected').text();
              agregado = false;
              for(var j=0; j<categorias.length; j++){
                if(categorias[j].id == categoria.id){
                  agregado = true;
                  break;
                }
              }
              if(agregado){
                $('#msg_producto').html('Todos los productos a ingresar ya se encuentran en la lista de productos');
                $('#msg_producto').css('color','#2F92C3');
              }else{
                categorias.push(categoria);
                listarCategorias();
              }
            }else{
              $('#msg_categoria').html('La categoría no tiene productos para agregar');
              $('#msg_categoria').css('color','#2F92C3');
            }
          }
        });
      }else{
        $('#msg_categoria').html('Categoría no válido. Revise la categoría a ingresar');
        $('#msg_categoria').css('color','#2F92C3');
      }
    });
    
    //Script para mostrar molales al eliminar un producto o categoria de la lista 
    var modalConfirm = function(callback){
      var posicion;
      var eliminar_producto;
      $(document).on('click', '.eliminarCategoria', function (event) {
        posicion = event.target.id;
        eliminar_producto = false;
        $('#mensaje_confirmacion').html('¿Está seguro de eliminar la Categoría de la lista y todos sus productos?');
        $("#modal_eliminar").modal('show');
      });

      $(document).on('click', '.eliminarProducto', function (event) {
        posicion = event.target.id;
        eliminar_producto = true;
        $('#mensaje_confirmacion').html('¿Está seguro de eliminar el producto de la lista?');
        $("#modal_eliminar").modal('show');
      });

      $("#modal-btn-si").on("click", function(){
        callback(true, eliminar_producto, posicion);
        $("#modal_eliminar").modal('hide');
      });
      
      $("#modal-btn-no").on("click", function(){
        callback(false, eliminar_producto, posicion);
        $("#modal_eliminar").modal('hide');
      });
    };
    
    //Función para eliminar una categoria o producto de la lista
    modalConfirm(function(confirm, eliminar_producto, posicion){
      if(confirm){//Acciones si el usuario confirma
        if(eliminar_producto){
          for(var i=0; i<categorias.length; i++){
            if(categorias[i].id==productos[posicion].categoria){
              categorias.splice(i,1);
              listarCategorias();
              break;
            }
          }
          productos.splice(posicion,1);
          listarProductos();
        }else{
          var k = 0;
          while(k<productos.length){
            if(productos[k].categoria == categorias[posicion].id){
              productos.splice(k,1);
              K=0;
            }else{
              k++;
            }
          }
          categorias.splice(posicion,1);
          listarCategorias();
          listarProductos();
        }
      }
    });
    ///FIN MODAL
  });

  function listarProductos(){
    filaproductos = '';
    prod_id = '';
    for(var i=0; i<productos.length; i++){
      filaproductos += '<tr>';
      filaproductos += '<td class="text-right">'+ productos[i].codigo +'</td>';
      filaproductos += '<td class="text-right">'+ productos[i].nombre +'</td>';
      filaproductos += '<td class="text-center text-primary"><i id='+i+' title="Eliminar" class="fa fa-trash eliminarProducto cursor"> </i></td>';
      filaproductos += '</tr>';
      prod_id += '<input type="hidden" name="'+productos[i].id+'" value="1">';
    }
    $('#lista_producto').html(filaproductos);
    $('#prod_id').html(prod_id);
  }

  function listarCategorias(){
    filaCategoria = '';
    for(var i=0; i<categorias.length; i++){
      filaCategoria += '<tr>';
      filaCategoria += '<td>'+ categorias[i].nombre +'</td>';
      filaCategoria += '<td class="text-center text-primary"><i id='+i+' title="Eliminar" class="fa fa-trash eliminarCategoria cursor"> </i></td>';
      filaCategoria += '</tr>';
    }
    $('#lista_categoria').html(filaCategoria);
  }