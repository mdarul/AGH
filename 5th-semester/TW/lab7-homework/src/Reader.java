import java.util.Random;

/**
 * Created by michal on 01/01/18.
 */
public class Reader extends Thread {
    int readerNumber;
    Library library;

    public Reader(int number, Library library) {
        this.readerNumber = number;
        this.library = library;
    }

    @Override
    public void run() {
        Random random = new Random();
        for(int i=0; i<3; i++) {
            int index = random.nextInt(10);
            try {library.read(readerNumber, index);}
            catch (InterruptedException e) {e.printStackTrace();}
            if(i != 2) {
                try {Thread.sleep(1000 * (random.nextInt(4) + 1));}
                catch(Exception e) {}
            }
        }
    }
}
