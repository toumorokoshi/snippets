"""
Test-e is a python test server for various needs I've had.

Flask is required to run it.
"""
import sys
import logging
from flask import Flask, render_template, request
app = Flask(__name__)

log = logging.getLogger(__name__)
out_hdlr = logging.StreamHandler(sys.stdout)
out_hdlr.setFormatter(logging.Formatter('%(asctime)s %(message)s'))
out_hdlr.setLevel(logging.INFO)
log.addHandler(out_hdlr)
log.setLevel(logging.INFO)

@app.route("/")
def index():
    return "hello world!"

@app.route('/facebook/<appid>')
def facebook(appid=None):
    log.info("Appid is %s" % appid)
    values = {"appid": appid}
    if 'access_token' in request.args and 'fbid' in request.args:
        values['authResponse'] = "{ accessToken: '%s', expiresIn: 3369, userId: '%s' }" % \
            (request.args['access_token'], request.args['fbid'])
    return render_template('facebook.html', **values)


app.run()
