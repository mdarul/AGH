/**
 * Created by michal on 02/01/18.
 */
public class ClassicList {
    public Node first;

    public void addAtEnd(Object object) {
        Node newNode = new Node(object);
        if(first == null) first = newNode;
        else {
            Node tmp = first;
            while(tmp.next != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
                tmp = tmp.next;
            }
            tmp.next = newNode;
        }
    }

    public boolean contains(Object object) {
        Node tmp = first;
        while (tmp != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
            if(tmp.object == object) return true;
            tmp = tmp.next;
        }
        return false;
    }

    public void delete(Object object) {
        if(first == null) return;
        else if(first.object.equals(object)) {
            first = first.next;
            return;
        }
        else {
            Node tmp = first;
            while(tmp.next != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
                if(tmp.next.object.equals(object)) {
                    tmp.next = tmp.next.next;
                    return;
                }
                tmp = tmp.next;
            }
        }
    }

    public void printList() {
        Node tmp = first;
        if(tmp != null) tmp.lock.lock();
        while (tmp != null) {
//            try {Thread.sleep(10);}
//            catch (InterruptedException e) {e.printStackTrace();}
            System.out.print(tmp.object + " ");
            tmp = tmp.next;
        }
        System.out.println();
    }
}
