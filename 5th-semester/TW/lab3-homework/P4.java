package pl.edu.agh.macwozni.dmeshparallel.production;

import pl.edu.agh.macwozni.dmeshparallel.parallelism.Counter;
import pl.edu.agh.macwozni.dmeshparallel.mesh.Vertex;

public class P4 extends Production {

    public P4(Vertex vert, Counter count) {
        super(vert, count);
    }

    @Override
    public Vertex apply(Vertex t2) {
        System.out.println("p4");
        Vertex t2Prim = new Vertex(t2, null, "T2");
        t2Prim.setRight(t2.getRight());
        t2.setRight(t2Prim);
        return t2;
    }
}
