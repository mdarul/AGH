package pl.edu.agh.ki.bd2;

/**
 * Created by michal on 25/12/17.
 */
class Craft
{
    private String name;
    private String material;

    public Craft(String name, String material) {
        this.name = name;
        this.material = material;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }
}
