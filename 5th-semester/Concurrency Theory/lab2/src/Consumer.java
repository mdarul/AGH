/*
 * Created by michal on 20/10/17.
 */
import java.util.Random;

class Consumer extends Thread {
    private Problem1 _buf = Problem1.getInstance();
    public int number;

    public Consumer(int number) {
        this.number = number;
    }

    @Override
    public void run() {
        Random rand = new Random();
        int index;
        for (int i = 0; i < 100; i++) {
            index = rand.nextInt(100);
            System.out.println("Consumer no. " + this.number + ": read value " + _buf.startReading(index) + " from index " + index);
            try {
                Thread.sleep(rand.nextInt(100));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            _buf.endReading();
        }
    }
}
