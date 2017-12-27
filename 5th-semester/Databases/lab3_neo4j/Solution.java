package pl.edu.agh.ki.bd2;

import java.util.Random;

public class Solution {

    private final GraphDatabase graphDatabase = GraphDatabase.createDatabase();

    public void databaseStatistics() {
        System.out.println(graphDatabase.runCypher("CALL db.labels()"));
        System.out.println(graphDatabase.runCypher("CALL db.relationshipTypes()"));
        System.out.println(graphDatabase.runCypher("MATCH (node) RETURN *"));
        System.out.println(graphDatabase.runCypher("MATCH (node1)-[relationship]->(node2) RETURN *"));
    }

    public String findAllRelationships(String nodeName) {
        return graphDatabase.runCypher(String.format("MATCH (node1 {name: '%s'})-[relationship]-(node2) RETURN *", nodeName));
    }

    public String findShortestPath(String nodeName1, String nodeName2) {
        return graphDatabase.runCypher(String.format("MATCH path = shortestPath((node1 {name: '%s'})-[*]-(node2 {name: '%s'})) RETURN path", nodeName1, nodeName2));
    }

    public void addCraftsman(String craftsmanName, String villageName) {
        graphDatabase.runCypher(String.format("CREATE (:Craftsman {name: '%s', village: '%s'})", craftsmanName, villageName));
    }

    public void addCraft(String craftName, String craftMaterial) {
        graphDatabase.runCypher(String.format("CREATE (:Product {name: '%s', material: '%s'})", craftName, craftMaterial));
    }

    public void addCreatedtRelationship(String craftsmanName, String villageName, String productName) {
        graphDatabase.runCypher(String.format("MATCH (craftsman:Craftsman {name: '%s', village: '%s'}), (product:Product {name: '%s'}) CREATE (craftsman)-[:CREATED]->(product)", craftsmanName, villageName, productName));
    }

    public void addSellsRelationship(String craftsmanName, String villageName, String productName, float price) {
        graphDatabase.runCypher(String.format("MATCH (craftsman:Craftsman {name: '%s', village: '%s'}), (product:Product {name: '%s'}) CREATE (craftsman)-[:SELLS {price: %s}]->(product)", craftsmanName, villageName, productName, price));
    }

    public void addHelpRelationship(String craftsmanName1, String villageName1, String craftsmanName2, String villageName2) {
        graphDatabase.runCypher(String.format("MATCH (craftsman1:Craftsman {name: '%s', village: '%s'}), (craftsman2:Craftsman {name: '%s', village: '%s'}) CREATE (craftsman1)-[:HELPS]->(craftsman2)", craftsmanName1, villageName1, craftsmanName2, villageName2));
    }

    public void clearDatabase() {
        graphDatabase.runCypher("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r");
    }

    public void generateData() {
        clearDatabase();

        String[] craftsmenNames = {"Bogumił", "Wojciech", "Jaromir", "Dobrosław", "Gniewomir", "Mirosław", "Dobromir", "Bożydar"};
        String[] villages = {"Kamiennik", "Podgórze", "Niepłonnica", "Nowy Sad", "Grodzieńsko", "Nowy Sad", "Podgórze", "Nowy Sad"};
        Craftsman[] craftsmen = new Craftsman[8];
        for(int i = 0; i < 8; i++) craftsmen[i] = new Craftsman(craftsmenNames[i], villages[i]);

        String[] craftsNames = {"krzesło", "lalka", "podkowa", "nóż", "piłka", "miska", "widelec", "miecz", "konik na biegunach", "ubranie"};
        String[] craftsMaterials = {"drewno", "płótno", "żelazo", "stal", "skóra", "glina", "drewno", "stal", "drewno", "skóra"};
        Craft[] crafts = new Craft[10];
        for(int i = 0; i < 10; i++) crafts[i] = new Craft(craftsNames[i], craftsMaterials[i]);
        for (Craft craft : crafts)
            addCraft(craft.getName(), craft.getMaterial());

        for(int i = 0; i < 8; i++) {
            addCraftsman(craftsmen[i].getName() + "_creator", craftsmen[i].getVillage());
            addCreatedtRelationship(craftsmen[i].getName() + "_creator", craftsmen[i].getVillage(), crafts[i].getName());
            addCreatedtRelationship(craftsmen[i].getName() + "_creator", craftsmen[i].getVillage(), crafts[i+1].getName());
            addCreatedtRelationship(craftsmen[i].getName() + "_creator", craftsmen[i].getVillage(), crafts[i+2].getName());
        }

        for (int i = 0; i < 5; i++) {
            String name = craftsmen[i].getName() + "_seller";
            addCraftsman(name, craftsmen[i].getVillage());
            Random randomGenerator = new Random();
            addCreatedtRelationship(name, craftsmen[i].getVillage(), crafts[2*i].getName());
            addSellsRelationship(name, craftsmen[i].getVillage(), crafts[2*i+1].getName(), randomGenerator.nextFloat()*100);
        }

        String name2 = craftsmen[0].getName() + "_isbeinghelped";
        addCraftsman(name2, craftsmen[0].getVillage());
        for (int i = 1; i <5; i++) {
            String name1 = craftsmen[i].getName() + "_helper";
            addCraftsman(name1, craftsmen[i].getVillage());
            addHelpRelationship(name1, craftsmen[i].getVillage(), name2, craftsmen[0].getVillage());
        }
    }
}