/**
 * Created by michal on 02/01/18.
 */
public class ListThread extends Thread {
    private List list;
    private Integer number;

    public ListThread(List list) {
        this.list = list;
    }

    public ListThread(List list, Integer number) {
        this.list = list;
        this.number = number;
    }

    void runFillList() {
        for(int i=0; i<25; i++) list.addAtEnd(number);
    }

    @Override
    public void run() {
        list.delete(number);
    }
}
