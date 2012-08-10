
public class findPathRunnable implements Runnable {
	
	public findPathRunnable(Graph aGraph, int aI, int aPrev)
	{
		graph = aGraph;
		i = aI;
		prev = aPrev;
	}
	
	public void run()
	{
		// Finding previous
		if (graph.getData(i, prev) != 0 && 
					graph.getWeight(i) + graph.getData(i, prev) 
					== graph.getWeight(prev))
		{
			prev = i;
		}
	}
	
	private Graph graph;
	private int i;
	private int prev;
}
