<?php

class Db {
	private static $instance = null;
	private static $db = null;

	private function __construct() {
		self::$db = new PDO('sqlite::memory:', null, null, array(PDO::ATTR_PERSISTENT => true));
		self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		self::$db->query('create table if not exists user (id integer primary key, name text unique, token integer not null)');
		self::$db->query('create table if not exists message (id integer primary key, from_id integer not null, to_id integer not null, text text not null)');
	}

	public static function get_instance() {
		if (!isset(self::$instance)) {
			self::$instance = new Db();
		}
		return self::$instance;
	}

	public function get_db() {
		return self::$db;
	}
}
