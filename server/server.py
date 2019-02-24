from concurrent import futures
from threading import Thread, Lock
from datetime import datetime

import RPi.GPIO as GPIO
import time
import logging
import math
import grpc

import utd_pb2
import utd_pb2_grpc

_ONE_DAY_IN_SECONDS = 60 * 60 * 24


GPIO.setmode(GPIO.BOARD)
GPIO.setup(33, GPIO.OUT)
GPIO.setup(35, GPIO.OUT)
GPIO.setup(37, GPIO.OUT)

left_servo = GPIO.PWM(33, 50)
middle_servo = GPIO.PWM(35, 50)
right_servo = GPIO.PWM(37, 50)

class Trasher(utd_pb2_grpc.recycleServicer):
    def TestEcho(self, request, context):
        print(request.message)
        return utd_pb2.Reply(message='Received: ' + request.message )

    def MoveTrashDividers(self, request, context):
        print(request.decision)
        return utd_pb2.Reply(message='Received.')

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
        GPIO

if __name__ == '__main__':
    logging.basicConfig()
    serve()
    left_servo.stop()
    middle_servo.stop()
    right_servo.stop()
    GPIO.cleanup()