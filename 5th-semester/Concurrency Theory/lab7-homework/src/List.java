import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by michal on 02/01/18.
 */

public class List {
    public Node first;

    public void addAtEnd(Object object) {
        Node newNode = new Node(object);
        synchronized (this) {
            if(first == null) {
                first = newNode;
                return;
            }
        }

        Node listIterator;
        synchronized (this) {
            first.lock.lock();
            listIterator = first;
        }
        while(listIterator.next != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
            listIterator.next.lock.lock();
            Node tmp = listIterator;
            listIterator = listIterator.next;
            tmp.lock.unlock();
        }
        listIterator.next = newNode;
        listIterator.lock.unlock();
    }

    public boolean contains(Object object) {
        if(first == null) return false;

        Node listIterator;
        synchronized (this) {
            first.lock.lock();
            listIterator = first;
        }
        while (listIterator != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
            if(listIterator.object == object) {
                listIterator.lock.unlock();
                return true;
            }
            Node tmp = listIterator;
            if(listIterator.next != null) listIterator.next.lock.lock();
            listIterator = listIterator.next;
            tmp.lock.unlock();
        }
        return false;
    }

    public void delete(Object object) {
        synchronized (this) {if(first == null) return;}

        first.lock.lock();
        if(first.object.equals(object)) {
            first.next.lock.lock();
            first = first.next;
            first.lock.unlock();
            return;
        }
        else {
            Node listIterator = first;
            while(listIterator.next != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
                listIterator.next.lock.lock();
                if(listIterator.next.object.equals(object)) {
                    synchronized (this) {if(listIterator.next.next != null) listIterator.next.next.lock.lock();}
                    listIterator.next = listIterator.next.next;
                    listIterator.lock.unlock();
                    synchronized (this) {
                        if(listIterator.next != null)listIterator.next.lock.unlock();
                    }
                    return;
                }
                Node tmp = listIterator;
                listIterator = listIterator.next;
                tmp.lock.unlock();
            }
            listIterator.lock.unlock();
        }
    }

    public void printList() {
        Node listIterator;
        synchronized (this) {
            first.lock.lock();
            listIterator = first;
        }
        while (listIterator != null) {
            System.out.print(listIterator.object + " ");
            if(listIterator.next != null) listIterator.next.lock.lock();
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
            Node tmp = listIterator;
            listIterator = listIterator.next;
            tmp.lock.unlock();
        }
        System.out.println();
    }
}
