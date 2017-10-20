/**
 * Created by michal on 20/10/17.
 */
public class ThreadIncrement extends Thread {
    private BinarySemaphore binarySemaphore;
    private Race race;

    public ThreadIncrement(BinarySemaphore binarySemaphore) {
        this.binarySemaphore = binarySemaphore;
        this.race = new Race();
    }

    @Override
    public void run() {
        for(int i = 0; i < 1000; i++) {
            try {
                binarySemaphore.binarySemaPhoreWait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            race.incrementCounter();
            binarySemaphore.binarySemaPhoreSignal();
        }
    }
}
