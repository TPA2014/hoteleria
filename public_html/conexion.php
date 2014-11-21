<?php

    function conectar_db() {
        $db_user = "mike";
        $db_pass = "";
        $db_host = "localhost";
        $db_database = "hoteleria";
        
        $conexion = @mysql_connect($db_host, $db_user, $db_pass)
                    or die ("Fallo en el establecimiento de la conexión a " +
                            "la base de datos.\n" +
                            "Compruebe la configuración de conexión en " +
                            "el archivo 'conexion.php'.");

        $database = @mysql_select_db($db_database)
                    or die ("No se encuentra la base de datos especificada.\n" +
                            "Compruebe la configuración de conexión en " +
                            "el archivo 'conexion.php'.");
        
        return $conexion;
    }

?>
