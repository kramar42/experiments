import java.util.Random;
import java.util.Vector;

public class newGraph 
{
	public newGraph() 
	{
		this(Dijkstra.THREADS_NO, Dijkstra.GRAPH_SIZE);
	}
	public newGraph(int threadsNo)
	{
		this(threadsNo, Dijkstra.GRAPH_SIZE);
	}
	public newGraph(int threadsNo, int graphSize)
	{
		this.threadsNo = threadsNo;
		//vertices = new Vector<Integer>(graphSize);
		edges = new Vector<Vector<Edge>>(graphSize);
		
		for (int i = 0; i < graphSize; ++i)
		{
			edges.add(new Vector<Edge>());
		}
	}
	
	// ======= PUBLIC =======
	public void addEdge(int i, int j, int weight)
	{
		if (i == j) return;
		connectEdge(i, j, weight);
		connectEdge(j, i, weight);
	}
	
	public void fill(int seed)
	{
		Random random = new Random(seed);
		Thread []threads = new Thread[threadsNo];
		
		
		for (int thread = 0; thread < threadsNo; ++thread)
		{
			threads[thread] = new Thread(new fillThread(this, random, thread));
			threads[thread].start();
		}
		
		for (int thread = 0; thread < threadsNo; ++thread)
		{
			while (threads[thread].isAlive())
				try
				{
					Thread.sleep(50);
				} catch (InterruptedException e)
				{
					e.printStackTrace();
				}
		}
	}
	
	public void print()
	{
		int i = 0;
		for (Vector<Edge>row : edges)
		{
			for (Edge edge : row)
			{
				System.out.print("[ " + i + " ]");
				System.out.println(edge);
			}
			++i;
		}
	}
	
	public int[] findPath(int from, int to)
	{
		return new int[5];
	}
	
	// ======= PRIVATE =======
	private void connectEdge(int i, int j, int weight)
	{
		Vector<Edge> row = edges.get(i);
		Edge edge = new Edge(j, weight);
		
		if (row.contains(edge))
			row.remove(edge);
		row.add(edge);
	}
	
	private int threadsNo;
	//private Vector<Integer> vertices;
	private Vector<Vector<Edge>> edges;
	
	
	// ======= CLASS EDGE =======
	private class Edge
	{
		public Edge(int vertex, int weight)
		{
			this.vertex = vertex;
			this.weight = weight;
		}
		
		public boolean equals(Object obj)
		{
			if (this == obj) 
				return true;
			
			if (obj == null) 
				return false;
			
			if (getClass() != obj.getClass())
				return false;
			
			Edge edge = (Edge) obj;
			return vertex == edge.vertex;
		}
		
		public String toString()
		{
			return "[ " + vertex + " ] -> " + weight; 
		}
		
		private int vertex;
		private int weight;
	}
	
	
	// ======= CLASS FILLTHREAD =======
	private class fillThread implements Runnable
	{
		public fillThread(newGraph g, Random random, int thread)
		{
			this.outer = g;
			this.random = random;
			this.thread = thread;
		}
		
		public void run()
		{
			int workPerThread = Dijkstra.GRAPH_SIZE / outer.threadsNo;
			
			for (int i = thread * workPerThread; 
					i < (thread + 1) * workPerThread; ++i)
			{
				for (int j = 0; j < Dijkstra.GRAPH_SIZE / 3; ++j)
				{
					outer.addEdge(i, random.nextInt(Dijkstra.GRAPH_SIZE), 
							random.nextInt(Dijkstra.INFINITY));
				}
			}
		}
		
		// ======= PRIVATE =======
		private newGraph outer;
		private Random random;
		private int thread;
	}
}
