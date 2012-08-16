
public class Dijkstra 
{
	public static final int GRAPH_SIZE = 1000;
	public static final int THREADS_NO = 4;
	public static final int INFINITY = 10000;
	
	public static void main(String[] args) 
	{
		newGraph graph = new newGraph();
		graph.fill(223);
				
		int [] path = graph.findPath(4, 1);
		for (int i : path)
		{
			System.out.println(i);
		}
	}
}
