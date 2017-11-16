/**
 * Created by Michał on 16.11.2017.
 */
public class P4 extends Thread {
    Node currentNode, newNode;

    public P4(Node currentNode, Node newNode) {
        this.currentNode = currentNode;
        this.newNode = newNode;
    }

    @Override
    public void start() {
        newNode.setUp(currentNode);
        currentNode.setDown(newNode);
    }
}
