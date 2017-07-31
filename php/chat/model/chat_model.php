<?php
require_once('model.php');

class ChatModel extends Model {

    protected function get_or_create_conversation($name, $user) {
        $sth = $this->db()->prepare('select id from conversation where :name in (first_user, second_user) and :user in (first_user, second_user)');
        $sth->execute(array(':name' => $name, ':user' => $user));
        $conv = $sth->fetchObject();
        if (!$conv) {
            if ($this->check_user($user)) {
                try {
                    $sth = $this->db()->prepare('insert into conversation (first_user, second_user) values(:name, :user)');
                    $sth->execute(array(':name' => $name, ':user' => $user));
                    $conv = $sth->fetchObject();
                } catch (PDOException $e) {
                    return 'Error creating conversation for users ' . $name . ' and ' . $user;
                }
            } else {
                return 'There is no user with such name: ' . $user;
            }
        }
        return $conv;
    }

    public function get_conversations($name) {
        $sth = $this->db()->prepare('select first_user, second_user from conversation where :name in (first_user, second_user)');
        $sth->execute(array(':name' => $name));
        $data = $sth->fetchAll(PDO::FETCH_OBJ);

        return (object) array('conversations' => $data);
    }

    public function get_conversation($name, $user) {
        $conv = $this->get_or_create_conversation($name, $user);
        if (is_string($conv)) return $conv;

        $sth = $this->db()->prepare('select user, text from message where conversation_id = :conv_id');
        $sth->execute(array(':conv_id' => $conv->id));
        $data = $sth->fetchAll(PDO::FETCH_OBJ);

        return (object) array('conversation' => $data);
    }

    public function send_to($name, $user, $text) {
        $conv = $this->get_or_create_conversation($name, $user);
        if (is_string($conv)) return $conv;

        try {
            $sth = $this->db()->prepare('insert into message (conversation_id, user, text) values (:conv_id, :user, :text)');
            $sth->execute(array(':conv_id' => $conv->id, ':user' => $name, ':text' => $text));
        } catch (PDOException $e) {
            return 'Error sending message [' . $text . '] from user ' . $name . ' to user ' . $user;
        }
        return $this->get_conversation($name, $user);
    }
}
