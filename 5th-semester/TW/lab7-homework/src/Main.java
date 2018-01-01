/**
 * Created by michal on 01/01/18.
 */
public class Main {
    public static void main(String[] args) throws InterruptedException {
        Library library = new Library();

        final int M = 5, N = 2;
        Reader[] readers = new Reader[M];
        Writer[] writers = new Writer[N];

        for (int i = 0; i < N; i++) writers[i] = new Writer(i, library);
        for (int i = 0; i < M; i++) readers[i] = new Reader(i, library);

        for (int i = 0; i < N; i++) writers[i].start();
        for (int i = 0; i < M; i++) readers[i].start();

        for (int i = 0; i < N; i++) writers[i].join();
        for (int i = 0; i < M; i++) readers[i].join();

    }
}
