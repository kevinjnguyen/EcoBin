from concurrent import futures
from threading import Thread, Lock
from datetime import datetime

# import RPi.GPIO as GPIO
import time
import logging
import math
import grpc

import utd_pb2
import utd_pb2_grpc

_ONE_DAY_IN_SECONDS = 60 * 60 * 24

class Trasher(utd_pb2_grpc.recycleServicer):
    def TestEcho(self, request, context):
        print(request.message)
        return utd_pb2.Reply(message='Received: ' + request.message )

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    utd_pb2_grpc.add_recycleServicer_to_server(Trasher(), server)
    server.add_insecure_port('[::]:50051')
    server.start()

    try:
        while True:
            time.sleep(_ONE_DAY_IN_SECONDS)
    
    except KeyboardInterrupt:
        server.stop(0)

if __name__ == '__main__':
    logging.basicConfig()
    serve()