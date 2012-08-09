
public class Dijkstra {
	public static final int GRAPH_SIZE = 4;
	
	public static void main(String[] args) {
		Graph graph = new Graph();
		graph.addEdge(1, 2, 10);
		graph.addEdge(2, 3, 5);
		
		graph.print();
	}
}
