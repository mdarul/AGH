/**
 * Created by Michał on 16.11.2017.
 */
public class P1 extends Thread {
    Node currentNode, newNode;

    public P1(Node currentNode, Node newNode) {
        this.currentNode = currentNode;
        this.newNode = newNode;
    }

    @Override
    public void start() {
        newNode.setLeft(currentNode);
        currentNode.setRight(newNode);
    }
}
