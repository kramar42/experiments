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
} else {
    // print ongoing conversations and all other users
    if (isset($response->get_data()->conversations)) {
        echo 'List of ongoing conversations:';
        echo '<ul>';
        foreach ($response->get_data()->conversations as $conversation) {
            if ($response->get_data()->name == $conversation->first_user) {
                $user = $conversation->second_user;
            } else {
                $user = $conversation->first_user;
            }
            echo '<li><a href="' . $_SERVER['REQUEST_URI'] . '&user=' . $user . '">' . $user . '</a></li>';
        }
        echo '</ul>' ?>
        Start new conversation with:
        <form method="get">
            <input type="hidden" name="name" value="<? echo $response->get_data()->name ?>">
            <input type="hidden" name="token" value="<? echo $response->get_data()->token ?>">
            <input type="text" name="user">
            <input type="submit" value="Start conversation">
        </form>
    <?
    } else if (isset($response->get_data()->conversation)) {
            echo '<table>';
            foreach ($response->get_data()->conversation as $message) {
                echo '<tr><td>' . $message->user . '</td><td><pre>' . $message->text . '</pre></td></tr>';
            }
            echo '</table>'; ?>
        <form method="post">
            <input type="hidden" name="name" value="<? echo $response->get_data()->name ?>">
            <input type="hidden" name="token" value="<? echo $response->get_data()->token ?>">
            <input type="hidden" name="user" value="<? echo $response->get_data()->user ?>">
            <input type="text" name="message" autofocus>
            <input type="submit" value="Send">
        </form>

<?
    }
} ?>

<a href="/chat/route/user.php">Logout</a>

</body>
</html>
