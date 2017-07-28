<?php
require_once('model.php');

class ChatModel extends Model {

	public function get($token) {
		$sth = $this->db->prepare('select from_user.name as "from", to_user.name as "to", text from message inner join user from_user on from_user.id = message.from_id inner join user to_user on to_user.id = message.to_id where from_id = (select id from user where token = :token) or to_id = (select id from user where token = :token) order by message.id desc');
		$sth->execute(array(':token' => $token));
		$result = $sth->fetchAll(PDO::FETCH_OBJ);
		return $result;
	}

	public function get_conversation($token, $user) {
		$sth = $this->db->prepare('select id, name from user where token = :token');
		$sth->execute(array(':token' => $token));
		$first = $sth->fetchObject()->id;

		$sth = $this->db->prepare('select id from user where name = :name');
		$sth->execute(array(':name' => $user));
		$second = $sth->fetchObject()->id;

		$sth = $this->db->prepare('select from_user.name as "from", to_user.name as "to", text from message inner join user from_user on from_user.id = message.from_id inner join user to_user on to_user.id = message.to_id where (from_user.id in (:first, :second) and to_user.id in (:first, :second)) order by message.id desc');
		$sth->execute(array(':first' => $first, ':second' => $second));
		$result = $sth->fetchAll(PDO::FETCH_OBJ);
		return $result;
	}

	public function send_to($token, $to, $message) {
		try {
			$sth = $this->db->prepare('insert into message (from_id, to_id, text) select from_user.id, to_user.id, :message from user from_user inner join user to_user on from_user.token = :token and to_user.name = :to');
			$sth->execute(array(':token' => $token, ':to' => $to, ':message' => $message));
		} catch (PDOException $e) {}
		return $this->get_conversation($token, $to);
	}
}
