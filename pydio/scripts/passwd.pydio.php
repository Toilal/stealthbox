<?php
define('AJXP_EXEC', 1);

$utils_path = "/opt/pydio/core/classes";
require($utils_path . "/class.AJXP_Utils.php");

print(AJXP_Utils::pbkdf2_create_hash($_GET["password"]));
