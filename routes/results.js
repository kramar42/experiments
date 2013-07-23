module.exports = function(app) {
    var db = require('./db');

    app.post('/api/results', function (req, res) {
        if (req.query.file_id && req.query.av_id &&
            req.query.result && req.query.scan_time) {
            db.addResult(app.db, req.query.file_id, req.query.av_id,
                req.query.result, req.query.scan_time, function(err, result) {
                    if (err) {
                        res.send(500, {status: 500, message: 'Internal server error.'});
                    }
                    if (result.rows.length == 0) {
                        res.send(400, {status: 400, message: 'Empty query response.'})
                    } else {
                        res.send(200, {status: 200, message: 'Success.', result: result.rows});
                    }
                })
        } else {
            res.send(400, {status: 400, message: 'Not valid parameters.'});
        }
    });

    app.get('/api/results/:id?', function (req, res) {
        var options = app.processOptions(req,
            ['av_id', 'file_id', 'scan_time'],
            ['id']);
        db.getResults(app.db, options, function (err, result) {
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
