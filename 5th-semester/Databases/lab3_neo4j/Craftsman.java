package pl.edu.agh.ki.bd2;

/**
 * Created by michal on 25/12/17.
 */
public class Craftsman {
    private String name;
    private String village;

    public Craftsman(String name, String village) {
        this.name = name;
        this.village = village;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVillage() {
        return village;
    }

    public void setVillage(String village) {
        this.village = village;
    }
}
