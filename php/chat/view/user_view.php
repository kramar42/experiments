<!DOCTYPE html>
<html>
<head>
    <title>Users</title>
</head>
<body>
<?php
if ($response->has_errors()) {
    foreach ($response->get_errors() as $error) {
        echo $error . '<br>';
    }
} else if (empty($response->get_data()->users)) {
    echo 'There are no users yet.<br>';
} else {
    echo 'List of users:<br>';
    echo '<table>';
foreach ($response->get_data()->users as $user) { ?>
    <tr><td><? echo $user->name ?></td>
    <td><a href="<? echo '/chat/route/chat.php?name=' . $user->name . '&token=' . $user->token ?>">Login</a></td>
    </tr>
<? } // foreach
    echo '</table>';
} // if ?>

Create new user:
<form method="post">
    <input name="name">
    <input type="submit" value="Create">
</form>
</body>
</html>