<?php

class Model {
    protected static $db = null;

    public function __construct() {
        if (self::$db == null) {
            self::$db = new PDO('sqlite:../db.sqlite');
            self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            self::$db->query('create table if not exists user (name text primary key, token integer not null)');
            self::$db->query('create table if not exists conversation (id integer primary key, first_user text not null, second_user text not null)');
            self::$db->query('create table if not exists message (conversation_id integer not null, user text not null, text text not null)');
        }
    }

    public function db() {
        return self::$db;
    }

    public function check_user($name) {
        $sth =$this->db()->prepare('select * from user where name = :name');
        $sth->execute(array(':name' => $name));
        return $sth->fetchObject() != false;
    }

    public function check_token($name, $token) {
        $sth =$this->db()->prepare('select * from user where name = :name and token = :token');
        $sth->execute(array(':name' => $name, ':token' => $token));
        return $sth->fetchObject() != false;
    }
}
