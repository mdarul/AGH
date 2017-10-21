/**
 * Created by michal on 21/10/17.
 */
public class CountingSemaphoreWithMutexes {
    private int max_signals;
    private BinarySemaphore[] semaphores;
    private int currentSemaphoreIndex = -1;

    public CountingSemaphoreWithMutexes(int max_signals) {
        this.max_signals = max_signals;
        this.semaphores = new BinarySemaphore[max_signals];
        for (int i = 0; i < max_signals; i++) this.semaphores[i] = new BinarySemaphore();
        for (int i = 0; i < max_signals; i++) this.semaphores[i].mutexState = true;
    }

    public synchronized void countingSemaphoreWihMutexesSignal() throws InterruptedException {
        while(this.currentSemaphoreIndex == -1) wait();
        this.semaphores[currentSemaphoreIndex].mutexState = true;
        this.currentSemaphoreIndex--;
        this.notify();
    }

    public synchronized void countingSemaphoreWihMutexesWait() throws InterruptedException {
        while(this.currentSemaphoreIndex == this.max_signals - 1) wait();
        this.currentSemaphoreIndex++;
        this.semaphores[currentSemaphoreIndex].mutexState = false;
        this.notify();
    }
}
