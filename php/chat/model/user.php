<?php
require_once('model.php');

class UserModel extends Model {

	public function get_all() {
		$sth = $this->db->prepare('select * from user');
		$sth->execute();
		$result = $sth->fetchAll(PDO::FETCH_OBJ);
		return $result;
	}

	public function get($name) {
		$sth = $this->db->prepare('select * from user where user.name = :name');
		$sth->execute(array(':name' => $name));
		$result = $sth->fetch(PDO::FETCH_OBJ);
		return $result;
	}

	public function create($name) {
		try {
			$sth = $this->db->prepare('insert into user (name, token) values (:name, abs(random()))');
			$sth->execute(array(':name' => $name));
		} catch (PDOException $e) {}
		return $this->get($name);
	}
}
