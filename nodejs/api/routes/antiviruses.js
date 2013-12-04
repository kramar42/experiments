module.exports = function(app) {
    var db = require('./db');

    app.get('/api/antiviruses/:id?', function(req, res) {
        var options = app.processOptions(req,
            ['full_name', 'core_version', 'update_version', 'active', 'short_name'],
            ['id']);
        db.getAntiviruses(app.db, options, function(err, result) {
            if (err) {
                res.send(500, {status: 500, message: 'Internal server error.'});
            }
            if (result.rows.length == 0) {
                res.send(400, {status: 400, message: 'Empty query response.'})
            } else {
                res.send(200, {status: 200, message: 'Success.', result: result.rows});
            }
        });
    });
};
