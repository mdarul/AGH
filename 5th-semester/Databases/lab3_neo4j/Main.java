package pl.edu.agh.ki.bd2;

import java.io.IOException;

public class Main {

    public static void main(String[] args) throws IOException {
        Solution solution = new Solution();
        solution.generateData();
        solution.databaseStatistics();

        System.out.println("find all relations:");
        System.out.println(solution.findAllRelationships("Mirosław_creator"));

        System.out.println("find shortest path");
        System.out.println(solution.findShortestPath("nóż", "widelec"));
    }
}