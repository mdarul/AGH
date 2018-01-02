import java.util.concurrent.locks.*;

class Library {
    private final ReentrantLock writingLock = new ReentrantLock();
    private final Condition notReading = writingLock.newCondition();
    private final Condition notWriting = writingLock.newCondition();

    private final int[] tab = new int [10];
    private int readersAmount = 0, writersAmount = 0;

    public Library() {
        for(int i=0; i<10; i++) tab[i] = i;
    }

    public void read(int readerNumber, int index) throws InterruptedException {
        writingLock.lock();
        try {while (writersAmount != 0) notWriting.await();}
        finally {writingLock.unlock();}

        readersAmount++;
        System.out.println("Reader " + readerNumber + ": reading value: " + tab[index] + " from index: " + index);
        readersAmount--;

        writingLock.lock();
        try {notReading.signalAll();}
        finally {writingLock.unlock();}
        System.out.println("Reader " + readerNumber + ": reading value: " + tab[index] + " from index: " + index + " - finished");
    }

    public void write(int writerNumber, int index, int value) throws InterruptedException {
        writingLock.lock();
        try {
            while (readersAmount != 0) notReading.await();
            writersAmount++;
            System.out.println("Writer " + writerNumber + ": writing value: " + value + " on index: " + index);
            tab[index] = value;

            System.out.println("Writer " + writerNumber + ": writing value: " + value + " on index: " + index + " - finished");
            writersAmount--;
        }
        finally {
            notWriting.signalAll();
            writingLock.unlock();
        }
    }
}
