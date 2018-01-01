import java.util.Random;
import java.util.concurrent.locks.*;

class Library {
    private final ReentrantLock writingLock = new ReentrantLock();
    private final Condition notReading = writingLock.newCondition();

    private final int[] tab = new int [10];
    private int readersAmount = 0, writersAmount = 0;

    public Library() {
        for(int i=0; i<10; i++) tab[i] = i;
    }

    public void read(int readerNumber, int index) throws InterruptedException {
        synchronized (writingLock) {
            while (writingLock.isLocked())
                writingLock.wait();
        }
        readersAmount++;
        System.out.println("Reader " + readerNumber + ": reading value: " + tab[index] + " from index: " + index);
        readersAmount--;

        Random random = new Random();
        try {Thread.sleep(1000 * (random.nextInt(2) + 1));}
        catch(Exception e) {}

        System.out.println("Reader " + readerNumber + ": reading value: " + tab[index] + " from index: " + index + " - finished");
        synchronized (writingLock){
            if(writingLock.isLocked())
                notReading.signal();
        }
    }

    public void write(int writerNumber, int index, int value) throws InterruptedException {
        writingLock.lock();
        try {
            while (readersAmount != 0) notReading.await();
            writersAmount++;
            System.out.println("Writer " + writerNumber + ": writing value: " + value + " on index: " + index);
            tab[index] = value;

            Random random = new Random();
            try {Thread.sleep(1000 * (random.nextInt(2) + 1));}
            catch(Exception e) {}

            System.out.println("Writer " + writerNumber + ": writing value: " + value + " on index: " + index + " - finished");
            writersAmount--;
            synchronized (writingLock) {
                writingLock.notifyAll();
            }
        } finally {
            writingLock.unlock();
        }
    }
}
