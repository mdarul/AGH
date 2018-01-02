/*
 * Created by michal on 20/10/17.
 */
import java.util.Random;

class Producer extends Thread {
    private Problem1 _buf = Problem1.getInstance();
    public int number;

    public Producer(int number) {
        this.number = number;
    }

    public void run() {
        Random rand = new Random();
        int val, index;
        for (int i = 0; i < 100; i++) {
            val = rand.nextInt(100);
            index = rand.nextInt(100);
            _buf.startWriting(index, val);
            System.out.println("Producer no. " + this.number + ": wrote value " + val + " to index " + index);
            try {
                Thread.sleep(rand.nextInt(100));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            _buf.endWriting();
        }
    }
}
