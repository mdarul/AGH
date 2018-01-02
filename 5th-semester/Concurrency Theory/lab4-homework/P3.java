/**
 * Created by Michał on 16.11.2017.
 */
public class P3 extends Thread {
    Node currentNode, newNode;

    public P3(Node currentNode, Node newNode) {
        this.currentNode = currentNode;
        this.newNode = newNode;
    }

    @Override
    public void start() {
        newNode.setDown(currentNode);
        currentNode.setUp(newNode);
    }
}
