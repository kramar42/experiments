<?php
require_once('lib/db.php');

class Model {
	public $db;

	public function __construct() {
		$this->db = Db::get_instance()->get_db();
	}
}
