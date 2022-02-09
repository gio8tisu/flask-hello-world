from flask import Flask

application = Flask(__name__)


@application.route('/')
def greet():
    return {'greeting': 'Hello, World!'}
