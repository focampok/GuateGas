<?php

require_once 'core.php';

$valid['success'] = array('success' => false, 'messages' => array());

function obtenerMes($numeroMes) {
    switch ($numeroMes) {
        case 1:
            return "Enero";
        case 2:
            return "Febrero";
        case 3:
            return "Marzo";
        case 4:
            return "Abril";
        case 5:
            return "Mayo";
        case 6:
            return "Junio";
        case 7:
            return "Julio";
        case 8:
            return "Agosto";
        case 9:
            return "Septiembre";
        case 10:
            return "Octubre";
        case 11:
            return "Noviembre";
        case 12:
            return "Diciembre";
    }
}

if ($_POST) {

    //obtengo el codigo la certificacion
    $id = $_POST['codigoInventario'];

    //obtengo la cantidad de dicho activo
    $sx = "SELECT cantidad FROM PRODUCTO WHERE codigo_producto = '$id';";
    $result = $connect->query($sx);

    $rs = $result->fetch_array();
    $cantidad = $rs["cantidad"];

    $mm = "SELECT cantidad_cert FROM PRODUCTO WHERE codigo_producto = '$id';";
    $ret = $connect->query($mm);

    $rst = $ret->fetch_array();
    $cantidad_cert = $rst["cantidad_cert"];

    $suma = $cantidad + $cantidad_cert;

    //regreso cantidades a estado anterior
    $y = "UPDATE PRODUCTO SET cantidad = $suma WHERE codigo_producto = '$id'";
    $connect->query($y);

    $r = "UPDATE PRODUCTO SET cantidad_cert = 0 WHERE codigo_producto = '$id'";
    $connect->query($r);

    //nuevo subtotal
    $sl = "SELECT precio_unitario FROM PRODUCTO WHERE codigo_producto = '$id';";
    $rstt = $connect->query($sl);

    $rpr = $rstt->fetch_array();
    $precio_unitario = $rpr["precio_unitario"];

    $nst = $suma * $precio_unitario;
    $zz = "UPDATE PRODUCTO SET subtotal = $nst WHERE codigo_producto = '$id'";
    $connect->query($zz);


    //cambio el estado del activo
    $r = "UPDATE PRODUCTO SET estado = 1 WHERE codigo_producto = '$id'";
    $connect->query($r);

    //antes de actualizarla, todos sus activos los libero.        
    $sql = "UPDATE PRODUCTO SET PROYECTO_codigo_proyecto = '-1' WHERE codigo_producto = '$id'";
    if ($connect->query($sql) === TRUE) {
        $valid['success'] = true;
        $valid['messages'] = "Producto quitado del proyecto correctamente.";
    } else {
        $valid['success'] = false;
        $valid['messages'] = "Error no se ha podido quitar el PRODUCTO.";
    }
    
     //obtengo info del user
    $nit = $_SESSION["nit"];

    $XX = "SELECT nit,nombre,apellido FROM USUARIO WHERE nit = '$nit'";
    $sr = $connect->query($XX);
    $us = $sr->fetch_array();
    $nombre = $us[0] . ' - ' . $us[1] . ' ' . $us[2];

    //BITACORA
    $hoy = getdate();
    $fecha = $hoy['mday'].' de '.obtenerMes($hoy['mon']).' del '.$hoy['year'];
    $accion = "El USUARIO $nombre eliminó el PRODUCTO $id del proyecto el $fecha";

    $bitacora = "INSERT INTO BITACORA(fecha,accion,USUARIO_nit)VALUES ('$fecha','$accion','$nit');";
    $connect->query($bitacora);

    $connect->close();

    echo json_encode($valid);
} // /if $_POST