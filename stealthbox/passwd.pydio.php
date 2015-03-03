<?php
define('AJXP_EXEC', 1);

parse_str(implode('&', array_slice($argv, 1)), $_GET);

#$utils_path = "/opt/pydio/core/classes";
$utils_path = "/home/toilal/IdeaProjects/pydio-core/core/src/core/classes";

require($utils_path . "/class.AJXP_Utils.php");

print(AJXP_Utils::pbkdf2_create_hash($_GET["password"]));
?>
