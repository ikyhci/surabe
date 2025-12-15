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

function shortTextWithTooltip($text, $limit = 255)
{
    if ($text === null || $text === '') {
        return '';
    }

    if (mb_strlen($text) <= $limit) {
        return esc($text);
    }

    $short = esc(mb_substr($text, 0, $limit));

    return '
        <span
            data-bs-toggle="tooltip"
            data-bs-placement="top"
            title="' . esc($text) . '"
            style="cursor: help;"
        >
            ' . $short . ' <span class="badge badge-pill bg-secondary text-white">...</span>
        </span>
    ';
}