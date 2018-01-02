import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by michal on 02/01/18.
 */
public class Node {
    public Object object;
    public Node next;
    public ReentrantLock lock;

    public Node(Object object) {
        this.object = object;
        this.next = null;
        lock = new ReentrantLock();
    }
}
