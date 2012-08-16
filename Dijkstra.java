
public class Dijkstra 
{
	public static final int GRAPH_SIZE = 2000;
	public static final int THREADS_NO = 10;
	public static final int INFINITY = 10000;
	
	public static void main(String[] args) 
	{
		Graph graph = new Graph();
		graph.fill(42);
		
		
		int [] path = graph.findPath(4, 1);
		for (int i : path)
		{
			System.out.println(i);
		}
	}
}
