<?php

namespace RecensioniFilm\Config;

use mysqli;
use Dotenv\Dotenv;

class Database
{
    private static ?mysqli $connection = null;

    public static function getConnection(): mysqli
    {
        if (self::$connection === null) {
            $dotenv = Dotenv::createImmutable(__DIR__ . '/../../');
            $dotenv->load();

            self::$connection = new mysqli(
                $_ENV['DB_HOST'],
                $_ENV['DB_USER'],
                $_ENV['DB_PASS'],
                $_ENV['DB_NAME']
            );

            if (self::$connection->connect_error) {
                die("Connection failed: " . self::$connection->connect_error);
            }

            self::$connection->set_charset("utf8");
        }

        return self::$connection;
    }
}