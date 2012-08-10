import java.util.Random;

public class Dijkstra {
	public static final int GRAPH_SIZE = 5000;
	public static final int INFINITY = 1000000;
	
	public static void main(String[] args) {
		Graph graph = new Graph();
		Random random = new Random();
		
		for (int i = 0; i < GRAPH_SIZE; ++i)
		{
			for (int j = 0; j < GRAPH_SIZE / 3; ++j)
			{
				graph.addEdge(i, random.nextInt(GRAPH_SIZE), 
						random.nextInt(INFINITY));
			}
		}
		
		int [] path = graph.findPath(4, 1);
		for (int i : path)
		{
			System.out.println(i);
		}
	}
}
