
public class calculateWeightsRunnable implements Runnable {
	
	public calculateWeightsRunnable(Graph aGraph, int aCurrent, int aI)
	{
		graph = aGraph;
		current = aCurrent;
		i = aI;
	}
	
	public void run()
	{
		graph.lock();
		
		try
		{
			// If are connected
			if (graph.getData(current, i) != 0 && !graph.isVisited(i))
			{
				int newWeight = graph.getWeight(current) + graph.getData(current, i);
				newWeight = newWeight < graph.getWeight(i) ? 
						newWeight : graph.getWeight(i);
				graph.setWeight(i, newWeight); 
			}
		}
		finally
		{
			graph.unlock();
		}
	}
	
	private Graph graph;
	private int current;
	private int i;
}
