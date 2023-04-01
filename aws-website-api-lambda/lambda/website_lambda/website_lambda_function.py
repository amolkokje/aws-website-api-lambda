import json
import datetime

def lambda_handler(event, context):
    timestamp = datetime.datetime.now().strftime("%m/%d/%Y, %H:%M:%S")
    return {
        "statusCode": 200,
        "body": json.dumps(f"[{timestamp}] Hello World!")
    }
