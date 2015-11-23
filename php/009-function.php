<?php

// PHP7: scalar type hints, return type hints
function foo(string $str): array {
    $result = [];
    for ($i = 0; $i < 10; $i++) {
        $result[] = $str . $i;
    }

    return $result;
}

$list = foo('x');

foreach ($list as $l) {
    echo $l;
}