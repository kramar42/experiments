<?php
require_once('model.php');

class UserModel extends Model {

    public function get_all() {
        $sth = $this->db()->prepare('select * from user');
        $sth->execute();
        $data = $sth->fetchAll(PDO::FETCH_OBJ);

        return (object) array('users' => $data);
    }

    public function create($name) {
        try {
            $sth = $this->db()->prepare('insert into user (name, token) values (:name, abs(random()))');
            $sth->execute(array(':name' => $name));
        } catch (PDOException $e) {
            return 'Error creating user: ' . $name;
        }
        return $this->get_all();
    }
}
