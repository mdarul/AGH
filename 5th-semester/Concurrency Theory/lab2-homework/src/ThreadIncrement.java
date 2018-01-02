/**
 * Created by michal on 20/10/17.
 */
public class ThreadIncrement extends Thread {
    private BinarySemaphore binarySemaphore;
    private Race race;
    int n;

    public ThreadIncrement(BinarySemaphore binarySemaphore, int n) {
        this.binarySemaphore = binarySemaphore;
        this.race = new Race();
        this.n = n;
    }

    @Override
    public void run() {
        for(int i = 0; i < n; i++) {
            try {binarySemaphore.binarySemaPhoreWait();}
            catch (InterruptedException e) {e.printStackTrace();}
            race.incrementCounter();
            binarySemaphore.binarySemaPhoreSignal();
        }
    }
}
