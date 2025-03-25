# function_app.py

import logging

def main(req):
    logging.info('Python HTTP trigger function processed a request.')

    # Return a response
    return "Hello from Azure Function!"
