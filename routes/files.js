module.exports = function(app) {
    var db = require('./db');

    app.get('/api/files/:id?', function(req, res) {
        var options = app.processOptions(req,
            ['hash', 'type', 'size', 'infected'],
            ['id']);
        db.getFiles(app.db, options, function(err, result) {
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
