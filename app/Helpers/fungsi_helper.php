<?php

function pd($data, $exit = true)
{
    echo "<pre>";
    print_r($data);
    if ($exit) {
        echo "</pre>";
        die;
    }
    echo "</pre>";
}