/**
 * Created by michal on 20/10/17.
 */
public class BinarySemaphore {
    boolean mutexState = true;

    public synchronized void binarySemaPhoreSignal() {
        this.mutexState = true;
        this.notify();
    }

    public synchronized void binarySemaPhoreWait() throws InterruptedException {
        while(!this.mutexState) this.wait();
//        if(!this.mutexState) this.wait();
        this.mutexState = false;
    }
}
