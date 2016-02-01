<?php $diagResults = array (
  'Client' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.103 Safari/537.36',
  'Command Line Available' => 'Yes',
  'DOM Enabled' => 'Yes',
  'Exif Enabled' => 'Yes',
  'GD Enabled' => 'Yes',
  'Upload Max Size' => '50M',
  'Memory Limit' => '512M',
  'Max execution time' => '30',
  'Safe Mode' => '0',
  'Safe Mode GID' => '0',
  'Xml parser enabled' => '0',
  'MCrypt Enabled' => 'Yes',
  'Server OS' => 'Linux',
  'Session Save Path' => '/tmp',
  'Session Save Path Writeable' => true,
  'PHP Version' => '5.6.17',
  'Locale' => 'C.UTF-8',
  'Directory Separator' => '/',
  'PHP APC extension loaded' => 'Yes',
  'PHP Output Buffer disabled' => 'Yes',
  'PHP File Uploads enabled' => 'Yes',
  'Magic quotes disabled' => 'Yes',
  'Upload Tmp Dir Writeable' => true,
  'PHP Upload Max Size' => 52428800,
  'PHP Post Max Size' => 104857600,
  'Users enabled' => true,
  'Guest enabled' => false,
  'Writeable Folders' => '[<b>cache</b>:true,<br> <b>data</b>:true]',
  'Zlib Enabled' => 'No',
);$outputArray = array (
  0 => 
  array (
    'name' => 'Pydio version',
    'result' => false,
    'level' => 'info',
    'info' => 'Version : 6.2.2',
  ),
  1 => 
  array (
    'name' => 'Client Browser',
    'result' => false,
    'level' => 'info',
    'info' => 'Current client Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.103 Safari/537.36',
  ),
  2 => 
  array (
    'name' => 'PHP Command Line',
    'result' => true,
    'level' => 'error',
    'info' => 'Php command line detected, this will allow to send some tasks in background. Enable it in the Pydio Core Options',
  ),
  3 => 
  array (
    'name' => 'DOM Xml enabled',
    'result' => true,
    'level' => 'error',
    'info' => 'Dom XML is required, you may have to install the php-xml extension.',
  ),
  4 => 
  array (
    'name' => 'PHP error level',
    'result' => false,
    'level' => 'info',
    'info' => 'E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_USER_ERROR | E_USER_WARNING | E_USER_NOTICE',
  ),
  5 => 
  array (
    'name' => 'Exif Extension enabled',
    'result' => true,
    'level' => 'warning',
    'info' => 'Installing php-exif extension is recommended if you plan to handle images',
  ),
  6 => 
  array (
    'name' => 'PHP GD version',
    'result' => true,
    'level' => 'warning',
    'info' => 'GD is required for generating thumbnails',
  ),
  7 => 
  array (
    'name' => 'PHP Limits variables',
    'result' => false,
    'level' => 'info',
    'info' => '<b>Testing configs</b>
Upload Max Size=50M
Memory Limit=512M
Max execution time=30
Safe Mode=0
Safe Mode GID=0
Xml parser enabled=0',
  ),
  8 => 
  array (
    'name' => 'MCrypt enabled',
    'result' => true,
    'level' => 'error',
    'info' => 'MCrypt is required by all security functions.',
  ),
  9 => 
  array (
    'name' => 'PHP operating system',
    'result' => false,
    'level' => 'info',
    'info' => 'Current operating system Linux',
  ),
  10 => 
  array (
    'name' => 'PHP Session',
    'result' => false,
    'level' => 'info',
    'info' => '<b>Testing configs</b>',
  ),
  11 => 
  array (
    'name' => 'PHP version',
    'result' => true,
    'level' => 'error',
    'info' => 'Minimum required version is PHP 5.4.0',
  ),
  12 => 
  array (
    'name' => 'PHP APC extension',
    'result' => true,
    'level' => 'warning',
    'info' => 'PHP APC extension detected, this is good for better performances',
  ),
  13 => 
  array (
    'name' => 'PHP Output Buffer disabled',
    'result' => true,
    'level' => 'warning',
    'info' => 'PHP Output Buffering is disabled, this is good for better performances',
  ),
  14 => 
  array (
    'name' => 'PHP File Uploads enabled',
    'result' => true,
    'level' => 'warning',
    'info' => 'PHP File Uploads is enabled',
  ),
  15 => 
  array (
    'name' => 'Magic quotes disabled',
    'result' => true,
    'level' => 'error',
    'info' => 'Magic quotes need to be disabled, only relevent for php 5.3',
  ),
  16 => 
  array (
    'name' => 'SSL Encryption',
    'result' => false,
    'level' => 'warning',
    'info' => 'You are not using SSL encryption, or it was not detected by the server. Be aware that it is strongly recommended to secure all communication of data over the network.<p class=\'suggestion\'><b>Suggestion</b> : if your server supports HTTPS, set the AJXP_FORCE_SSL_REDIRECT parameter in the <i>conf/bootstrap_conf.php</i> file.</p>',
  ),
  17 => 
  array (
    'name' => 'Server charset encoding',
    'result' => true,
    'level' => 'error',
    'info' => 'You must set a correct charset encoding
        in your locale definition in the form: en_us.UTF-8. Please refer to setlocale man page.
        If your detected locale is C, simply type echo $LANG on your server command line to read the correct value.',
  ),
  18 => 
  array (
    'name' => 'Upload particularities',
    'result' => false,
    'level' => 'info',
    'info' => '<b>Testing configs</b>
Upload Tmp Dir Writeable=1
PHP Upload Max Size=52428800
PHP Post Max Size=104857600',
  ),
  19 => 
  array (
    'name' => 'Users Configuration',
    'result' => false,
    'level' => 'info',
    'info' => 'Current config for users',
  ),
  20 => 
  array (
    'name' => 'Required writeable folder',
    'result' => false,
    'level' => 'info',
    'info' => '[<b>cache</b>:true,<br><b>data</b>:true]',
  ),
  21 => 
  array (
    'name' => 'Zlib extension (ZIP)',
    'result' => false,
    'level' => 'info',
    'info' => 'Extension enabled : 0',
  ),
  22 => 
  array (
    'name' => 'Filesystem Plugin
 Testing repository : Common Files',
    'result' => true,
    'level' => 'error',
    'info' => '',
  ),
  23 => 
  array (
    'name' => 'Filesystem Plugin
 Testing repository : My Files',
    'result' => true,
    'level' => 'error',
    'info' => '',
  ),
); ?>