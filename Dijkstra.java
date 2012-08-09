
public class Dijkstra {
	public static final int GRAPH_SIZE = 5;
	public static final int INFINITY = 100;
	
	public static void main(String[] args) {
		Graph graph = new Graph();
		
		graph.addEdge(0, 1, 4);
		graph.addEdge(0, 2, 10);
		graph.addEdge(2, 3, 5);
		graph.addEdge(2, 4, 15);
		graph.addEdge(3, 4, 7);
		
		int [] path = graph.findPath(0, 4);
		for (int i : path)
		{
			System.out.println(i);
		}
	}
}
