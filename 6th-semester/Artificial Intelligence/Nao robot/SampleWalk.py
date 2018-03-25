import math
import time


class MyClass(GeneratedClass):
    def __init__(self):
        GeneratedClass.__init__(self)

    def onLoad(self):
        #~ puts code for box initialization here
        pass

    def onUnload(self):
        #~ puts code for box cleanup here
        pass

    def onInput_onStart(self):
        motionProxy=ALProxy ("ALMotion")
        postureProxy = ALProxy("ALRobotPosture")
        postureProxy.goToPosture("StandInit", 0.5)        
        
        motionProxy.walkTo(0.2, 0.0, 0.0)    
        motionProxy.waitUntilWalkIsFinished()
        
        motionProxy.walkTo(0.2, 0.0, 1.57)        
        motionProxy.waitUntilWalkIsFinished()
        
        X = -1.0 
        Y = 0.0 
        Theta = 0.0 
        Frequency = 0.25 
        motionProxy.setWalkTargetVelocity(X, Y, Theta, Frequency)
        time.sleep(8)
        motionProxy.stopMove()
        motionProxy.waitUntilWalkIsFinished()     
    
        postureProxy.goToPosture("LyingBack", 1.0)
        motionProxy.waitUntilWalkIsFinished()  
        time.sleep(5)
        
        postureProxy.goToPosture("Crouch", 1.0)
        motionProxy.waitUntilWalkIsFinished()  
        time.sleep(5)
        
        postureProxy.goToPosture("StandInit", 1.0) 
        motionProxy.waitUntilWalkIsFinished()

        motionProxy.walkTo(0.2, 0.0, -1.57)        
        motionProxy.waitUntilWalkIsFinished()
  
        self.onStopped()
        
    def onInput_onStop(self):
        self.onUnload() 
        pass